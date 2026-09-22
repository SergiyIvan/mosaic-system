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

def parse_log(filepath):
    """
    Parses an output.log file and extracts exactly 400 requests
    (skipping the first 100 warmups).
    Returns a dictionary of numpy arrays for the raw categories in milliseconds.
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

        data["wasm_init"].append(init)
        data["native_comp"].append(tramp)
        data["tramp_over"].append(max(0, host - tramp))
        data["wasm_guest"].append(max(0, exec_ - host))
        data["proxy_over"].append(max(0, total - exec_ - init))

    return {k: np.array(v) for k, v in data.items()}

def get_stats(data_arrays):
    """
    Calculates the relative percentages for the 3 merged categories per request,
    then returns the Mean and SEM.
    """
    categories = ["Native Library", "Wasm Guest", "Tessera Overhead"]

    if data_arrays is None:
        return {k: 0 for k in categories}, {k: 0 for k in categories}

    # Total time per request
    totals = sum(data_arrays.values())
    totals[totals == 0] = 1.0  # Prevent division by zero

    # Map raw arrays to our 3 new consolidated categories
    pct_native = (data_arrays["native_comp"] / totals) * 100.0
    pct_wasm = (data_arrays["wasm_guest"] / totals) * 100.0
    pct_overhead = ((data_arrays["wasm_init"] + data_arrays["tramp_over"] + data_arrays["proxy_over"]) / totals) * 100.0

    means = {
        "Native Library": np.mean(pct_native),
        "Wasm Guest": np.mean(pct_wasm),
        "Tessera Overhead": np.mean(pct_overhead)
    }

    # Standard Error of the Mean (SEM) = std / sqrt(N)
    stderrs = {
        "Native Library": np.std(pct_native) / np.sqrt(len(pct_native)),
        "Wasm Guest": np.std(pct_wasm) / np.sqrt(len(pct_wasm)),
        "Tessera Overhead": np.std(pct_overhead) / np.sqrt(len(pct_overhead))
    }

    return means, stderrs

if __name__ == "__main__":
    matplotlib.rcParams['pdf.fonttype'] = 42
    matplotlib.rcParams['ps.fonttype'] = 42
    matplotlib.rcParams.update({'font.size': 14})

    fig, ax = plt.subplots(figsize=(10, 4))
    x = np.arange(len(target_benchmarks))

    # Layout configuration for grouped bars
    bar_width = 0.25
    gap = 0.02
    offsets = {
        "c7i": -(bar_width + gap),
        "c7a": 0,
        "c7g": (bar_width + gap)
    }

    # Plot Styling (Bottom to Top in stacking order)
    categories = ["Native Library", "Wasm Guest", "Tessera Overhead"]
    styles = [
        {"color": "#2ca02c", "hatch": "\\\\"}, # Green
        {"color": "#1f77b4", "hatch": ".."},   # Blue
        {"color": "#d62728", "hatch": "//"},   # Red
    ]

    for m_idx, m in enumerate(MACHINES):
        machine_means = {cat: [] for cat in categories}
        machine_errs = {cat: [] for cat in categories}

        for idx, bench in enumerate(target_benchmarks):
            # Lambda IDs are 1-based
            filepath = f"./{m}/lambda_{idx+1}_output.log"
            means, errs = get_stats(parse_log(filepath))

            for cat in categories:
                machine_means[cat].append(means[cat])
                machine_errs[cat].append(errs[cat])

        # Plot the stacked bars for this specific machine
        bottoms = np.zeros(len(target_benchmarks))
        for i, cat in enumerate(categories):
            m_arr = np.array(machine_means[cat])
            e_arr = np.array(machine_errs[cat])

            # Only add the label to the legend during the first machine's loop
            label = cat if m_idx == 0 else ""

            ax.bar(x + offsets[m], m_arr, yerr=e_arr, width=bar_width, bottom=bottoms,
                   label=label, color=styles[i]["color"], edgecolor='black', alpha=0.85, hatch=styles[i]["hatch"],
                   error_kw=dict(lw=1.0, capthick=1.0, capsize=2))
            bottoms += m_arr

    ax.set_ylim(0, 150) # Room for top error bars and the legend
    ax.grid(axis='y', linestyle='--', linewidth=0.5, alpha=0.7)
    ax.set_ylabel("% of Execution Time", fontsize=14)
    ax.set_yticks([20, 40, 60, 80, 100])

    ax.set_xticks(x)
    ax.set_xticklabels(target_benchmarks, rotation=30, ha="right")

    # Group Order Legend Note + Standard Category Legend
    legend = ax.legend(
        loc='upper center',
        # bbox_to_anchor=(0.5, 1.30),
        ncol=3,
        frameon=True,
        title="Bar Group Order: C7i (Left)   |   C7a (Center)   |   C7g (Right)",
        title_fontproperties={'weight': 'bold', 'size': 14}
    )
    legend.get_title().set_position((0, 0))

    plt.tight_layout()
    output_file = "mosaic-time-spans.pdf"
    plt.savefig(output_file, bbox_inches='tight')
    print(f"Saved grouped percentage plot to '{output_file}'")
