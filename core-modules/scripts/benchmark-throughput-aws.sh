#!/bin/bash

function DIR {
    echo "$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
}

set -e

if [ -z "$ITERATIONS" ]; then ITERATIONS=10; fi
if [ -z "$BENCHMARK_DURATION" ]; then BENCHMARK_DURATION=30; fi
if [ -z "$WARMUP_ITERATIONS" ]; then WARMUP_ITERATIONS=10; fi

CONFIGS=$1
S3_BUCKET=$2
ARCH_FOLDER=$3

RESULT_DIR="$(DIR)/../plots/mosaic-throughput"
ARTIFACTS_DIR="$(DIR)/../artifacts"

mkdir -p "$RESULT_DIR"
mkdir -p "$ARTIFACTS_DIR"

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

echo "=========================================="
echo " Starting AWS Execution Phase"
echo "=========================================="

for config in $CONFIGS; do
    echo "=========================================="
    echo " Processing Mode: $config"
    echo "=========================================="

    # ----------------------------------------
    # 1. NATIVE EXECUTION
    # ----------------------------------------
    echo "Downloading Native Artifacts ($config)..."
    native_dir="$ARTIFACTS_DIR/native/$config"
    mkdir -p "$native_dir"

    aws s3 cp "s3://$S3_BUCKET/$ARCH_FOLDER/native/${config}.zip" "$native_dir/native.zip"
    unzip -q -j "$native_dir/native.zip" -d "$native_dir"
    chmod +x "$native_dir"/*

    result_file="$RESULT_DIR/result-native-$config.json"
    rm -f "$result_file"
    echo "[" > "$result_file"
    first_item=true

    for bench in "${BENCHMARKS[@]}"; do
        echo "Running Native [$bench] - $ITERATIONS iterations..."
        for ((i=1; i<=ITERATIONS; i++)); do
            if [ "$first_item" = true ]; then first_item=false; else echo "," >> "$result_file"; fi

            # Execute directly from the flat artifact folder.
            "$native_dir/$bench" $BENCHMARK_DURATION $WARMUP_ITERATIONS >> "$result_file"
        done
        echo "" >> "$result_file"
    done
    echo "]" >> "$result_file"

    # ----------------------------------------
    # 2. MOSAIC EXECUTION (Skipping 'default')
    # ----------------------------------------
    if [ "$config" != "default" ]; then
        echo "Downloading Mosaic Artifacts ($config)..."
        mosaic_dir="$ARTIFACTS_DIR/mosaic/$config"
        mkdir -p "$mosaic_dir"

        aws s3 cp "s3://$S3_BUCKET/$ARCH_FOLDER/mosaic/${config}.zip" "$mosaic_dir/mosaic.zip"
        unzip -q -j "$mosaic_dir/mosaic.zip" -d "$mosaic_dir"
        chmod +x "$mosaic_dir"/*

        result_file="$RESULT_DIR/result-mosaic-$config.json"
        rm -f "$result_file"
        echo "[" > "$result_file"
        first_item=true

        for bench in "${BENCHMARKS[@]}"; do
            echo "Running Mosaic [$bench] - $ITERATIONS iterations..."

            # Replacing hyphens with underscores for Wasm files (following file naming convention).
            wasm_file="${bench//-/_}.wasm"

            for ((i=1; i<=ITERATIONS; i++)); do
                if [ "$first_item" = true ]; then first_item=false; else echo "," >> "$result_file"; fi

                # Execute directly from the flat artifact folder.
                "$mosaic_dir/$bench" $BENCHMARK_DURATION $WARMUP_ITERATIONS "$mosaic_dir/$wasm_file" >> "$result_file"
            done
            echo "" >> "$result_file"
        done
        echo "]" >> "$result_file"
    fi
done

echo "=========================================="
echo " All executions finished! Check $RESULT_DIR "
echo "=========================================="
