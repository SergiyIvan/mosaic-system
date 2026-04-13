#!/usr/bin/python3

import json
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

COSTS_PER_HOUR = {
    "c7g": 0.15,
    "c7a": 0.21,
    "c7i": 0.18
}

MODES = [
    "native",
    "default"
]


def parse_throughput(filename):
    throughput_samples = {b: [] for b in target_benchmarks}

    try:
        with open(filename, 'r') as f:
            data = json.load(f)
            for entry in data:
                benchmark = entry.get("benchmark")
                if benchmark in target_benchmarks:
                    rps = entry.get("throughput_rps", 0)
                    throughput_samples[benchmark].append(rps)

    except FileNotFoundError:
        print(f"Warning: Could not find file {filename}")
    except json.JSONDecodeError as e:
        print(f"Error parsing JSON in {filename}: {e}")
    return throughput_samples


def get_stats(data_dict):
    means = []
    stds = []
    for b in target_benchmarks:
        if len(data_dict[b]) > 0:
            means.append(np.mean(data_dict[b]))
            stds.append(np.std(data_dict[b]))
        else:
            means.append(0)
            stds.append(0)
            print(f"Warning: No data found for benchmark '{b}'")
    return np.array(means), np.array(stds)


def get_data(filename):

    data_intel = parse_throughput(f"./c7i/{filename}")
    data_amd = parse_throughput(f"./c7a/{filename}")
    data_graviton = parse_throughput(f"./c7g/{filename}")

    # Calculate raw RPS means and stds.
    means_i, stds_i = get_stats(data_intel)
    means_a, stds_a = get_stats(data_amd)
    means_g, stds_g = get_stats(data_graviton)

    # Convert RPS to Requests per Dollar.
    req_dollar_i = (means_i * 3600) / COSTS_PER_HOUR["c7i"]
    std_dollar_i = (stds_i * 3600) / COSTS_PER_HOUR["c7i"]

    req_dollar_a = (means_a * 3600) / COSTS_PER_HOUR["c7a"]
    std_dollar_a = (stds_a * 3600) / COSTS_PER_HOUR["c7a"]

    req_dollar_g = (means_g * 3600) / COSTS_PER_HOUR["c7g"]
    std_dollar_g = (stds_g * 3600) / COSTS_PER_HOUR["c7g"]

    # Normalize against Intel (c7i) as the baseline.
    safe_baseline = np.where(req_dollar_i == 0, 1, req_dollar_i)

    norm_mean_i = req_dollar_i / safe_baseline
    norm_std_i = std_dollar_i / safe_baseline

    norm_mean_a = req_dollar_a / safe_baseline
    norm_std_a = std_dollar_a / safe_baseline

    norm_mean_g = req_dollar_g / safe_baseline
    norm_std_g = std_dollar_g / safe_baseline

    return norm_mean_i, norm_std_i, norm_mean_a, norm_std_a, norm_mean_g, norm_std_g


if __name__ == "__main__":
    if not (os.path.exists("c7i") and os.path.exists("c7a") and os.path.exists("c7g")):
        print("Error: some result directories not found. Run this script from the directory containing the c7i, c7a, and c7g folders.")
        exit(1)

    data = {}

    for mode in MODES:
        data[mode] = {}
        data[mode]["norm_mean_i"], data[mode]["norm_std_i"], data[mode]["norm_mean_a"], data[mode]["norm_std_a"], data[mode]["norm_mean_g"], data[mode]["norm_std_g"] = get_data(f'result-native-{mode}.json')

    matplotlib.rcParams.update({'font.size': 14})
    fig, (ax1, ax2) = plt.subplots(2, 1, sharey=True, figsize=(10, 5))

    x = np.arange(len(target_benchmarks))
    width = 0.25

    err_kw = dict(lw=1.5, capthick=1.5)

    # Default.
    # Intel c7i.
    ax1.bar(x - width, data["default"]["norm_mean_i"], yerr=data["default"]["norm_std_i"], width=width, label='Intel (C7i)',
           edgecolor='black', alpha=0.75, hatch='', error_kw=err_kw, capsize=4)
    # AMD c7a.
    ax1.bar(x, data["default"]["norm_mean_a"], yerr=data["default"]["norm_std_a"], width=width, label='AMD (C7a)',
           edgecolor='black', alpha=0.75, hatch='//', error_kw=err_kw, capsize=4)
    # Graviton c7g.
    ax1.bar(x + width, data["default"]["norm_mean_g"], yerr=data["default"]["norm_std_g"], width=width, label='Graviton (C7g)',
           edgecolor='black', alpha=0.75, hatch='\\\\', error_kw=err_kw, capsize=4)

    # Native.
    # Intel c7i.
    ax2.bar(x - width, data["native"]["norm_mean_i"], yerr=data["native"]["norm_std_i"], width=width, label='Intel (C7i)',
           edgecolor='black', alpha=0.75, hatch='', error_kw=err_kw, capsize=4)
    # AMD c7a.
    ax2.bar(x, data["native"]["norm_mean_a"], yerr=data["native"]["norm_std_a"], width=width, label='AMD (C7a)',
           edgecolor='black', alpha=0.75, hatch='//', error_kw=err_kw, capsize=4)
    # Graviton c7g.
    ax2.bar(x + width, data["native"]["norm_mean_g"], yerr=data["native"]["norm_std_g"], width=width, label='Graviton (C7g)',
           edgecolor='black', alpha=0.75, hatch='\\\\', error_kw=err_kw, capsize=4)

    ax1.axhline(1.0, color='red', linestyle='--', linewidth=1, zorder=0)
    ax2.axhline(1.0, color='red', linestyle='--', linewidth=1, zorder=0)

    fig.text(0.06, 0.5, "Perf/$ (Relative to Intel)", va='center', rotation='vertical')

    fig.text(0.15, 0.82, 'Default', ha='left')
    fig.text(0.15, 0.38, 'Optimized', ha='left')

    # ax.set_title(f'Hardware Cost Efficiency - {config_title}')
    ax1.tick_params(axis='x', which='both', bottom=False, top=False, labelbottom=False)
    ax2.set_xticks(x)
    ax1.set_xticklabels(["" for x in target_benchmarks], ha="right")
    ax2.set_xticklabels(target_benchmarks, rotation=35, ha="right")
    ax1.set_ylim(ymin=0)
    ax2.set_ylim(ymin=0)

    ax1.grid(axis='y', linestyle='--', linewidth=0.25)
    ax2.grid(axis='y', linestyle='--', linewidth=0.25)
    ax1.legend(loc='upper center', bbox_to_anchor=(0.5, 0), ncol=3)

    fig.subplots_adjust(hspace=0.33)

    output_file = f"perf-dollar-arch-paper.pdf"
    plt.savefig(output_file, bbox_inches='tight')
    plt.close()
