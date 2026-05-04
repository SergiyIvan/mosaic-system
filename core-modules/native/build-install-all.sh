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

PROFILES=("$@")
if [ ${#PROFILES[@]} -eq 0 ]; then
    # Default profiles if none are provided.
    PROFILES=("native" "default")
fi

DATA_DIR="$(DIR)/../../data/apps"
NATIVE_DIR="$DATA_DIR/native"

echo "Building all benchmarks."

for profile in "${PROFILES[@]}"; do
    echo ""
    echo "  Compiling benchmarks for profile: [$profile]"
    PROFILE_OUT_DIR="$NATIVE_DIR/$profile"
    mkdir -p "$PROFILE_OUT_DIR"

    for bench in "${BENCHMARKS[@]}"; do
        bench_dir="$(DIR)/$bench"
        echo ""
        echo "  Building $bench"
        (cd "$bench_dir" && rm -rf Cargo.lock target)
        (cd "$bench_dir" && cargo "build-$profile")
        cp "$bench_dir/target/release/"*.so "$PROFILE_OUT_DIR"
    done
done

echo ""
echo "Finished building all benchmarks!"
