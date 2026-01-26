#!/usr/bin/python3

import matplotlib
import matplotlib.pyplot as plt
import numpy as np

# Configuration
target_sizes = [1024, 8192, 16384]
x_labels = [str(s) for s in target_sizes]
log_file = "openssl-wasm-native-ratio.log"

def parse_time_breakdown(filename):
    """
    Parses the log file for Host time and Wasm time.
    Returns dictionaries mapping size -> list of samples.
    """
    host_samples = {size: [] for size in target_sizes}
    wasm_samples = {size: [] for size in target_sizes}

    is_recording = False

    try:
        with open(filename, 'r') as f:
            for line in f:
                # Start reading after Warmup
                if "=== Iteration 1/5 ===" in line:
                    is_recording = True
                if not is_recording:
                    continue

                parts = line.split()
                # Line format: BlockSize Ops Total(s) Host(s) Wasm(s) Throughput...
                # Index:       0         1   2        3        4        5
                if len(parts) >= 5 and parts[0].isdigit():
                    size = int(parts[0])

                    if size in target_sizes:
                        # Extract the breakdown times directly
                        host_time = float(parts[3])
                        wasm_time = float(parts[4])

                        host_samples[size].append(host_time)
                        wasm_samples[size].append(wasm_time)

    except FileNotFoundError:
        print(f"Error: Could not find file {filename}")
        return {}, {}

    return host_samples, wasm_samples

# --- Main Execution ---
print(f"Parsing {log_file}...")
host_data, wasm_data = parse_time_breakdown(log_file)

# Calculate Means
host_means = []
wasm_means = []

for size in target_sizes:
    if host_data[size]:
        host_means.append(np.mean(host_data[size]))
        wasm_means.append(np.mean(wasm_data[size]))
    else:
        host_means.append(0)
        wasm_means.append(0)
        print(f"Warning: No data for size {size}")

print(f"Host Means: {host_means}")
print(f"Wasm Means: {wasm_means}")

# --- Plotting ---
x = np.arange(len(x_labels))
width = 0.5 

matplotlib.rcParams.update({'font.size': 14})
fig, ax1 = plt.subplots(1, 1)

# Plot Host Time (Bottom)
p1 = ax1.bar(x, host_means, width, label='Host Time (OpenSSL)', 
             color='#1f77b4', edgecolor='black', alpha=0.85, hatch='//')

# Plot Wasm Time (Top) - "bottom" argument stacks it on top of host_means
p2 = ax1.bar(x, wasm_means, width, bottom=host_means, label='Wasm Time (Overhead)', 
             color='#ff7f0e', edgecolor='black', alpha=0.85, hatch='..')

# Styling
ax1.set_ylabel('Execution Time (seconds)')
ax1.set_xlabel('Message Size (bytes)')
ax1.set_title('Wasm/Native Breakdown (Zero Copy)')
ax1.set_xticks(x)
ax1.set_xticklabels(x_labels)

# Add a text label showing the Wasm % overhead on top of each bar
# for i, (h, w) in enumerate(zip(host_means, wasm_means)):
#     total = h + w
#     if total > 0:
#         pct = (w / total) * 100
#         ax1.text(i, total + 0.05, f"{pct:.1f}% Overhead", ha='center', va='bottom', fontsize=12, fontweight='bold')

ax1.set_ylim(0, 3.5) # Set slightly higher than 3.0s to make room for labels
ax1.grid(axis='y', linestyle='--', linewidth=0.5, alpha=0.7)
ax1.legend(loc='lower right')

fig.set_figwidth(8)
fig.set_figheight(6)

output_file = "openssl-breakdown.png"
plt.savefig(output_file, dpi=300, bbox_inches='tight')
print(f"Plot saved to {output_file}")
