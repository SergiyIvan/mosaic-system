#!/usr/bin/python3

import json
import numpy as np
import os

target_benchmarks = [
    "bfs",
    "compression",
    "dna",
    "dynamic-html",
    "mst",
    "pagerank",
    "thumbnailer",
    "video-processing",
    "uploader",
    "classify"
]

COSTS_PER_HOUR = {
    "c7g": 0.15,
    "c7a": 0.21,
    "c7i": 0.18
}

MACHINE_CONFIGS = {
    "c7i": ["default", "native", "x86-64-v3"],
    "c7a": ["default", "native", "x86-64-v3"],
    "c7g": ["default", "native", "neoverse-v1"]
}

def parse_throughput(filename):
    throughput_samples = {b: [] for b in target_benchmarks}
    if not os.path.exists(filename):
        return throughput_samples  # Return empty if file doesn't exist yet.

    try:
        with open(filename, 'r') as f:
            data = json.load(f)
            for entry in data:
                benchmark = entry.get("benchmark")
                if benchmark in target_benchmarks:
                    rps = entry.get("throughput_rps", 0)
                    throughput_samples[benchmark].append(rps)
    except json.JSONDecodeError as e:
        print(f"Error parsing JSON in {filename}: {e}")

    return throughput_samples


def get_mean_stats(data_dict):
    means = {}
    for b in target_benchmarks:
        if len(data_dict[b]) > 0:
            means[b] = np.mean(data_dict[b])
        else:
            means[b] = 0
    return means


def generate_winner_table():
    # Dictionaries to store the maximum values and the winning "machine - config" string.
    best_raw_tput = {b: {"val": -1.0, "winner": "N/A"} for b in target_benchmarks}
    best_cost_eff = {b: {"val": -1.0, "winner": "N/A"} for b in target_benchmarks}

    # Iterate through all combinations.
    for machine, configs in MACHINE_CONFIGS.items():
        cost = COSTS_PER_HOUR[machine]

        for config in configs:
            filename = f"./{machine}/result-native-{config}.json"
            data = parse_throughput(filename)
            means = get_mean_stats(data)

            for bench in target_benchmarks:
                raw_rps = means[bench]

                if raw_rps > 0:
                    # Calculate Cost Efficiency (Requests per Dollar).
                    req_per_dollar = (raw_rps * 3600) / cost
                    combo_label = f"{machine} - {config}"

                    # Check for new Raw Throughput winner.
                    if raw_rps > best_raw_tput[bench]["val"]:
                        best_raw_tput[bench]["val"] = raw_rps
                        best_raw_tput[bench]["winner"] = combo_label

                    # Check for new Cost Efficiency winner.
                    if req_per_dollar > best_cost_eff[bench]["val"]:
                        best_cost_eff[bench]["val"] = req_per_dollar
                        best_cost_eff[bench]["winner"] = combo_label

    print("=" * 76)
    print(f"{'Benchmark':<20} | {'Best Raw Throughput':<25} | {'Best Cost Efficiency (Perf/$)':<25}")
    print("-" * 76)

    for bench in target_benchmarks:
        tput_winner = best_raw_tput[bench]["winner"]
        cost_winner = best_cost_eff[bench]["winner"]

        print(f"{bench:<20} | {tput_winner:<25} | {cost_winner:<25}")

    print("=" * 76)


if __name__ == "__main__":
    if not (os.path.exists("c7i") and os.path.exists("c7a") and os.path.exists("c7g")):
        print("Error: some result directories not found. Run this script from the directory containing the c7i, c7a, and c7g folders.")
        exit(1)

    generate_winner_table()
