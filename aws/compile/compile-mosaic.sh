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
CUSTOM_BENCHMARKS=$4

BENCHMARKS=("bfs" "compression" "dna" "dynamic-html" "mst" "pagerank" "thumbnailer" "uploader" "classify" "video-processing")
BENCHMARKS_HOME=$(DIR)/../../core-modules/mosaic

if [ -n "$CUSTOM_BENCHMARKS" ]; then
    # Custom subset of benchmarks provided, overwriting the BENCHMARKS array.
    read -r -a BENCHMARKS <<< "$CUSTOM_BENCHMARKS"
fi

cd $BENCHMARKS_HOME

# Iterate over the configs string (e.g., "default native x86-64-v3").
for CONFIG in $CONFIGS; do
    # Skip "default" for Mosaic.
    if [ "$CONFIG" == "default" ]; then continue; fi

    echo "Building Mosaic: $CONFIG"

    for bench in "${BENCHMARKS[@]}"; do
        echo "  Compiling $bench"
        cd $bench/guest
        cargo build --release
        cd ../host
        cargo build-$CONFIG
        cd ../..

        wasm_file="${bench//-/_}.wasm"
        aws s3 cp "$BENCHMARKS_HOME/$bench/host/target/release/$bench" "s3://$S3_BUCKET/$MACHINE_ALIAS/mosaic/$CONFIG/$bench/$bench"
        aws s3 cp "$BENCHMARKS_HOME/$bench/guest/target/wasm32-wasip1/release/$wasm_file" "s3://$S3_BUCKET/$MACHINE_ALIAS/mosaic/$CONFIG/$bench/$wasm_file"
    done
done
