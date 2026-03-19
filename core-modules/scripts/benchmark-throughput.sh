#!/bin/bash

function DIR {
    echo "$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
}

set -e


if [ -z "$ITERATIONS" ]; then
    ITERATIONS=10
fi

if [ -z "$BENCHMARK_DURATION" ]; then
    BENCHMARK_DURATION=30
fi

if [ -z "$WARMUP_ITERATIONS" ]; then
    WARMUP_ITERATIONS=10
fi

RESULT_DIR="$(DIR)/../plots/mosaic-throughput"
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

CONFIGS=("default" "native" "x86-64-v3")

declare -A BENCHMARK_HOME
BENCHMARK_HOME[mosaic]="$(DIR)/../mosaic"
BENCHMARK_HOME[native]="$(DIR)/../native"


# ----- ARGUMENT VALIDATION -----
if [ "$#" -eq 0 ]; then
    echo "Error: No configuration provided."
    echo "Usage: $0 [config1] [config2] ..."
    echo "Available configs: ${CONFIGS[*]}"
    exit 1
fi

# Check if every provided argument is in the allowed CONFIGS array.
for provided_config in "$@"; do
    is_valid=false
    for valid_config in "${CONFIGS[@]}"; do
        if [ "$provided_config" == "$valid_config" ]; then
            is_valid=true
            break
        fi
    done

    if [ "$is_valid" = false ]; then
        echo "Error: Unknown config mode '$provided_config' provided!"
        echo "Allowed configs are: ${CONFIGS[*]}"
        exit 1
    fi
done
# ------------------------------


function build_mosaic_benchmarks {
    config=$1
    mode="mosaic"

    echo "===================================================="
    echo "Building all guests and hosts for ($mode-$config)"
    echo "===================================================="

    benchmarks_home=${BENCHMARK_HOME["$mode"]}
    build_command="build-$config"

    cd "$RUNNER_DIR"
    rm -rf Cargo.lock target
    cargo $build_command
    cd -

    for bench in "${BENCHMARKS[@]}"; do
        echo "Compiling [$bench]..."
        bench_dir="$benchmarks_home/$bench"

        cd "$bench_dir/guest"
        rm -rf Cargo.lock target
        cargo build --release # We always build guest in a default way as we build it to Wasm.
        cd "$bench_dir/host"
        rm -rf Cargo.lock target
        cargo $build_command
        cd $benchmarks_home
    done
    echo "All builds completed successfully."
    echo ""
}

function run_mosaic_benchmarks {
    config=$1
    mode="mosaic"

    echo "============================================="
    echo "    Running  Benchmarks ($mode-$config)    "
    echo "============================================="

    benchmarks_home=${BENCHMARK_HOME["$mode"]}
    run_command="run-$config"
    result_file="$RESULT_DIR/result-$mode-$config.json"

    rm -f $result_file
    echo "[" > "$result_file"
    first_item=true

    for bench in "${BENCHMARKS[@]}"; do
        echo "Starting [$bench] - $ITERATIONS iterations..."
        bench_dir="$benchmarks_home/$bench"

        cd "$bench_dir/host"
        for ((i=1; i<=ITERATIONS; i++)); do
            echo "  Running iteration $i/$ITERATIONS..."

            if [ "$first_item" = true ]; then
                first_item=false
            else
                echo "," >> "$result_file"
            fi

            cargo $run_command -- $BENCHMARK_DURATION $WARMUP_ITERATIONS >> "$result_file"
        done
        cd $benchmarks_home
        echo "Finished [$bench]."
        echo "" >> "$result_file"
    done
    echo "]" >> "$result_file"
}

function build_native_benchmarks {
    config=$1
    mode="native"

    echo "======================================================"
    echo "Building all guests and hosts for ($mode-$config)"
    echo "======================================================"

    benchmarks_home=${BENCHMARK_HOME["$mode"]}
    build_command="build-$config"

    for bench in "${BENCHMARKS[@]}"; do
        echo "Compiling [$bench]..."
        bench_dir="$benchmarks_home/$bench"

        cd "$bench_dir"
        rm -rf Cargo.lock target
        cargo $build_command
        cd $benchmarks_home
    done
    echo "All builds completed successfully."
    echo ""
}

function run_native_benchmarks {
    config=$1
    mode="native"

    echo "==============================================="
    echo "    Running  Benchmarks ($mode-$config)    "
    echo "==============================================="

    benchmarks_home=${BENCHMARK_HOME["$mode"]}
    run_command="run-$config"
    result_file="$RESULT_DIR/result-$mode-$config.json"

    rm -f $result_file
    echo "[" > "$result_file"
    first_item=true

    for bench in "${BENCHMARKS[@]}"; do
        echo "Starting [$bench] - $ITERATIONS iterations..."
        bench_dir="$benchmarks_home/$bench"
        cd "$bench_dir"

        for ((i=1; i<=ITERATIONS; i++)); do
            echo "  Running iteration $i/$ITERATIONS..."

            if [ "$first_item" = true ]; then
                first_item=false
            else
                echo "," >> "$result_file"
            fi

            cargo $run_command -- $BENCHMARK_DURATION $WARMUP_ITERATIONS >> "$result_file"
        done
        cd $benchmarks_home
        echo "Finished [$bench]."
        echo "" >> "$result_file"
    done
    echo "]" >> "$result_file"
}

# Iterating over command line arguments containing desired configs.
for config in "$@"; do
    echo "=========================================="
    echo " Processing Mode: $config"
    echo "=========================================="

    # ALWAYS run native for the provided config.
    build_native_benchmarks "$config"
    run_native_benchmarks "$config"

    # SKIP Mosaic execution for "default".
    if [ "$config" != "default" ]; then
        build_mosaic_benchmarks "$config"
        run_mosaic_benchmarks "$config"
    fi
done


echo "=========================================="
echo " All benchmarks finished! Check $RESULT_DIR "
echo "=========================================="
