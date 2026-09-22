#!/usr/bin/env python3

import os
import numpy as np
import matplotlib
import matplotlib.pyplot as plt

target_benchmarks = [
    "bfs", "compression", "dna", "dynamic-html", "mst",
    "pagerank", "thumbnailer", "video-processing", "uploader", "classify"
]

COSTS_PER_HOUR = {
    "c7g": 0.15,
    "c7a": 0.21,
    "c7i": 0.18
}

MACHINES = ["c7i", "c7a", "c7g"]
# Mapping your logical modes to the actual filename suffixes
MODES = {
    "default": "na_de",    # ISA-binding
    "optimized": "na_na"   # CPU-binding
}

def parse_ab_log(filepath):
    """
    Parses an ApacheBench log to extract Mean Latency, SD Latency, and N.
    Returns (mean_latency_ms, sd_latency_ms, num_requests)
    """
    mean_lat = 0.0
    sd_lat = 0.0
    n_reqs = 1.0

    try:
        with open(filepath, 'r') as f:
            for line in f:
                if line.startswith("Complete requests:"):
                    n_reqs = float(line.split(":")[1].strip())
                elif line.startswith("Time per request:") and "(mean)" in line:
                    mean_lat = float(line.split()[3])
                elif line.startswith("Total:") and "ms" not in line:
                    parts = line.split()
                    sd_lat = float(parts[3])
                    break
    except FileNotFoundError:
        print(f"Warning: Could not find file {filepath}")
        return None
    except Exception as e:
        print(f"Error parsing file {filepath}: {e}")
        return None

    return mean_lat, sd_lat, n_reqs

def get_machine_data(machine, mode_suffix):
    """
    Returns two numpy arrays: req_per_dollar, sem_req_per_dollar
    """
    req_dollar = []
    sem_dollar = []
    cost = COSTS_PER_HOUR[machine]

    for bench in target_benchmarks:
        filepath = f"./{machine}/user-{mode_suffix}_{bench}.log"
        res = parse_ab_log(filepath)

        if res and res[0] > 0:
            mean_lat, sd_lat, n_reqs = res

            # 1. Calculate Standard Error of the Mean for Latency
            sem_lat = sd_lat / np.sqrt(n_reqs)

            # 2. Convert Latency (ms) to RPS
            rps = 1000.0 / mean_lat

            # Error propagation: SEM_RPS = RPS * (SEM_Lat / Mean_Lat)
            sem_rps = rps * (sem_lat / mean_lat)

            # 3. Convert RPS to Req/$
            r_dollar = (rps * 3600.0) / cost
            s_dollar = (sem_rps * 3600.0) / cost

            req_dollar.append(r_dollar)
            sem_dollar.append(s_dollar)
        else:
            req_dollar.append(0.0)
            sem_dollar.append(0.0)

    return np.array(req_dollar), np.array(sem_dollar)

def get_normalized_data(mode_suffix):
    """
    Fetches data for all machines and normalizes against Intel (c7i).
    """
    data = {}
    for m in MACHINES:
        req, sem = get_machine_data(m, mode_suffix)
        data[m] = {"val": req, "err": sem}

    # Intel is the baseline
    base_val = data["c7i"]["val"]
    base_err = data["c7i"]["err"]
    safe_base = np.where(base_val == 0, 1, base_val)

    norm_data = {}
    for m in MACHINES:
        val = data[m]["val"]
        err = data[m]["err"]

        # Normalized Value
        norm_val = val / safe_base

        # Error Propagation for Ratio (val / base_val)
        # Avoid division by zero in error calculation
        safe_val = np.where(val == 0, 1, val)
        norm_err = norm_val * np.sqrt((err / safe_val)**2 + (base_err / safe_base)**2)

        # If the original value was 0, zero out the error
        norm_err = np.where(val == 0, 0, norm_err)

        norm_data[m] = {"val": norm_val, "err": norm_err}

    return norm_data

if __name__ == "__main__":
    if not all(os.path.exists(m) for m in MACHINES):
        print("Error: c7i, c7a, or c7g directory missing. Run this script from the 'results' folder.")
        exit(1)

    # Gather data for both modes
    plot_data = {
        "default": get_normalized_data(MODES["default"]),
        "optimized": get_normalized_data(MODES["optimized"])
    }

    matplotlib.rcParams['pdf.fonttype'] = 42
    matplotlib.rcParams['ps.fonttype'] = 42
    matplotlib.rcParams.update({'font.size': 14})

    fig, ax = plt.subplots(figsize=(10, 4))

    x = np.arange(len(target_benchmarks))
    width = 0.25

    err_kw = dict(lw=1.5, capthick=1.5, capsize=4)

    # ------------------ SUBPLOT 2: OPTIMIZED (CPU-BINDING) ------------------
    o_data = plot_data["optimized"]

    ax.bar(x - width, o_data["c7i"]["val"], yerr=o_data["c7i"]["err"], width=width,
            label='Intel (C7i)', edgecolor='black', alpha=0.85, hatch='', error_kw=err_kw)
    ax.bar(x, o_data["c7a"]["val"], yerr=o_data["c7a"]["err"], width=width,
            label='AMD (C7a)', edgecolor='black', alpha=0.85, hatch='//', error_kw=err_kw)
    ax.bar(x + width, o_data["c7g"]["val"], yerr=o_data["c7g"]["err"], width=width,
            label='Graviton (C7g)', edgecolor='black', alpha=0.85, hatch='\\\\', error_kw=err_kw)

    print(o_data["c7i"]["val"])
    print(o_data["c7a"]["val"])
    print(o_data["c7g"]["val"])

    # Break-even line
    ax.axhline(1.0, color='red', linestyle='--', linewidth=1, zorder=0)

    # Updated Y-Axis Label
    fig.text(0.05, 0.5, "Requests/$ (Relative to Intel)", va='center', rotation='vertical')

    ax.set_xticks(x)
    ax.set_xticklabels(target_benchmarks, rotation=30, ha="right")

    ax.set_ylim(ymin=0)

    ax.grid(axis='y', linestyle='--', linewidth=0.25)
    ax.legend(loc='upper center', ncol=3)

    fig.subplots_adjust(hspace=0.15)

    output_file = "motivation-perf-dollar.pdf"
    plt.savefig(output_file, bbox_inches='tight')
    plt.close()
    print(f"Successfully generated {output_file}")
