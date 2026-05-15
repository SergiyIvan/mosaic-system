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
GUESTS_DIR="$DATA_DIR/wasm"
TRAMPOLINES_DIR="$DATA_DIR/trampoline"
TRAMPOLINES_SRC_DIR="$(DIR)/trampolines"

echo "Building and installing all benchmark guests."

mkdir -p "$GUESTS_DIR"

for bench in "${BENCHMARKS[@]}"; do
    bench_guest_dir="$(DIR)/$bench/guest"
    echo ""
    echo "  Building $bench"
    (cd "$bench_guest_dir" && cargo build --release)
    cp $bench_guest_dir/target/wasm32-wasip1/release/*.wasm $GUESTS_DIR
done

echo ""
echo "Finished building and installing all benchmark guests!"


echo "Building and installing all benchmark trampolines."

for profile in "${PROFILES[@]}"; do
    echo ""
    echo "  Compiling trampolines for profile: [$profile]"
    PROFILE_OUT_DIR="$TRAMPOLINES_DIR/$profile"
    mkdir -p "$PROFILE_OUT_DIR"

    for tramp_dir in "$TRAMPOLINES_SRC_DIR"/*/; do
        # Skip if not a directory.
        [ -d "$tramp_dir" ] || continue

        echo "  Building Trampoline: $(basename "$tramp_dir")"

        (cd "$tramp_dir" && rm -rf Cargo.lock target)
        (cd "$tramp_dir" && bash build.sh "$profile")
        cp "$tramp_dir/target/release/"*.so "$PROFILE_OUT_DIR"
    done
done

echo ""
echo "Finished building and installing all benchmark trampolines!"
