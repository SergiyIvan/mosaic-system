#!/usr/bin/env python3

import os
import numpy as np
import matplotlib
import matplotlib.pyplot as plt

target_benchmarks = [
    "bfs", "compression", "dna", "dynamic-html", "mst",
    "pagerank", "thumbnailer", "video-processing", "uploader", "classify"
]

MACHINES = ["c7i", "c7a", "c7g"]
MACHINE_TITLES = {"c7i": "Intel (C7i)", "c7a": "AMD (C7a)", "c7g": "Graviton (C7g)"}

# Styling for the three machines
STYLES = {
    "c7i": {"color": "#1f77b4", "hatch": ""},     # Blue, solid
    "c7a": {"color": "#ff7f0e", "hatch": "//"},   # Orange, forward hatch
    "c7g": {"color": "#2ca02c", "hatch": "\\\\"}  # Green, backward hatch
}

def parse_ab_latency(filepath):
    """
    Parses an ApacheBench log to extract the Total Mean Latency, Standard Deviation,
    and total completed requests.
    Returns: (mean_latency, sd_latency, num_requests)
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
                    # Line format: Total:  157  171   5.2  170  195
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

if __name__ == "__main__":
    if not all(os.path.exists(m) for m in MACHINES):
        print("Error: c7i, c7a, or c7g directory missing. Run this inside the 'results' folder.")
        exit(1)

    machine_speedups = {m: [] for m in MACHINES}
    machine_errors = {m: [] for m in MACHINES}

    for m in MACHINES:
        for bench in target_benchmarks:
            file_default = f"./{m}/user-na_de_{bench}.log"
            file_native = f"./{m}/user-na_na_{bench}.log"

            res_d = parse_ab_latency(file_default)
            res_n = parse_ab_latency(file_native)

            if res_d and res_n and res_n[0] > 0:
                mean_d, sd_d, n_d = res_d
                mean_n, sd_n, n_n = res_n

                # Speedup = Latency_Default / Latency_Optimized
                speedup = mean_d / mean_n

                # Calculate Standard Error of the Mean (SEM)
                sem_d = sd_d / np.sqrt(n_d)
                sem_n = sd_n / np.sqrt(n_n)

                # Error propagation for the ratio (A/B)
                # err = (A/B) * sqrt( (err_A / A)^2 + (err_B / B)^2 )
                speedup_err = speedup * np.sqrt((sem_d / mean_d)**2 + (sem_n / mean_n)**2)

                machine_speedups[m].append(speedup)
                machine_errors[m].append(speedup_err)
            else:
                # Fallback if a benchmark failed or files are missing
                machine_speedups[m].append(0)
                machine_errors[m].append(0)

    # Plot Configuration
    matplotlib.rcParams['pdf.fonttype'] = 42
    matplotlib.rcParams['ps.fonttype'] = 42
    matplotlib.rcParams.update({'font.size': 14})

    fig, ax = plt.subplots(1, 1, figsize=(10, 4))

    x = np.arange(len(target_benchmarks))
    width = 0.25  # Width of each bar inside the group of 3

    # Plot each machine's bars
    offsets = [-width, 0, width]

    for idx, m in enumerate(MACHINES):
        ax.bar(x + offsets[idx], machine_speedups[m], yerr=machine_errors[m], width=width,
               label=MACHINE_TITLES[m], color=STYLES[m]["color"], edgecolor='black',
               alpha=0.85, hatch=STYLES[m]["hatch"],
               error_kw=dict(lw=1.5, capthick=1.5, capsize=4))

        print(f"Speedups for {m}: {sorted(machine_speedups[m])}")

    # Add baseline horizontal line at 1.0 (No speedup / Break-even)
    ax.axhline(1.0, color='red', linestyle='--', linewidth=1.5, zorder=0)

    ax.set_ylabel('Speedup (CPU- over ISA-binding)')
    ax.set_xticks(x)
    ax.set_xticklabels(target_benchmarks, rotation=30, ha="right")
    ax.set_ylim(ymin=0.5, ymax=1.6)

    ax.grid(axis='y', linestyle='--', linewidth=0.3)
    ax.legend(loc='upper center', ncol=3, frameon=True)

    output_file = "motivation-speedup.pdf"
    plt.savefig(output_file, bbox_inches='tight')
    plt.close()

    print(f"Successfully generated {output_file}")
