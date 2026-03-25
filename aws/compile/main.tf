provider "aws" {
  region = "us-east-1"
}


# ==========================================
# NETWORKING & SSH KEYS
# ==========================================
resource "aws_vpc" "comp_vpc" {
  cidr_block           = "10.1.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
}

resource "aws_internet_gateway" "comp_igw" {
  vpc_id = aws_vpc.comp_vpc.id
}

resource "aws_subnet" "comp_subnet" {
  vpc_id                  = aws_vpc.comp_vpc.id
  cidr_block              = "10.1.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1b" # ------ Here we hard-code availability zone!!!
}

resource "aws_route_table" "comp_rt" {
  vpc_id = aws_vpc.comp_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.comp_igw.id
  }
}

resource "aws_route_table_association" "comp_rta" {
  subnet_id      = aws_subnet.comp_subnet.id
  route_table_id = aws_route_table.comp_rt.id
}

resource "tls_private_key" "comp_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name   = "mosaic-comp-key"
  public_key = tls_private_key.comp_key.public_key_openssh
}

resource "local_file" "private_key" {
  content         = tls_private_key.comp_key.private_key_pem
  filename        = "${path.module}/mosaic-comp-key.pem"
  file_permission = "0400"
}

resource "aws_security_group" "comp_sg" {
  name   = "mosaic_comp_sg"
  vpc_id = aws_vpc.comp_vpc.id
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
# IAM Role so EC2 can upload to S3 without AWS keys.
resource "aws_iam_role" "ec2_s3_role" {
  name = "mosaic_ec2_s3_role"
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
  name = "mosaic_ec2_s3_profile"
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
# INSTANCES (xlarge for compilation)
# ==========================================
resource "aws_instance" "intel_c7i" {
  ami                  = data.aws_ami.ubuntu_x86.id
  instance_type        = "c7i.xlarge"
  subnet_id            = aws_subnet.comp_subnet.id
  key_name             = aws_key_pair.generated_key.key_name
  vpc_security_group_ids = [aws_security_group.comp_sg.id]
  iam_instance_profile = aws_iam_instance_profile.ec2_s3_profile.name
  tags = { Name = "Mosaic-Comp-Intel-C7i" }
  # Storage.
  root_block_device {
    volume_size = 40
    volume_type = "gp3"
  }
}

resource "aws_instance" "amd_c7a" {
  ami                  = data.aws_ami.ubuntu_x86.id
  instance_type        = "c7a.xlarge"
  subnet_id            = aws_subnet.comp_subnet.id
  key_name             = aws_key_pair.generated_key.key_name
  vpc_security_group_ids = [aws_security_group.comp_sg.id]
  iam_instance_profile = aws_iam_instance_profile.ec2_s3_profile.name
  tags = { Name = "Mosaic-Comp-AMD-C7a" }
  # Storage.
  root_block_device {
    volume_size = 40
    volume_type = "gp3"
  }
}

resource "aws_instance" "graviton_c7g" {
  ami                  = data.aws_ami.ubuntu_arm.id
  instance_type        = "c7g.xlarge"
  subnet_id            = aws_subnet.comp_subnet.id
  key_name             = aws_key_pair.generated_key.key_name
  vpc_security_group_ids = [aws_security_group.comp_sg.id]
  iam_instance_profile = aws_iam_instance_profile.ec2_s3_profile.name
  tags = { Name = "Mosaic-Comp-Graviton-C7g" }
  # Storage.
  root_block_device {
    volume_size = 40
    volume_type = "gp3"
  }
}

# ==========================================
# OUTPUTS
# ==========================================
resource "local_file" "ansible_inventory" {
  content = <<-DOC
    [intel]
    c7i ansible_host=${aws_instance.intel_c7i.public_ip} ansible_user=ubuntu ansible_ssh_private_key_file=./mosaic-comp-key.pem ansible_ssh_common_args='-o StrictHostKeyChecking=no' configs="default native x86-64-v3"

    [amd]
    c7a ansible_host=${aws_instance.amd_c7a.public_ip} ansible_user=ubuntu ansible_ssh_private_key_file=./mosaic-comp-key.pem ansible_ssh_common_args='-o StrictHostKeyChecking=no' configs="default native x86-64-v3"

    [graviton]
    c7g ansible_host=${aws_instance.graviton_c7g.public_ip} ansible_user=ubuntu ansible_ssh_private_key_file=./mosaic-comp-key.pem ansible_ssh_common_args='-o StrictHostKeyChecking=no' configs="default native neoverse-v1"
    DOC
  filename = "${path.module}/inventory.ini"
}
