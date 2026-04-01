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


def plot_machine_cost_results(machine_id, machine_title, global_baseline_per_dollar):

    base_dir = f"./{machine_id}"
    cost = COSTS_PER_HOUR[machine_id]

    files = {
        "mosaic_native": f"{base_dir}/result-mosaic-native.json",
        "native_default": f"{base_dir}/result-native-default.json",
        "native_native": f"{base_dir}/result-native-native.json",
    }

    data = {key: parse_throughput(filepath) for key, filepath in files.items()}
    stats = {key: get_stats(d) for key, d in data.items()}

    safe_baseline = np.where(global_baseline_per_dollar == 0, 1, global_baseline_per_dollar)

    # Helper to convert RPS to Requests-per-Dollar and normalize.
    def norm_cost(mean_rps, std_rps):
        # Requests per Dollar = RPS * 3600 seconds / Hourly Cost.
        mean_req_per_dollar = (mean_rps * 3600) / cost
        std_req_per_dollar = (std_rps * 3600) / cost

        # Normalize against the global baseline.
        return mean_req_per_dollar / safe_baseline, std_req_per_dollar / safe_baseline

    matplotlib.rcParams.update({'font.size': 14})
    fig, ax = plt.subplots(1, 1, figsize=(10, 4))

    x = np.arange(len(target_benchmarks))
    width = 0.25

    err_kw = dict(lw=1.5, capthick=1.5)

    # Mosaic Native.
    m_mn, s_mn = norm_cost(*stats["mosaic_native"])
    ax.bar(x - width, m_mn, yerr=s_mn, width=width, label='Mosaic (Native)',
           edgecolor='black', alpha=0.75, hatch='//', error_kw=err_kw, capsize=4)

    # Native Default.
    m_nd, s_nd = norm_cost(*stats["native_default"])
    ax.bar(x, m_nd, yerr=s_nd, width=width, label='Default',
           edgecolor='black', alpha=0.75, hatch='..', error_kw=err_kw, capsize=4)

    # Native Native.
    m_nn, s_nn = norm_cost(*stats["native_native"])
    ax.bar(x + width, m_nn, yerr=s_nn, width=width, label='Best (Native)',
           edgecolor='black', alpha=0.75, hatch='', error_kw=err_kw, capsize=4)

    ax.axhline(1.0, color='red', linestyle='--', linewidth=1, zorder=0)

    ax.set_ylabel('Perf/$ (Relative to Intel Default)')
    ax.set_title(f'Normalized Performance per Dollar - {machine_title}')
    ax.set_xticks(x)
    ax.set_xticklabels(target_benchmarks, rotation=35, ha="right")
    ax.set_ylim(ymin=0)

    ax.grid(axis='y', linestyle='--', linewidth=0.25)
    ax.legend(loc='upper center', bbox_to_anchor=(1.15, 0.75), fontsize='small', ncol=1)

    output_file = f"perf-dollar-norm-{machine_id}.png"
    plt.savefig(output_file, dpi=300, bbox_inches='tight')
    plt.close()


if __name__ == "__main__":
    if not (os.path.exists("c7i") and os.path.exists("c7a") and os.path.exists("c7g")):
        print("Error: some result directories not found. Run this script from the directory containing the c7i, c7a, and c7g folders.")
        exit(1)

    # Intel c7i Default is the global baseline.
    intel_default_data = parse_throughput("c7i/result-native-default.json")
    intel_default_means, _ = get_stats(intel_default_data)

    # Calculate raw Requests per Dollar for Intel.
    global_baseline_per_dollar = (intel_default_means * 3600) / COSTS_PER_HOUR["c7i"]

    plot_machine_cost_results("c7i", "Intel (c7i)", global_baseline_per_dollar)
    plot_machine_cost_results("c7a", "AMD (c7a)", global_baseline_per_dollar)
    plot_machine_cost_results("c7g", "Graviton (c7g)", global_baseline_per_dollar)
