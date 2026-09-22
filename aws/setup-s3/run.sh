#!/bin/bash

# Note - this script assumes Ansible and Terraform are installed.
# Besides, AWS credentials must be put into environment.
# Insert all the values in the 'setup.sh' script in the root of the repository.

function DIR {
    echo "$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
}

set -e

echo "Spinning up S3 bucket (Terraform)..."
terraform init
terraform apply -auto-approve

# Extract the dynamically generated S3 bucket name from Terraform output.
S3_BUCKET=$(terraform output -raw s3_bucket_name)
echo "  Target S3 Bucket: $S3_BUCKET"

echo "Finished!"
