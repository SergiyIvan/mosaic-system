#!/bin/bash

function DIR {
    echo "$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
}

set -e

BENCHMARKS=(
    bfs
    classify
    compression
    dna
    dynamic-html
    mst
    pagerank
    thumbnailer
    uploader
    video-processing
)

if [[ $# -ne 1 ]]; then
    echo "Usage: $0 <profile>"
    echo "Example: $0 build-native"
    exit 1
fi

PROFILE=$1

echo "Building all benchmarks for local execution as $PROFILE."

for bench in "${BENCHMARKS[@]}"; do
    bench_host_dir="$(DIR)/$bench/host"
    bench_guest_dir="$(DIR)/$bench/guest-local"
    echo ""
    echo "  Building $bench"
    (cd "$bench_guest_dir" && cargo build --release)
    (cd "$bench_host_dir" && cargo "build-$PROFILE")
done

echo ""
echo "Finished building all benchmarks!"
