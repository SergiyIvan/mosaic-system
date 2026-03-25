#!/bin/bash

# NOTE: this script is not intended to be used directly!
# It is expected to be called from the Ansible playbook.

function DIR {
    echo "$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
}

set -e

CONFIGS=$1
S3_BUCKET=$2
MACHINE_ALIAS=$3

BENCHMARKS=("bfs" "compression" "dna" "dynamic-html" "mst" "pagerank" "thumbnailer" "uploader" "classify" "video-processing")
BENCHMARKS_HOME=$(DIR)/../../core-modules/native

cd $BENCHMARKS_HOME

# Iterate over the configs string (e.g., "default native x86-64-v3").
for CONFIG in $CONFIGS; do
    echo "Building Native: $CONFIG"

    # Compile.
    for bench in "${BENCHMARKS[@]}"; do
        cd $bench
        cargo build-$CONFIG
        cd ..
    done

    # Extract binaries.
    tmp_dir="/tmp/result_$CONFIG"
    mkdir -p $tmp_dir

    for bench in "${BENCHMARKS[@]}"; do
        cp "$BENCHMARKS_HOME/$bench/target/release/$bench" "$tmp_dir/"
    done

    zip_name="native_${CONFIG}.zip"
    zip -j $zip_name $tmp_dir/*

    rm -rf $tmp_dir

    aws s3 cp $zip_name s3://$S3_BUCKET/$MACHINE_ALIAS/native/${CONFIG}.zip
done
