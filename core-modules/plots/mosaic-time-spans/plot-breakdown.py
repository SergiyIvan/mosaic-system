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

def parse_time_breakdown(filename):
    native_compute_samples = {b: [] for b in target_benchmarks}
    trampoline_samples = {b: [] for b in target_benchmarks}
    user_app_samples = {b: [] for b in target_benchmarks}

    try:
        with open(filename, 'r') as f:
            data = json.load(f)

            for entry in data:
                benchmark = entry.get("benchmark")
                if benchmark in target_benchmarks:
                    breakdown = entry.get("measurement", {}).get("breakdown", {})

                    # Convert us to ms for the plot.
                    host_compute = breakdown.get("host_compute_us", 0) / 1000.0
                    host_trampoline = breakdown.get("host_trampoline_us", 0) / 1000.0
                    wasm_overhead = breakdown.get("wasm_overhead_us", 0) / 1000.0

                    native_compute_samples[benchmark].append(host_compute)
                    trampoline_samples[benchmark].append(host_trampoline)
                    user_app_samples[benchmark].append(wasm_overhead)

    except FileNotFoundError:
        print(f"Error: Could not find file {filename}")
    except json.JSONDecodeError as e:
        print(f"Error parsing JSON: {e}")

    return native_compute_samples, trampoline_samples, user_app_samples

native_data, trampoline_data, user_app_data = parse_time_breakdown("result.json")

native_means = []
native_std = []
trampoline_means = []
trampoline_std = []
user_app_means = []
user_app_std = []

for b in target_benchmarks:
    if len(native_data[b]) > 0:
        native_means.append(np.mean(native_data[b]))
        native_std.append(np.std(native_data[b]))

        trampoline_means.append(np.mean(trampoline_data[b]))
        trampoline_std.append(np.std(trampoline_data[b]))

        user_app_means.append(np.mean(user_app_data[b]))
        user_app_std.append(np.std(user_app_data[b]))
    else:
        native_means.append(0)
        native_std.append(0)
        trampoline_means.append(0)
        trampoline_std.append(0)
        user_app_means.append(0)
        user_app_std.append(0)
        print(f"Warning: No data found for benchmark '{b}'")

native_means = np.array(native_means)
trampoline_means = np.array(trampoline_means)
user_app_means = np.array(user_app_means)

x = np.arange(len(target_benchmarks))
width = 0.5

matplotlib.rcParams.update({'font.size': 14})
fig, ax1 = plt.subplots(1, 1, figsize=(10, 4))

# Plot the stacked bars
ax1.bar(x, native_means, yerr=native_std, width=width, label='Native Compute',
        edgecolor='black', alpha=0.75, hatch='//', error_kw=dict(lw=1.5, capthick=1.5), capsize=5)

ax1.bar(x, trampoline_means, yerr=trampoline_std, width=width, bottom=native_means, label='Trampoline',
        edgecolor='black', alpha=0.75, hatch='..', error_kw=dict(lw=1.5, capthick=1.5), capsize=5)

ax1.bar(x, user_app_means, yerr=user_app_std, width=width, bottom=native_means + trampoline_means, label='User App',
        edgecolor='black', alpha=0.75, hatch='*', error_kw=dict(lw=1.5, capthick=1.5), capsize=5)

ax1.set_ylabel('Execution Time (ms)')
ax1.set_title('Execution Breakdown')
ax1.set_xticks(x)
ax1.set_xticklabels(target_benchmarks, rotation=35, ha="right")

ax1.grid(axis='y', linestyle='--', linewidth=0.25)
ax1.legend(loc='upper left', fontsize='small', ncol=1)

ax1.set_ylim(ymin=0)

output_file = "breakdown.png"
plt.savefig(output_file, dpi=300, bbox_inches='tight')
