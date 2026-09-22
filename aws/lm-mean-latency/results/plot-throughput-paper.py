#!/usr/bin/env python3

import matplotlib
import matplotlib.pyplot as plt
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

# The 3 evaluation modes matching your filenames: mo, na_de (ISA), na_na (CPU)
FLAVORS = ["mo", "na_de", "na_na"]
LABELS = {
    "mo": "Tessera",           # Updated to Tessera
    "na_de": "ISA-Binding",
    "na_na": "CPU-Binding"
}

MACHINES = ["c7i", "c7a", "c7g"]
MACHINE_TITLES = {
    "c7i": "Intel (C7i)",
    "c7a": "AMD (C7a)",
    "c7g": "Graviton (C7g)"
}

def parse_ab_throughput(filename):
    """Parses an ApacheBench log file to extract the raw Requests Per Second."""
    try:
        with open(filename, 'r') as f:
            for line in f:
                if "Requests per second:" in line:
                    # Line format: Requests per second:    7.32 [#/sec] (mean)
                    parts = line.split()
                    return float(parts[3])
    except FileNotFoundError:
        print(f"Warning: Could not find file {filename}")
    except Exception as e:
        print(f"Error parsing file {filename}: {e}")
    return 0.0

def load_machine_data(machine_dir):
    """Loads all benchmarks and execution flavors for a specific machine directory."""
    flavor_data = {f: [] for f in FLAVORS}

    for flavor in FLAVORS:
        for bench in target_benchmarks:
            filename = f"./{machine_dir}/user-{flavor}_{bench}.log"
            rps = parse_ab_throughput(filename)

            # Since cost cancels out during normalization, just store raw RPS
            flavor_data[flavor].append(rps)

    return flavor_data

if __name__ == "__main__":
    if not (os.path.exists("c7i") and os.path.exists("c7a") and os.path.exists("c7g")):
        print("Error: c7i, c7a, or c7g directory missing. Run this inside the 'results' folder.")
        exit(1)

    # Gather raw RPS data for all configurations
    raw_cluster_data = {}
    for m in MACHINES:
        raw_cluster_data[m] = load_machine_data(m)

    # Normalize each benchmark against its ISA-binding baseline (na_de)
    normalized_cluster_data = {m: {f: [] for f in FLAVORS} for m in MACHINES}

    for m in MACHINES:
        for i in range(len(target_benchmarks)):
            # Establish the baseline for this specific benchmark on this specific machine
            baseline = raw_cluster_data[m]["na_de"][i]
            if baseline == 0:
                baseline = 1.0  # Prevent division by zero if data is missing

            for flavor in FLAVORS:
                norm_val = raw_cluster_data[m][flavor][i] / baseline
                normalized_cluster_data[m][flavor].append(norm_val)

    # Plot Configuration
    matplotlib.rcParams['pdf.fonttype'] = 42
    matplotlib.rcParams['ps.fonttype'] = 42
    matplotlib.rcParams.update({'font.size': 14})

    # 3 Stacked Subplots sharing the X-axis (Benchmarks)
    fig, (ax1, ax2, ax3) = plt.subplots(3, 1, sharex=True, figsize=(11, 9))
    axes = {"c7i": ax1, "c7a": ax2, "c7g": ax3}

    x = np.arange(len(target_benchmarks))
    width = 0.24  # Width of each bar inside a group of 3

    # Consistent styles/colors across all subplots
    styles = {
        "mo":    {"color": "#2ca02c", "hatch": ""},     # Green, Solid
        "na_de": {"color": "#ff7f0e", "hatch": "//"},   # Orange, Forward Hatch
        "na_na": {"color": "#1f77b4", "hatch": "\\\\"}  # Blue, Backward Hatch
    }

    # Populate each machine subplot with normalized data
    for m in MACHINES:
        ax = axes[m]

        # Plot Tessera (Left position)
        ax.bar(x - width, normalized_cluster_data[m]["mo"], width=width, label=LABELS["mo"],
               color=styles["mo"]["color"], edgecolor='black', alpha=0.85,
               hatch=styles["mo"]["hatch"])

        # Plot ISA-Binding (Center position - will always equal 1.0)
        ax.bar(x, normalized_cluster_data[m]["na_de"], width=width, label=LABELS["na_de"],
               color=styles["na_de"]["color"], edgecolor='black', alpha=0.85,
               hatch=styles["na_de"]["hatch"])

        # Plot CPU-Binding (Right position)
        ax.bar(x + width, normalized_cluster_data[m]["na_na"], width=width, label=LABELS["na_na"],
               color=styles["na_na"]["color"], edgecolor='black', alpha=0.85,
               hatch=styles["na_na"]["hatch"])

        print(m  + ":")
        print(normalized_cluster_data[m]["mo"])
        print(normalized_cluster_data[m]["na_de"])
        print(normalized_cluster_data[m]["na_na"])

        # Add a reference baseline horizontal line at y=1.0
        ax.axhline(1.0, color='red', linestyle='--', linewidth=1.2, zorder=1)

        # Label subplots inside the chart space safely
        ax.text(0.01, 0.85, MACHINE_TITLES[m], transform=ax.transAxes,
                fontweight='bold', bbox=dict(facecolor='white', alpha=0.85, edgecolor='none'))

        ax.set_ylim(ymin=0)
        ax.grid(axis='y', linestyle='--', linewidth=0.4)

    # Shared Labels & Adjustments (Updated to reflect raw throughput)
    fig.text(0.06, 0.5, "Throughput (Relative to ISA-binding)", va='center', rotation='vertical', fontsize=14)

    ax3.set_xticks(x)
    ax3.set_xticklabels(target_benchmarks, rotation=30, ha="right")

    # Place a single shared legend at the absolute top of the layout
    handles, labels = ax1.get_legend_handles_labels()
    fig.legend(handles, labels, loc='upper center', bbox_to_anchor=(0.5, 0.96), ncol=3, frameon=True)

    fig.subplots_adjust(hspace=0.15, top=0.90, bottom=0.12)

    output_file = "throughput.pdf"
    plt.savefig(output_file, bbox_inches='tight')
    plt.close()
    print(f"Plot saved successfully as '{output_file}'")
