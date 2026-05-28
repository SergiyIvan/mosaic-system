provider "aws" {
  region = "us-east-1"
}


# ==========================================
# NETWORKING (VPC & Subnet)
# ==========================================
resource "aws_vpc" "bench_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = { Name = "Mosaic-Bench-VPC" }
}

resource "aws_internet_gateway" "bench_igw" {
  vpc_id = aws_vpc.bench_vpc.id
  tags = { Name = "Mosaic-Bench-IGW" }
}

resource "aws_subnet" "bench_subnet" {
  vpc_id                  = aws_vpc.bench_vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true # Gives instances a public IP for SSH.
  availability_zone       = "us-east-1b" # ------ Here we hard-code availability zone!!!
  tags = { Name = "Mosaic-Bench-Subnet" }
}

resource "aws_route_table" "bench_rt" {
  vpc_id = aws_vpc.bench_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.bench_igw.id
  }
}

resource "aws_route_table_association" "bench_rta" {
  subnet_id      = aws_subnet.bench_subnet.id
  route_table_id = aws_route_table.bench_rt.id
}


# ==========================================
# SSH KEY GENERATION
# ==========================================
# Generate a temporary SSH key for the experiment.
resource "tls_private_key" "bench_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name   = "mosaic-bench-key"
  public_key = tls_private_key.bench_key.public_key_openssh
}

resource "local_file" "private_key" {
  content         = tls_private_key.bench_key.private_key_pem
  filename        = "${path.module}/mosaic-bench-key.pem"
  file_permission = "0400"
}


# ==========================================
# SECURITY GROUP
# ==========================================
resource "aws_security_group" "bench_sg" {
  name   = "mosaic_bench_sg"
  vpc_id = aws_vpc.bench_vpc.id # Attached to our VPC.

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


# ==========================================
# S3 BUCKET & IAM INSTANCE PROFILE
# ==========================================
resource "aws_iam_role" "ec2_s3_role" {
  name = "mosaic_bench_s3_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = { Service = "ec2.amazonaws.com" }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "s3_full_access" {
  role       = aws_iam_role.ec2_s3_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_iam_instance_profile" "ec2_s3_profile" {
  name = "mosaic_bench_s3_profile"
  role = aws_iam_role.ec2_s3_role.name
}


# ==========================================
# AMIs (x86 AND ARM64)
# ==========================================
data "aws_ami" "ubuntu_x86" {
  most_recent = true
  owners      = ["099720109477"]
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

data "aws_ami" "ubuntu_arm" {
  most_recent = true
  owners      = ["099720109477"]
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-arm64-server-*"]
  }
}


# ==========================================
# INSTANCES
# ==========================================
resource "aws_instance" "intel_c7i" {
  ami                  = data.aws_ami.ubuntu_x86.id
  instance_type        = "c7i.4xlarge"
  subnet_id            = aws_subnet.bench_subnet.id
  key_name             = aws_key_pair.generated_key.key_name
  vpc_security_group_ids = [aws_security_group.bench_sg.id]
  iam_instance_profile = aws_iam_instance_profile.ec2_s3_profile.name
  tags = { Name = "Mosaic-Bench-Intel-C7i" }

  # Disable Hyperthreading.
  cpu_options {
    core_count       = 8
    threads_per_core = 1
  }

  # Storage.
  root_block_device {
    volume_size = 60
    volume_type = "gp3"
  }
}

resource "aws_instance" "amd_c7a" {
  ami                  = data.aws_ami.ubuntu_x86.id
  instance_type        = "c7a.4xlarge"
  subnet_id            = aws_subnet.bench_subnet.id
  key_name             = aws_key_pair.generated_key.key_name
  vpc_security_group_ids = [aws_security_group.bench_sg.id]
  iam_instance_profile = aws_iam_instance_profile.ec2_s3_profile.name
  tags = { Name = "Mosaic-Bench-AMD-C7a" }

  # Storage.
  root_block_device {
    volume_size = 60
    volume_type = "gp3"
  }
}

resource "aws_instance" "graviton_c7g" {
  ami                  = data.aws_ami.ubuntu_arm.id
  instance_type        = "c7g.4xlarge"
  subnet_id            = aws_subnet.bench_subnet.id
  key_name             = aws_key_pair.generated_key.key_name
  vpc_security_group_ids = [aws_security_group.bench_sg.id]
  iam_instance_profile = aws_iam_instance_profile.ec2_s3_profile.name
  tags = { Name = "Mosaic-Bench-Graviton-C7g" }

  # Storage.
  root_block_device {
    volume_size = 60
    volume_type = "gp3"
  }
}


# ==========================================
# OUTPUT INVENTORY
# ==========================================
# Output the IPs and create the Ansible Inventory.
resource "local_file" "ansible_inventory" {
  content = <<-DOC
    [intel]
    c7i ansible_host=${aws_instance.intel_c7i.public_ip} ansible_user=ubuntu ansible_ssh_private_key_file=./mosaic-bench-key.pem ansible_ssh_common_args='-o StrictHostKeyChecking=no' machine_folder="c7i"

    [amd]
    c7a ansible_host=${aws_instance.amd_c7a.public_ip} ansible_user=ubuntu ansible_ssh_private_key_file=./mosaic-bench-key.pem ansible_ssh_common_args='-o StrictHostKeyChecking=no' machine_folder="c7a"

    [graviton]
    c7g ansible_host=${aws_instance.graviton_c7g.public_ip} ansible_user=ubuntu ansible_ssh_private_key_file=./mosaic-bench-key.pem ansible_ssh_common_args='-o StrictHostKeyChecking=no' machine_folder="c7g"
    DOC
  filename = "${path.module}/inventory.ini"
}
