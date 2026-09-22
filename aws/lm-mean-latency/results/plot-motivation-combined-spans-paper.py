#!/usr/bin/env python3

import os
import argparse
import json
import numpy as np
import matplotlib
import matplotlib.pyplot as plt

BASE_BENCHMARKS = [
    "bfs", "mst", "pagerank", "uploader", "compression",
    "dna", "thumbnailer", "dynamic-html", "video-processing", "classify"
]

def parse_time_log(filepath):
    """
    Parses output.log file to extract execution Time Spans (skipping 100 warmups).
    Returns {"lib_code": array, "user_code": array}
    """
    requests = []
    current_lib_time = 0.0

    try:
        with open(filepath, 'r') as f:
            for line in f:
                if "*** Span:" not in line: continue
                parts = line.strip().split("|")
                span_name = parts[0].replace("*** Span:", "").strip()
                duration_ms = float(parts[1].replace("DurationUs:", "").strip()) / 1000.0

                if span_name.startswith("LibCode_"):
                    current_lib_time += duration_ms
                elif span_name == "TotalRun":
                    total_time = duration_ms
                    user_time = max(0.0, total_time - current_lib_time)
                    requests.append({"lib": current_lib_time, "user": user_time, "tot": total_time})
                    current_lib_time = 0.0
    except FileNotFoundError:
        return None

    valid_reqs = requests[100:500]
    if not valid_reqs: return None

    data = {"lib_code": [], "user_code": []}
    for req in valid_reqs:
        tot = req["tot"] if req["tot"] > 0 else 1.0
        data["lib_code"].append((req["lib"] / tot) * 100.0)
        data["user_code"].append((req["user"] / tot) * 100.0)

    return {k: np.array(v) for k, v in data.items()}


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("log_dir", help="Path to lambda_logs")
    parser.add_argument("--json", default="binary-size-ratio.json", help="Path to binary-size-ratio.json")
    args = parser.parse_args()

    # Load the JSON storage sizes
    try:
        with open(args.json, 'r') as f:
            storage_data = json.load(f)
    except FileNotFoundError:
        print(f"Error: Could not find {args.json}. Run analyze_binaries.py first.")
        return

    # Parse execution time logs
    time_means = {"lib": [], "user": []}
    time_errs = {"lib": [], "user": []}

    storage_means = {"lib": [], "user": []}
    valid_benchmarks = []

    for idx, bench in enumerate(BASE_BENCHMARKS):
        log_path = os.path.join(args.log_dir, f"lambda_{idx+1}_NATIVE", "output.log")
        req_data = parse_time_log(log_path)

        if req_data is None:
            continue

        valid_benchmarks.append(bench)

        # Calculate Time Means and SEM
        time_means["lib"].append(np.mean(req_data["lib_code"]))
        time_errs["lib"].append(np.std(req_data["lib_code"]) / np.sqrt(len(req_data["lib_code"])))

        time_means["user"].append(np.mean(req_data["user_code"]))
        time_errs["user"].append(np.std(req_data["user_code"]) / np.sqrt(len(req_data["user_code"])))

        # Extract Storage percentages from JSON
        bench_storage = storage_data.get(bench, {"lib_pct": 0, "user_pct": 0})
        storage_means["lib"].append(bench_storage["lib_pct"])
        storage_means["user"].append(bench_storage["user_pct"])

    # Plotting
    matplotlib.rcParams['pdf.fonttype'] = 42
    matplotlib.rcParams['ps.fonttype'] = 42
    matplotlib.rcParams.update({'font.size': 14})

    fig, ax = plt.subplots(figsize=(10, 4))
    x = np.arange(len(valid_benchmarks))

    # Spacing Configurations
    bar_width = 0.35
    gap = 0.05
    offset_time = -(bar_width / 2) - (gap / 2)
    offset_stor = (bar_width / 2) + (gap / 2)

    # Color Palette (Dark/Saturated for Time, Light/Desaturated for Size)
    c_time_lib = "#1f77b4"  # Dark Blue
    c_time_usr = "#ff7f0e"  # Dark Orange
    c_stor_lib = "#aec7e8"  # Light Blue
    c_stor_usr = "#ffbb78"  # Light Orange

    # Plot 1: TIME BARS (Left)
    ax.bar(x + offset_time, time_means["lib"], yerr=time_errs["lib"], width=bar_width,
           label="Lib Code Time", color=c_time_lib, edgecolor='black', alpha=0.85,
           error_kw=dict(lw=1.0, capthick=1.0, capsize=3.0), hatch='\\\\')

    ax.bar(x + offset_time, time_means["user"], yerr=time_errs["user"], width=bar_width,
           bottom=time_means["lib"], label="User Code Time", color=c_time_usr, edgecolor='black', alpha=0.85,
           error_kw=dict(lw=1.0, capthick=1.0, capsize=3.0), hatch='\\\\')

    print("TIME")
    print("LIB: " + str(time_means["lib"]))
    print("USR: " + str(time_means["user"]))

    # Plot 2: STORAGE BARS (Right)
    # Using hatches to visually differentiate Storage from Time
    ax.bar(x + offset_stor, storage_means["lib"], width=bar_width,
           label="Lib Code Size", color=c_stor_lib, edgecolor='black', alpha=0.85, hatch='//')

    ax.bar(x + offset_stor, storage_means["user"], width=bar_width,
           bottom=storage_means["lib"], label="User Code Size", color=c_stor_usr, edgecolor='black', alpha=0.85, hatch='//')

    print("\n\nSTORAGE")
    print("LIB: " + str(storage_means["lib"]))
    print("USR: " + str(storage_means["user"]))

    # Formatting
    ax.set_ylabel("Percentage (%)", fontsize=14)
    ax.set_ylim(0, 110) # 110 gives room for the Time error bars at the top
    ax.set_xticks(x)
    ax.set_xticklabels(valid_benchmarks, rotation=30, ha="right")
    ax.grid(axis='y', linestyle='--', linewidth=0.5, alpha=0.7)

    # 4-Column Legend to explain Colors (Lib/User) and Styles (Time/Storage)
    ax.legend(loc='upper center', bbox_to_anchor=(0.5, 1.21), ncol=4, frameon=True, fontsize=13)

    plt.tight_layout()
    output_file = "motivation-combined-spans.pdf"
    # plt.savefig(output_file, bbox_inches='tight')
    print(f"Successfully generated and saved plot to '{output_file}'")

if __name__ == "__main__":
    main()
