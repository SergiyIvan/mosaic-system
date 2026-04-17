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
CUSTOM_BENCHMARKS=$4  # Optional parameter.

RESULT_DIR="$(DIR)/../plots/mosaic-throughput"
ARTIFACTS_DIR="$(DIR)/../artifacts"

FFMPEG_BACKUP_BINARY=/tmp/ffmpeg_default_backup
FFMPEG_MAIN_BINARY=/tmp/ffmpeg

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

if [ -n "$CUSTOM_BENCHMARKS" ]; then
    # Custom subset of benchmarks provided, overwriting the BENCHMARKS array.
    read -r -a BENCHMARKS <<< "$CUSTOM_BENCHMARKS"
fi


function ensure_correct_ffmpeg {
    config=$1
    bench=$2

    if [ "$bench" == "video-processing" ]; then
        if [ "$config" != "default" ]; then
            # Swapping FFmpeg to optimized version.

            # Download FFmpeg from S3 if we haven't already.
            ffmpeg_dir="$ARTIFACTS_DIR/ffmpeg/$config"
            mkdir -p "$ffmpeg_dir"
            if [ ! -f "$ffmpeg_dir/ffmpeg" ]; then
                aws s3 cp "s3://$S3_BUCKET/$ARCH_FOLDER/ffmpeg/${config}/ffmpeg" "$ffmpeg_dir/ffmpeg"
                chmod +x "$ffmpeg_dir/ffmpeg"
            fi

            # Overwrite the existing binary.
            cp "$ffmpeg_dir/ffmpeg" $FFMPEG_MAIN_BINARY
        else
            # Ensuring default portable FFmpeg is used.
            cp "$FFMPEG_BACKUP_BINARY" "$FFMPEG_MAIN_BINARY"
        fi
    fi
}

function restore_ffmpeg {
    bench=$1

    if [ "$bench" == "video-processing" ]; then
        cp "$FFMPEG_BACKUP_BINARY" "$FFMPEG_MAIN_BINARY"
    fi
}


echo "=========================================="
echo " Starting AWS Execution Phase"
echo "=========================================="


# Backup the default binary so we can restore it later.
if [ -f "$FFMPEG_MAIN_BINARY" ]; then
    cp "$FFMPEG_MAIN_BINARY" "$FFMPEG_BACKUP_BINARY"
fi


for config in $CONFIGS; do
    echo "=========================================="
    echo " Processing Mode: $config"
    echo "=========================================="

    # ----------------------------------------
    # 1. NATIVE EXECUTION
    # ----------------------------------------
    echo "Setting up Native Artifacts ($config)..."
    native_dir="$ARTIFACTS_DIR/native/$config"
    mkdir -p "$native_dir"

    result_file="$RESULT_DIR/result-native-$config.json"
    rm -f "$result_file"
    echo "[" > "$result_file"
    first_item=true

    for bench in "${BENCHMARKS[@]}"; do
        ensure_correct_ffmpeg $config $bench

        if [ ! -f "$native_dir/$bench" ]; then
            aws s3 cp "s3://$S3_BUCKET/$ARCH_FOLDER/native/$config/$bench/$bench" "$native_dir/$bench"
            chmod +x "$native_dir/$bench"
        fi

        echo "Running Native [$bench] - $ITERATIONS iterations..."
        for ((i=1; i<=ITERATIONS; i++)); do
            if [ "$first_item" = true ]; then first_item=false; else echo "," >> "$result_file"; fi

            # Execute directly from the flat artifact folder.
            "$native_dir/$bench" $BENCHMARK_DURATION $WARMUP_ITERATIONS >> "$result_file"
        done
        echo "" >> "$result_file"

        restore_ffmpeg $bench
    done
    echo "]" >> "$result_file"

    # ----------------------------------------
    # 2. MOSAIC EXECUTION (Skipping 'default')
    # ----------------------------------------
    if [ "$config" != "default" ]; then
        echo "Setting up Mosaic Artifacts ($config)..."
        mosaic_dir="$ARTIFACTS_DIR/mosaic/$config"
        mkdir -p "$mosaic_dir"

        result_file="$RESULT_DIR/result-mosaic-$config.json"
        rm -f "$result_file"
        echo "[" > "$result_file"
        first_item=true

        for bench in "${BENCHMARKS[@]}"; do
            ensure_correct_ffmpeg $config $bench

            # Replacing hyphens with underscores for Wasm files (following file naming convention).
            wasm_file="${bench//-/_}.wasm"

            if [ ! -f "$mosaic_dir/$bench" ]; then
                aws s3 cp "s3://$S3_BUCKET/$ARCH_FOLDER/mosaic/$config/$bench/$bench" "$mosaic_dir/$bench"
                aws s3 cp "s3://$S3_BUCKET/$ARCH_FOLDER/mosaic/$config/$bench/$wasm_file" "$mosaic_dir/$wasm_file"
                chmod +x "$mosaic_dir/$bench"
            fi

            echo "Running Mosaic [$bench] - $ITERATIONS iterations..."

            for ((i=1; i<=ITERATIONS; i++)); do
                if [ "$first_item" = true ]; then first_item=false; else echo "," >> "$result_file"; fi

                # Execute directly from the flat artifact folder.
                "$mosaic_dir/$bench" $BENCHMARK_DURATION $WARMUP_ITERATIONS "$mosaic_dir/$wasm_file" >> "$result_file"
            done
            echo "" >> "$result_file"

            restore_ffmpeg $bench
        done
        echo "]" >> "$result_file"
    fi
done

echo "=========================================="
echo " All executions finished! Check $RESULT_DIR "
echo "=========================================="
