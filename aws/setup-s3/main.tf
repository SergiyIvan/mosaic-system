provider "aws" {
  region = "us-east-1"
}

resource "random_string" "bucket_suffix" {
  length  = 8
  special = false
  upper   = false
}

resource "aws_s3_bucket" "artifacts_bucket" {
  bucket        = "mosaic-bench-artifacts-${random_string.bucket_suffix.result}"
  force_destroy = true
}

output "s3_bucket_name" {
  value = aws_s3_bucket.artifacts_bucket.bucket
}
