#!/usr/bin/python3

import matplotlib
import matplotlib.pyplot as plt
import numpy as np

# Configuration
target_sizes = [1024, 8192, 16384]
x_labels = [str(s) for s in target_sizes]

def parse_log_stats(filename):
    """
    Parses the log file, skipping warmup.
    Returns two lists corresponding to 'target_sizes':
      1. means: Average ops/sec
      2. stds:  Standard deviation of ops/sec
    """
    # Dictionary to store all ops/sec samples for each size
    # Structure: { 1024: [val1, val2, ...], 8192: [...], ... }
    samples = {size: [] for size in target_sizes}

    is_recording = False

    try:
        with open(filename, 'r') as f:
            for line in f:
                # Only start recording after the Warmup phase is done
                if "=== Iteration 1/5 ===" in line:
                    is_recording = True
                if not is_recording:
                    continue

                parts = line.split()
                # We expect lines like: "1024       3095016    3.00       1056.43"
                if len(parts) >= 4 and parts[0].isdigit():
                    size = int(parts[0])

                    if size in samples:
                        ops = float(parts[1])
                        time = float(parts[2])

                        # Calculate Ops/Sec
                        throughput = ops / time
                        samples[size].append(throughput)

    except FileNotFoundError:
        print(f"Error: Could not find file {filename}")
        return [0]*len(target_sizes), [0]*len(target_sizes)

    # Calculate statistics
    means = []
    stds = []

    for size in target_sizes:
        data = samples[size]
        if data:
            means.append(np.mean(data))
            stds.append(np.std(data))
        else:
            means.append(0)
            stds.append(0)
            print(f"Warning: No data found for size {size} in {filename}")

    return means, stds

# --- Main Execution ---
wasm_means, wasm_stds = parse_log_stats("openssl-wasm.log")
wasm_mod_no_copy_means, wasm_mod_no_copy_stds = parse_log_stats("openssl-wasm-modules-no-copy.log")
wasm_mod_means, wasm_mod_stds = parse_log_stats("openssl-wasm-modules.log")
native_means, native_stds = parse_log_stats("openssl-native.log")

print(f"Wasm:   Mean={wasm_means}, Std={wasm_stds}")
print(f"Wasm Modules No Copy:   Mean={wasm_mod_no_copy_means}, Std={wasm_mod_no_copy_stds}")
print(f"Wasm Modules:   Mean={wasm_mod_means}, Std={wasm_mod_stds}")
print(f"Native: Mean={native_means}, Std={native_stds}")

# --- Plotting ---
x = np.arange(len(x_labels))
width = 0.15

matplotlib.rcParams.update({'font.size': 16})
fig, ax1 = plt.subplots(1, 1)

ax1.bar(x - 1.5*width, native_means, width=width, yerr=native_stds, hatch='//', label='Native', alpha=0.75, error_kw=dict(lw=1.5, capthick=1.5), capsize=5)
ax1.bar(x - 0.5*width, wasm_mod_no_copy_means, width=width, yerr=wasm_mod_no_copy_stds, hatch='*', label='Wasm Modules (No Copy)', alpha=0.75, error_kw=dict(lw=1.5, capthick=1.5), capsize=5)
ax1.bar(x + 0.5*width, wasm_mod_means, width=width, yerr=wasm_mod_stds, hatch='o', label='Wasm Modules', alpha=0.75, error_kw=dict(lw=1.5, capthick=1.5), capsize=5)
ax1.bar(x + 1.5*width, wasm_means,   width=width, yerr=wasm_stds,   hatch='..', label='Wasm Components',   alpha=0.75, error_kw=dict(lw=1.5, capthick=1.5), capsize=5)

# Styling
ax1.set_ylabel('Throughput (ops/sec)')
ax1.set_xlabel('Message Size (bytes)')
ax1.set_title('OpenSSL AES-256-GCM Performance')
ax1.set_xticks(x)
ax1.set_xticklabels(x_labels)

ax1.grid(axis='y', linestyle='--', linewidth=0.25)
# ax1.set_yscale('log')

ax1.legend(loc='upper right')

fig.set_figwidth(10)
fig.set_figheight(4)

output_file = "openssl-perf.png"
plt.savefig(output_file, dpi=300, bbox_inches='tight')
