#!/bin/bash

# Note - this script assumes Ansible and Terraform are installed.
# Besides, AWS credentials must be put into environment.
# Insert all the values in the 'setup.sh' script in the root of the repository.

function DIR {
    echo "$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
}

set -e

# Extract the dynamically generated S3 bucket name from Terraform output.
cd "$(DIR)/../setup-s3"
S3_BUCKET=$(terraform output -raw s3_bucket_name)
cd - > /dev/null
echo "=========================================="
echo "S3 Bucket with artifacts: $S3_BUCKET"
echo "=========================================="

RESULT_DIR="$(DIR)/results"
mkdir -p "$RESULT_DIR/c7i"
mkdir -p "$RESULT_DIR/c7a"
mkdir -p "$RESULT_DIR/c7g"

echo "[1/4] Spinning up AWS Instances (Terraform)..."
terraform init
terraform apply -auto-approve

# Wait a few seconds for SSH to fully wake up on the new instances.
echo "  Waiting for SSH to initialize..."
sleep 30

echo "[2/4] Provisioning and Benchmarking (Ansible)..."
# Disable host key checking so Ansible doesn't prompt for SSH fingerprint confirmations
export ANSIBLE_HOST_KEY_CHECKING=False
# Passing the GitHub token as an extra variable to Ansible.
ansible-playbook -i inventory.ini bench.yml \
    --extra-vars "s3_bucket=$S3_BUCKET"

echo "[3/4] Benchmarks complete! Results downloaded to $RESULT_DIR directory."

echo "[4/4] Tearing down AWS Instances (Terraform)..."
terraform destroy -auto-approve

echo "Finished!"
