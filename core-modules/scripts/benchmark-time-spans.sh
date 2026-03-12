#!/bin/bash

function DIR {
    echo "$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
}

set -e

ITERATIONS=10
RESULT_FILE="$(DIR)/../plots/mosaic-time-spans/result.json"
BENCHMARKS_DIR="$(DIR)/../mosaic-time-spans"
RUNNER_DIR="$(DIR)/../runner"

BENCHMARKS=(
    "bfs"
    "compression"
    "dna"
    "dynamic-html"
    "mst"
    "pagerank"
    "thumbnailer"
    "video-processing"
    "uploader"
    "classify"
)

function build_benchmarks {
    echo "==================================="
    echo "   Building all guests and hosts   "
    echo "==================================="

    cd "$RUNNER_DIR"
    cargo build --release --quiet
    cd -

    for BENCH in "${BENCHMARKS[@]}"; do
        echo "Compiling [$BENCH]..."
        BENCH_DIR="$BENCHMARKS_DIR/$BENCH"

        cd "$BENCH_DIR/guest"
        cargo build --release --target wasm32-wasip1 --quiet
        cd "$BENCH_DIR/host"
        cargo build --release --quiet
        cd $BENCHMARKS_DIR
    done
    echo "All builds completed successfully."
    echo ""
}

function run_benchmarks {
    echo "==================================="
    echo "        Running  Benchmarks        "
    echo "==================================="

    echo "[" > "$RESULT_FILE"
    FIRST_ITEM=true

    for BENCH in "${BENCHMARKS[@]}"; do
        echo "Starting [$BENCH] - $ITERATIONS iterations..."
        BENCH_DIR="$BENCHMARKS_DIR/$BENCH"

        cd "$BENCH_DIR/host"
        for ((i=1; i<=ITERATIONS; i++)); do
            echo "  Running iteration $i/$ITERATIONS..."

            if [ "$FIRST_ITEM" = true ]; then
                FIRST_ITEM=false
            else
                echo "," >> "$RESULT_FILE"
            fi

            cargo run --release --quiet >> "$RESULT_FILE"
        done
        cd $BENCHMARKS_DIR
        echo "Finished [$BENCH]."
        echo "" >> "$RESULT_FILE"
    done
    echo "]" >> "$RESULT_FILE"
}

rm -f $RESULT_FILE

# build_benchmarks
run_benchmarks

echo "=========================================="
echo " All benchmarks finished! Check $RESULT_FILE "
echo "=========================================="
