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
# Leave empty ("") to compile all benchmarks.
TARGET_BENCHMARKS=""
# ==========================================

echo "[1/3] Spinning up compilation instances (Terraform)..."
terraform init
terraform apply -auto-approve

# Extract the dynamically generated S3 bucket name from Terraform output.
cd $(DIR)/../setup-s3
S3_BUCKET=$(terraform output -raw s3_bucket_name)
cd -
echo "  Target S3 Bucket: $S3_BUCKET"

# Wait a few seconds for SSH to fully wake up on the new instances.
echo "  Waiting for SSH to initialize..."
sleep 30

echo "[2/3] Compiling and Uploading (Ansible)..."
ansible-playbook -i inventory.ini compile.yml \
    --extra-vars "github_token=$GITHUB_TOKEN target_bucket=$S3_BUCKET repo_url=github.com/SergiyIvan/mosaic-system.git target_benchmarks='$TARGET_BENCHMARKS'"

echo "  Compilation complete! All artifacts are safely stored in S3."

echo "[3/3] Destroying compilation instances (Terraform)..."
terraform destroy -auto-approve

echo "Finished!"
