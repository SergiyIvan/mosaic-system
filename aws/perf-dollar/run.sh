#!/bin/bash

# Note - this script assumes Ansible and Terraform are installed.
# Besides, AWS credentials must be put into environment.
# Insert all the values in the 'setup.sh' script in the root of the repository.

function DIR {
    echo "$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
}

set -e

if [ -z "$GITHUB_TOKEN" ]; then
    echo "Error: GITHUB_TOKEN environment variable is not set."
    echo "Usage: GITHUB_TOKEN=ghp_yourtoken ./run.sh"
    exit 1
fi

# ==========================================
# Leave empty ("") to run all benchmarks.
TARGET_BENCHMARKS=""
# ==========================================

# Extract the dynamically generated S3 bucket name from Terraform output.
cd $(DIR)/../setup-s3
S3_BUCKET=$(terraform output -raw s3_bucket_name)
cd -
echo "  S3 Bucket with compiled artifacts: $S3_BUCKET"

RESULT_DIR=$(DIR)/results
mkdir -p $RESULT_DIR/c7i
mkdir -p $RESULT_DIR/c7a
mkdir -p $RESULT_DIR/c7g

echo "[1/4] Spinning up AWS Instances (Terraform)..."
terraform init
terraform apply -auto-approve

# Wait a few seconds for SSH to fully wake up on the new instances.
echo "  Waiting for SSH to initialize..."
sleep 30

echo "[2/4] Provisioning and Benchmarking (Ansible)..."
# Passing the GitHub token as an extra variable to Ansible.
ansible-playbook -i inventory.ini bench.yml \
    --extra-vars "github_token=$GITHUB_TOKEN repo_url=github.com/SergiyIvan/mosaic-system.git s3_bucket=$S3_BUCKET target_benchmarks='$TARGET_BENCHMARKS'"

echo "[3/4] Benchmarks complete! Results downloaded to $RESULT_DIR directory."

echo "[4/4] Tearing down AWS Instances (Terraform)..."
terraform destroy -auto-approve

echo "Finished!"
