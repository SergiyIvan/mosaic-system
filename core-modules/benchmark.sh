#!/bin/bash

set -e

ITERATIONS=10
RESULT_FILE="plots/result.json"

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
    for BENCH in "${BENCHMARKS[@]}"; do
        echo "Compiling [$BENCH]..."

        cd "$BENCH/guest"
        cargo build --release --target wasm32-wasip1 --quiet
        cd "../../$BENCH/host"
        cargo build --release --quiet
        cd ../..
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

        cd "$BENCH/host"
        for ((i=1; i<=ITERATIONS; i++)); do
            echo "  Running iteration $i/$ITERATIONS..."

            if [ "$FIRST_ITEM" = true ]; then
                FIRST_ITEM=false
            else
                echo "," >> "../../$RESULT_FILE"
            fi

            cargo run --release --quiet >> "../../$RESULT_FILE"
        done
        cd ../..
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
