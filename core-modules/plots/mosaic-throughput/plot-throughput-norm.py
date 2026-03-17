#!/usr/bin/python3

import json
import matplotlib
import matplotlib.pyplot as plt
import numpy as np

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
        print(f"Error: Could not find file {filename}")
    except json.JSONDecodeError as e:
        print(f"Error parsing JSON: {e}")
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


mosaic_tput_data = parse_throughput("result-mosaic.json")
native_tput_data = parse_throughput("result-native.json")
naive_tput_data = parse_throughput("result-naive.json")

mosaic_means, mosaic_std = get_stats(mosaic_tput_data)
native_means, native_std = get_stats(native_tput_data)
naive_means, naive_std = get_stats(naive_tput_data)

# Making sure we don't divide by zero.
safe_naive_means = np.where(naive_means == 0, 1, naive_means)

mosaic_means_norm = mosaic_means / safe_naive_means
native_means_norm = native_means / safe_naive_means
naive_means_norm = naive_means / safe_naive_means

mosaic_std_norm = mosaic_std / safe_naive_means
native_std_norm = native_std / safe_naive_means
naive_std_norm = naive_std / safe_naive_means

x = np.arange(len(target_benchmarks))
width = 0.25

matplotlib.rcParams.update({'font.size': 14})
fig, ax1 = plt.subplots(1, 1, figsize=(10, 4))

# Plot the stacked bars
ax1.bar(x - width, mosaic_means_norm, yerr=mosaic_std_norm, width=width, label='Mosaic',
        edgecolor='black', alpha=0.75, hatch='//', error_kw=dict(lw=1.5, capthick=1.5), capsize=5)
ax1.bar(x, native_means_norm, yerr=native_std_norm, width=width, label='Native',
        edgecolor='black', alpha=0.75, hatch='o', error_kw=dict(lw=1.5, capthick=1.5), capsize=5)
ax1.bar(x + width, naive_means_norm, yerr=naive_std_norm, width=width, label='Naive',
        edgecolor='black', alpha=0.75, hatch='..', error_kw=dict(lw=1.5, capthick=1.5), capsize=5)

ax1.axhline(1.0, color='red', linestyle='--', linewidth=1, zorder=0)

ax1.set_ylabel('Throughput (Relative to Naive)')
ax1.set_title('Normalized Throughput')
ax1.set_xticks(x)
ax1.set_xticklabels(target_benchmarks, rotation=35, ha="right")

ax1.grid(axis='y', linestyle='--', linewidth=0.25)
ax1.legend(loc='upper left', fontsize='small', ncol=3)

ax1.set_ylim(ymin=0)

output_file = "throughput-norm.png"
plt.savefig(output_file, dpi=300, bbox_inches='tight')
