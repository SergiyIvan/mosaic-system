#!/usr/bin/env python3

import os
import numpy as np
import matplotlib
import matplotlib.pyplot as plt

target_benchmarks = [
    "bfs", "mst", "pagerank", "uploader", "compression",
    "dna", "thumbnailer", "dynamic-html", "video-processing", "classify"
]

MACHINES = ["c7i", "c7a", "c7g"]
MACHINE_TITLES = {"c7i": "Intel (C7i)", "c7a": "AMD (C7a)", "c7g": "Graviton (C7g)"}

def parse_log(filepath):
    """
    Parses a lambda_X_output.log file and extracts exactly 400 requests
    (skipping the first 100 warmups).
    Returns lists of arrays for the 5 categories in milliseconds.
    """
    requests = []
    current_req = {"tramp": 0, "host": 0}

    try:
        with open(filepath, 'r') as f:
            for line in f:
                if "*** Span:" not in line:
                    continue

                parts = line.strip().split("|")
                span_name = parts[0].replace("*** Span:", "").strip()
                duration_us = float(parts[1].replace("DurationUs:", "").strip())
                duration_ms = duration_us / 1000.0

                if span_name == "WasmInit":
                    current_req["init"] = duration_ms
                elif span_name == "WasmExec":
                    current_req["exec"] = duration_ms
                elif span_name.startswith("TrampCompute_"):
                    current_req["tramp"] += duration_ms
                elif span_name.startswith("HostFunc_"):
                    current_req["host"] += duration_ms
                elif span_name == "TotalRun":
                    current_req["total"] = duration_ms
                    requests.append(current_req)
                    # Reset for the next request barrier
                    current_req = {"tramp": 0, "host": 0}
    except FileNotFoundError:
        print(f"Warning: Could not find file {filepath}")
        return None

    # Skip first 100, take the next 400
    valid_requests = requests[100:500]
    if len(valid_requests) == 0:
        return None

    data = {
        "wasm_init": [], "proxy_over": [], "tramp_over": [],
        "wasm_guest": [], "native_comp": []
    }

    for req in valid_requests:
        init = req.get("init", 0)
        exec_ = req.get("exec", 0)
        total = req.get("total", 0)
        tramp = req.get("tramp", 0)
        host = req.get("host", 0)

        # Apply your exact mathematical definitions
        native_comp = tramp
        tramp_over = max(0, host - tramp)
        wasm_guest = max(0, exec_ - host)
        proxy_over = max(0, total - exec_ - init)

        data["wasm_init"].append(init)
        data["native_comp"].append(native_comp)
        data["tramp_over"].append(tramp_over)
        data["wasm_guest"].append(wasm_guest)
        data["proxy_over"].append(proxy_over)

    return {k: np.array(v) for k, v in data.items()}

def get_stats(data_arrays, is_percentage=True):
    means = {}
    stderrs = {}

    if data_arrays is None:
        return {k: 0 for k in ["wasm_init", "native_comp", "tramp_over", "wasm_guest", "proxy_over"]}, \
               {k: 0 for k in ["wasm_init", "native_comp", "tramp_over", "wasm_guest", "proxy_over"]}

    # Total time per request
    totals = sum(data_arrays.values())
    totals[totals == 0] = 1  # Prevent division by zero

    for key, arr in data_arrays.items():
        if is_percentage:
            vals = (arr / totals) * 100
        else:
            vals = arr

        means[key] = np.mean(vals)
        # Standard Error of the Mean (SEM) = std / sqrt(N)
        stderrs[key] = np.std(vals) / np.sqrt(len(vals))

    return means, stderrs

if __name__ == "__main__":
    matplotlib.rcParams['pdf.fonttype'] = 42
    matplotlib.rcParams['ps.fonttype'] = 42
    matplotlib.rcParams.update({'font.size': 12})

    fig, axes = plt.subplots(3, 1, sharex=True, figsize=(11, 10))
    ax_dict = dict(zip(MACHINES, axes))

    x = np.arange(len(target_benchmarks))
    width = 0.65

    # Plot Styling (Bottom to Top in stacking order)
    categories = ["native_comp", "wasm_guest", "tramp_over", "wasm_init", "proxy_over"]
    labels = ["Native Library", "Wasm Guest", "Trampoline FFI", "Wasm Init", "Proxy Logic"]
    styles = [
        {"color": "#2ca02c", "hatch": "\\\\"}, # Green
        {"color": "#1f77b4", "hatch": ".."},   # Blue
        {"color": "#ff7f0e", "hatch": "//"},   # Orange
        {"color": "#9467bd", "hatch": "xx"},   # Purple
        {"color": "#d62728", "hatch": "**"},   # Red
    ]

    for m in MACHINES:
        ax = ax_dict[m]

        machine_means = {cat: [] for cat in categories}
        machine_errs = {cat: [] for cat in categories}

        for idx, bench in enumerate(target_benchmarks):
            # Lambda IDs are 1-based
            filepath = f"./{m}/lambda_{idx+1}_output.log"
            req_data = parse_log(filepath)

            means, errs = get_stats(req_data, is_percentage=True)
            for cat in categories:
                machine_means[cat].append(means[cat])
                machine_errs[cat].append(errs[cat])

        # Plot the stacked bars
        bottoms = np.zeros(len(target_benchmarks))
        for i, cat in enumerate(categories):
            means_arr = np.array(machine_means[cat])
            errs_arr = np.array(machine_errs[cat])

            ax.bar(x, means_arr, yerr=errs_arr, width=width, bottom=bottoms,
                   label=labels[i] if m == "c7i" else "", # Only label once for the legend
                   color=styles[i]["color"], edgecolor='black', alpha=0.85, hatch=styles[i]["hatch"],
                   error_kw=dict(lw=1.0, capthick=1.0, capsize=3))
            bottoms += means_arr

        ax.text(0.01, 0.85, MACHINE_TITLES[m], transform=ax.transAxes,
                bbox=dict(facecolor='white', alpha=0.85, edgecolor='none'))
        ax.set_ylim(0, 110) # 110 to give room for the top error bars
        ax.grid(axis='y', linestyle='--', linewidth=0.4)

    fig.text(0.06, 0.5, "Percentage of Execution Time (%)", va='center', rotation='vertical', fontsize=14)
    axes[-1].set_xticks(x)
    axes[-1].set_xticklabels(target_benchmarks, rotation=30, ha="right")

    fig.legend(loc='upper center', bbox_to_anchor=(0.5, 0.92), ncol=5, frameon=True)
    fig.subplots_adjust(hspace=0.15, top=0.88, bottom=0.12)

    output_file = "mosaic-time-spans.pdf"
    plt.savefig(output_file, bbox_inches='tight')
    print(f"Saved percentage plot to '{output_file}'")
