#!/usr/bin/python3

import matplotlib
import matplotlib.pyplot as plt
import numpy as np

# Configuration
target_sizes = [1024, 8192, 16384]
x_labels = [str(s) for s in target_sizes]

def parse_time_breakdown(filename):
    total_samples = {size: [] for size in target_sizes}
    host_samples = {size: [] for size in target_sizes}
    wasm_samples = {size: [] for size in target_sizes}
    is_recording = False

    try:
        with open(filename, 'r') as f:
            for line in f:
                if "=== Iteration 1" in line:
                    is_recording = True
                if not is_recording:
                    continue

                parts = line.split()
                # Line format: BlockSize  Ops        Total(ms)    Host(ms)     Wasm(ms)
                # Index:       0          1          2            3            4
                if len(parts) >= 5 and parts[0].isdigit():
                    size = int(parts[0])

                    if size in target_sizes:
                        total_time = float(parts[2])
                        host_time = float(parts[3])
                        wasm_time = float(parts[4])

                        total_samples[size].append(total_time)
                        host_samples[size].append(host_time)
                        wasm_samples[size].append(wasm_time)

    except FileNotFoundError:
        print(f"Error: Could not find file {filename}")
        return {}, {}, {}

    return total_samples, host_samples, wasm_samples

_, host_data, wasm_data = parse_time_breakdown("openssl-wasm.log")
native_data, _, _ = parse_time_breakdown("openssl-native.log")

native_means = []
native_std = []
host_means = []
host_std = []
wasm_means = []
wasm_std = []

for size in target_sizes:
    if size in host_data:
        native_means.append(np.mean(native_data[size]))
        host_means.append(np.mean(host_data[size]))
        wasm_means.append(np.mean(wasm_data[size]))
        native_std.append(np.std(native_data[size]))
        host_std.append(np.std(host_data[size]))
        wasm_std.append(np.std(wasm_data[size]))
    else:
        native_means.append(0)
        host_means.append(0)
        wasm_means.append(0)
        native_std.append(0)
        host_std.append(0)
        wasm_std.append(0)
        print(f"Warning: No data for size {size}")

print(f"Native Means: {native_means}")
print(f"Host Means: {host_means}")
print(f"Wasm Means: {wasm_means}")

x = np.arange(len(x_labels))
width = 0.25

matplotlib.rcParams.update({'font.size': 16})
fig, ax1 = plt.subplots(1, 1)

ax1.bar(x - 0.5*width, host_means, yerr=host_std, width=width, label='Host', edgecolor='black', alpha=0.75, hatch='//', error_kw=dict(lw=1.5, capthick=1.5), capsize=5)
ax1.bar(x - 0.5*width, wasm_means, yerr=wasm_std, width=width, bottom=host_means, label='Wasm', edgecolor='black', alpha=0.75, hatch='..', error_kw=dict(lw=1.5, capthick=1.5), capsize=5)
ax1.bar(x + 0.5*width, native_means, yerr=native_std, width=width, label='Native', edgecolor='black', alpha=0.75, hatch='o', error_kw=dict(lw=1.5, capthick=1.5), capsize=5)

ax1.set_ylabel('Execution Time (ms)')
ax1.set_xlabel('Message Size (bytes)')
ax1.set_title('OpenSSL AES-256-GCM')
ax1.set_xticks(x)
ax1.set_xticklabels(x_labels)

ax1.grid(axis='y', linestyle='--', linewidth=0.25)
ax1.legend(loc='upper left')

fig.set_figwidth(10)
fig.set_figheight(4)

output_file = "openssl-breakdown.png"
plt.savefig(output_file, dpi=300, bbox_inches='tight')
