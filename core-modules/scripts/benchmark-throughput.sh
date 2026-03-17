#!/bin/bash

function DIR {
    echo "$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
}

set -e

ITERATIONS=10
RESULT_DIR="$(DIR)/../plots/mosaic-throughput"
RUNNER_DIR="$(DIR)/../runner"

BENCHMARK_DURATION=30
WARMUP_ITERATIONS=10

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

declare -A BENCHMARK_HOME
BENCHMARK_HOME[mosaic]="$(DIR)/../mosaic"
BENCHMARK_HOME[native]="$(DIR)/../native"
BENCHMARK_HOME[naive]="$(DIR)/../native"

declare -A BUILD_COMMAND
BUILD_COMMAND[mosaic]="build --release --quiet"
BUILD_COMMAND[native]="build-native --quiet"
BUILD_COMMAND[naive]="build-naive --quiet"

declare -A RUN_COMMAND
RUN_COMMAND[mosaic]="run --release --quiet"
RUN_COMMAND[native]="run-native --quiet"
RUN_COMMAND[naive]="run-naive --quiet"

declare -A RESULT_FILE
RESULT_FILE[mosaic]="$RESULT_DIR/result-mosaic.json"
RESULT_FILE[native]="$RESULT_DIR/result-native.json"
RESULT_FILE[naive]="$RESULT_DIR/result-naive.json"


function build_mosaic_benchmarks {
    mode="mosaic"

    echo "=========================================="
    echo "Building all guests and hosts for ($mode)"
    echo "=========================================="

    benchmarks_home=${BENCHMARK_HOME["$mode"]}
    build_command=${BUILD_COMMAND["$mode"]}

    cd "$RUNNER_DIR"
    cargo $build_command
    cd -

    for bench in "${BENCHMARKS[@]}"; do
        echo "Compiling [$bench]..."
        bench_dir="$benchmarks_home/$bench"

        cd "$bench_dir/guest"
        rm -rf Cargo.lock target
        cargo $build_command
        cd "$bench_dir/host"
        rm -rf Cargo.lock target
        cargo $build_command
        cd $benchmarks_home
    done
    echo "All builds completed successfully."
    echo ""
}

function run_mosaic_benchmarks {
    mode="mosaic"

    echo "==================================="
    echo "    Running  Benchmarks ($mode)    "
    echo "==================================="

    benchmarks_home=${BENCHMARK_HOME["$mode"]}
    run_command=${RUN_COMMAND["$mode"]}
    result_file=${RESULT_FILE["$mode"]}

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

function build_benchmarks {
    mode=$1

    echo "=========================================="
    echo "Building all guests and hosts for ($mode)"
    echo "=========================================="

    benchmarks_home=${BENCHMARK_HOME["$mode"]}
    build_command=${BUILD_COMMAND["$mode"]}

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

function run_benchmarks {
    mode=$1

    echo "==================================="
    echo "    Running  Benchmarks ($mode)    "
    echo "==================================="

    benchmarks_home=${BENCHMARK_HOME["$mode"]}
    run_command=${RUN_COMMAND["$mode"]}
    result_file=${RESULT_FILE["$mode"]}

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


build_mosaic_benchmarks
run_mosaic_benchmarks
build_benchmarks native
run_benchmarks native
build_benchmarks naive
run_benchmarks naive

echo "=========================================="
echo " All benchmarks finished! Check $RESULT_DIR "
echo "=========================================="
