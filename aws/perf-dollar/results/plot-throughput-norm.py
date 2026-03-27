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


def plot_machine_results(machine_id, machine_title, opt_config):

    # Construct file paths assuming they are in ./<machine_id>/.
    base_dir = f"./{machine_id}"

    files = {
        "mosaic_native": f"{base_dir}/result-mosaic-native.json",
        f"mosaic_{opt_config}": f"{base_dir}/result-mosaic-{opt_config}.json",
        "native_default": f"{base_dir}/result-native-default.json",
        f"native_{opt_config}": f"{base_dir}/result-native-{opt_config}.json",
        "native_native": f"{base_dir}/result-native-native.json",
    }

    # Parse JSONs.
    data = {key: parse_throughput(filepath) for key, filepath in files.items()}

    # Calculate means and stds.
    stats = {key: get_stats(d) for key, d in data.items()}

    # The baseline for normalization is native_default.
    baseline_means, _ = stats["native_default"]

    # Prevent division by zero if a benchmark failed or file is missing.
    safe_baseline = np.where(baseline_means == 0, 1, baseline_means)

    # Normalization helper.
    def norm(mean_arr, std_arr):
        return mean_arr / safe_baseline, std_arr / safe_baseline

    matplotlib.rcParams.update({'font.size': 14})
    fig, ax = plt.subplots(1, 1, figsize=(10, 4))

    x = np.arange(len(target_benchmarks))
    width = 0.15

    err_kw = dict(lw=1.5, capthick=1.5)

    # Mosaic Native.
    m_mn, s_mn = norm(*stats["mosaic_native"])
    ax.bar(x - 2*width, m_mn, yerr=s_mn, width=width, label='Mosaic (Native)',
           edgecolor='black', alpha=0.75, hatch='//', error_kw=err_kw, capsize=4)

    # Mosaic Custom (x86-64-v3 or neoverse-v1).
    m_mc, s_mc = norm(*stats[f"mosaic_{opt_config}"])
    ax.bar(x - width, m_mc, yerr=s_mc, width=width, label=f'Mosaic ({opt_config})',
           edgecolor='black', alpha=0.75, hatch='\\\\', error_kw=err_kw, capsize=4)

    # Native Default (Baseline).
    m_nd, s_nd = norm(*stats["native_default"])
    ax.bar(x, m_nd, yerr=s_nd, width=width, label='Default',
           edgecolor='black', alpha=0.75, hatch='..', error_kw=err_kw, capsize=4)

    # Native Custom (x86-64-v3 or neoverse-v1).
    m_nc, s_nc = norm(*stats[f"native_{opt_config}"])
    ax.bar(x + width, m_nc, yerr=s_nc, width=width, label=f'Best ({opt_config})',
           edgecolor='black', alpha=0.75, hatch='xx', error_kw=err_kw, capsize=4)

    # Native Native.
    m_nn, s_nn = norm(*stats["native_native"])
    ax.bar(x + 2*width, m_nn, yerr=s_nn, width=width, label='Best (Native)',
           edgecolor='black', alpha=0.75, hatch='', error_kw=err_kw, capsize=4)

    ax.axhline(1.0, color='red', linestyle='--', linewidth=1, zorder=0)

    ax.set_ylabel('Throughput (Relative to Default)')
    ax.set_title(f'Normalized Throughput - {machine_title}')
    ax.set_xticks(x)
    ax.set_xticklabels(target_benchmarks, rotation=35, ha="right")
    ax.set_ylim(ymin=0)

    ax.grid(axis='y', linestyle='--', linewidth=0.25)
    # ax.legend(loc='upper left', fontsize='small', ncol=5)
    ax.legend(loc='upper center', bbox_to_anchor=(1.15, 0.75), fontsize='small', ncol=1)

    output_file = f"throughput-norm-{machine_id}.png"
    plt.savefig(output_file, dpi=300, bbox_inches='tight')
    plt.close()


if __name__ == "__main__":
    if not os.path.exists("c7i"):
        print("Error: some result directories not found. Run this script from the directory containing the c7i, c7a, and c7g folders.")
        exit(1)

    plot_machine_results(machine_id="c7i", machine_title="Intel (c7i)", opt_config="x86-64-v3")
    plot_machine_results(machine_id="c7a", machine_title="AMD (c7a)", opt_config="x86-64-v3")
    plot_machine_results(machine_id="c7g", machine_title="Graviton (c7g)", opt_config="neoverse-v1")
