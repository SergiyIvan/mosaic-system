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

tput_data = parse_throughput("result.json")

tput_means = []
tput_std = []

for b in target_benchmarks:
    if len(tput_data[b]) > 0:
        tput_means.append(np.mean(tput_data[b]))
        tput_std.append(np.std(tput_data[b]))
    else:
        tput_means.append(0)
        tput_std.append(0)
        print(f"Warning: No data found for benchmark '{b}'")

tput_means = np.array(tput_means)
tput_std = np.array(tput_std)

x = np.arange(len(target_benchmarks))
width = 0.5

matplotlib.rcParams.update({'font.size': 14})
fig, ax1 = plt.subplots(1, 1, figsize=(10, 4))

# Plot the stacked bars
ax1.bar(x, tput_means, yerr=tput_std, width=width, label='Mosaic',
        edgecolor='black', alpha=0.75, hatch='//', error_kw=dict(lw=1.5, capthick=1.5), capsize=5)

ax1.set_ylabel('Throughput (ops/s)')
ax1.set_title('Pure Throughput')
ax1.set_xticks(x)
ax1.set_xticklabels(target_benchmarks, rotation=35, ha="right")

ax1.grid(axis='y', linestyle='--', linewidth=0.25)
ax1.legend(loc='upper left', fontsize='small', ncol=1)

ax1.set_ylim(ymin=0)

output_file = "throughput.png"
plt.savefig(output_file, dpi=300, bbox_inches='tight')
