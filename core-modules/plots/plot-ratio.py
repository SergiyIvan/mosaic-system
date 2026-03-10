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
    "video-processing"
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
        # Convert lists to numpy arrays for element-wise operations.
        n_arr = np.array(native_data[b])
        t_arr = np.array(trampoline_data[b])
        u_arr = np.array(user_app_data[b])

        # Calculate total time per iteration.
        total_arr = n_arr + t_arr + u_arr

        # Prevent division by zero if a benchmark failed or took 0.0ms.
        total_arr[total_arr == 0] = 1

        # Calculate percentages per iteration.
        n_pct = (n_arr / total_arr) * 100
        t_pct = (t_arr / total_arr) * 100
        u_pct = (u_arr / total_arr) * 100

        # Calculate mean and std deviation of the percentages.
        native_means.append(np.mean(n_pct))
        native_std.append(np.std(n_pct))

        trampoline_means.append(np.mean(t_pct))
        trampoline_std.append(np.std(t_pct))

        user_app_means.append(np.mean(u_pct))
        user_app_std.append(np.std(u_pct))
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

ax1.set_ylabel('Percentage of Execution Time (%)')
ax1.set_title('Execution Breakdown')
ax1.set_xticks(x)
ax1.set_xticklabels(target_benchmarks, rotation=35, ha="right")

ax1.grid(axis='y', linestyle='--', linewidth=0.25)
ax1.legend(loc='upper center', fontsize='small', ncol=3)

ax1.set_ylim(ymin=0, ymax=120)

output_file = "ratio.png"
plt.savefig(output_file, dpi=300, bbox_inches='tight')
