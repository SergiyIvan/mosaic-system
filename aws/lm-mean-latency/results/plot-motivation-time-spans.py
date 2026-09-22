#!/usr/bin/env python3

import os
import argparse
import numpy as np
import matplotlib
import matplotlib.pyplot as plt

# 1-based indexing match with directory names (e.g., lambda_1_NATIVE -> bfs)
BASE_BENCHMARKS = [
    "bfs", "mst", "pagerank", "uploader", "compression",
    "dna", "thumbnailer", "dynamic-html", "video-processing", "classify"
]

def parse_log(filepath):
    """
    Parses an output.log file and extracts request profiles.
    Accumulates LibCode_ spans until TotalRun is encountered.
    Returns arrays for user_code and lib_code percentages or absolute ms.
    """
    requests = []
    current_lib_time = 0.0

    try:
        with open(filepath, 'r') as f:
            for line in f:
                if "*** Span:" not in line:
                    continue

                parts = line.strip().split("|")
                span_name = parts[0].replace("*** Span:", "").strip()
                duration_us = float(parts[1].replace("DurationUs:", "").strip())
                duration_ms = duration_us / 1000.0

                if span_name.startswith("LibCode_"):
                    current_lib_time += duration_ms
                elif span_name == "TotalRun":
                    total_time = duration_ms
                    user_time = max(0.0, total_time - current_lib_time)

                    requests.append({
                        "lib_code": current_lib_time,
                        "user_code": user_time,
                        "total": total_time
                    })
                    # Reset accumulator for next request window
                    current_lib_time = 0.0
    except FileNotFoundError:
        print(f"Warning: Could not find file {filepath}")
        return None

    # Skip first 100 warmups, take up to the next 400
    valid_requests = requests[100:500]
    if len(valid_requests) == 0:
        print(f"Warning: Not enough requests found in {filepath} (found {len(requests)}, expected > 100)")
        return None

    data = {"lib_code": [], "user_code": []}
    for req in valid_requests:
        tot = req["total"] if req["total"] > 0 else 1.0
        # Convert to percentage relative to this request's TotalRun
        data["lib_code"].append((req["lib_code"] / tot) * 100.0)
        data["user_code"].append((req["user_code"] / tot) * 100.0)

    return {k: np.array(v) for k, v in data.items()}

def main():
    parser = argparse.ArgumentParser(description="Plot User Code vs Library Code execution time spans.")
    parser.add_argument("log_dir", help="Path to the directory containing lambda_logs (e.g., ./lambda_logs)")
    args = parser.parse_args()

    # Configure matplotlib styles for paper-ready output
    matplotlib.rcParams['pdf.fonttype'] = 42
    matplotlib.rcParams['ps.fonttype'] = 42
    matplotlib.rcParams.update({'font.size': 14})

    categories = ["lib_code", "user_code"]
    labels = ["Library Code", "User Code"]
    styles = [
        {"color": "#1f77b4", "hatch": ".."},   # Blue
        {"color": "#ff7f0e", "hatch": "//"},   # Orange
    ]

    means_dict = {cat: [] for cat in categories}
    errs_dict = {cat: [] for cat in categories}
    present_benchmarks = []

    for idx, bench in enumerate(BASE_BENCHMARKS):
        # Directories are 1-indexed (lambda_1_NATIVE, lambda_2_NATIVE, ...)
        lambda_id = idx + 1
        filepath = os.path.join(args.log_dir, f"lambda_{lambda_id}_NATIVE", "output.log")

        req_data = parse_log(filepath)
        if req_data is None:
            continue

        present_benchmarks.append(bench)
        for cat in categories:
            means_dict[cat].append(np.mean(req_data[cat]))
            # Standard Error of the Mean (SEM) = std / sqrt(N)
            errs_dict[cat].append(np.std(req_data[cat]) / np.sqrt(len(req_data[cat])))

    if not present_benchmarks:
        print("Error: No valid output.log files found to parse.")
        return

    # Plot creation
    fig, ax = plt.subplots(figsize=(10, 4))
    x = np.arange(len(present_benchmarks))
    width = 0.6

    bottoms = np.zeros(len(present_benchmarks))
    for i, cat in enumerate(categories):
        means_arr = np.array(means_dict[cat])
        errs_arr = np.array(errs_dict[cat])

        ax.bar(x, means_arr, yerr=errs_arr, width=width, bottom=bottoms,
               label=labels[i], color=styles[i]["color"], edgecolor='black',
               alpha=0.8, hatch=styles[i]["hatch"],
               error_kw=dict(lw=1.0, capthick=1.0, capsize=3.0))
        bottoms += means_arr

    # Grid and labels
    ax.set_ylabel("Percentage of Execution Time (%)", fontsize=13)
    ax.set_ylim(0, 105)
    ax.set_xticks(x)
    ax.set_xticklabels(present_benchmarks, rotation=25, ha="right")
    ax.grid(axis='y', linestyle='--', linewidth=0.5, alpha=0.7)

    # Legend layout
    ax.legend(loc='upper center', bbox_to_anchor=(0.5, 1.12), ncol=2, frameon=True)

    plt.tight_layout()
    output_file = "motivation-time-spans.pdf"
    plt.savefig(output_file, bbox_inches='tight')
    print(f"Successfully generated and saved plot to '{output_file}'")

if __name__ == "__main__":
    main()
