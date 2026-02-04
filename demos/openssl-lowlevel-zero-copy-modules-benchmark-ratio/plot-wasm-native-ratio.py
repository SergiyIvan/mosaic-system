#!/usr/bin/python3

import matplotlib
import matplotlib.pyplot as plt
import numpy as np

# Configuration
target_sizes = [1024, 8192, 16384]
x_labels = [str(s) for s in target_sizes]

def parse_time_breakdown(filename):
    total_samples = {size: [] for size in target_sizes}
    host_trampoline_samples = {size: [] for size in target_sizes}
    host_openssl_samples = {size: [] for size in target_sizes}
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
                # Line format: BlockSize  Ops        Total(ms)    Host-T(ms)   Host-O(ms)   Wasm(ms)
                # Index:       0          1          2            3            4            5
                if len(parts) >= 5 and parts[0].isdigit():
                    size = int(parts[0])

                    if size in target_sizes:
                        total_time = float(parts[2])
                        host_trampoline_time = float(parts[3])
                        host_openssl_time = float(parts[4])
                        wasm_time = float(parts[5])

                        total_samples[size].append(total_time)
                        host_trampoline_samples[size].append(host_trampoline_time)
                        host_openssl_samples[size].append(host_openssl_time)
                        wasm_samples[size].append(wasm_time)

    except FileNotFoundError:
        print(f"Error: Could not find file {filename}")
        return {}, {}, {}

    return total_samples, host_trampoline_samples, host_openssl_samples, wasm_samples

_, host_trampoline_data, host_openssl_data, wasm_data = parse_time_breakdown("openssl-wasm.log")
_, zc_host_trampoline_data, zc_host_openssl_data, zc_wasm_data = parse_time_breakdown("openssl-wasm-zerocopy.log")
native_data, _, _, _ = parse_time_breakdown("openssl-native.log")

native_means = []
native_std = []
host_trampoline_means = []
host_trampoline_std = []
host_openssl_means = []
host_openssl_std = []
wasm_means = []
wasm_std = []
zc_host_trampoline_means = []
zc_host_trampoline_std = []
zc_host_openssl_means = []
zc_host_openssl_std = []
zc_wasm_means = []
zc_wasm_std = []

for size in target_sizes:
    if size in host_trampoline_data:
        native_means.append(np.mean(native_data[size]))
        host_trampoline_means.append(np.mean(host_trampoline_data[size]))
        host_openssl_means.append(np.mean(host_openssl_data[size]))
        wasm_means.append(np.mean(wasm_data[size]))
        zc_host_trampoline_means.append(np.mean(zc_host_trampoline_data[size]))
        zc_host_openssl_means.append(np.mean(zc_host_openssl_data[size]))
        zc_wasm_means.append(np.mean(zc_wasm_data[size]))
        native_std.append(np.std(native_data[size]))
        host_trampoline_std.append(np.std(host_trampoline_data[size]))
        host_openssl_std.append(np.std(host_openssl_data[size]))
        wasm_std.append(np.std(wasm_data[size]))
        zc_host_trampoline_std.append(np.std(zc_host_trampoline_data[size]))
        zc_host_openssl_std.append(np.std(zc_host_openssl_data[size]))
        zc_wasm_std.append(np.std(zc_wasm_data[size]))
    else:
        native_means.append(0)
        host_trampoline_means.append(0)
        host_openssl_means.append(0)
        wasm_means.append(0)
        native_std.append(0)
        host_trampoline_std.append(0)
        host_openssl_std.append(0)
        wasm_std.append(0)
        zc_host_trampoline_means.append(0)
        zc_host_openssl_means.append(0)
        zc_wasm_means.append(0)
        zc_host_trampoline_std.append(0)
        zc_host_openssl_std.append(0)
        zc_wasm_std.append(0)
        print(f"Warning: No data for size {size}")

print(f"Native Means: {native_means}")
print(f"Host-T Means: {host_trampoline_means}")
print(f"Host-O Means: {host_openssl_means}")
print(f"Wasm Means: {wasm_means}")
print(f"Zero-Copy Host-T Means: {zc_host_trampoline_means}")
print(f"Zero-Copy Host-O Means: {zc_host_openssl_means}")
print(f"Zero-Copy Wasm Means: {zc_wasm_means}")

x = np.arange(len(x_labels))
width = 0.25

matplotlib.rcParams.update({'font.size': 16})
fig, ax1 = plt.subplots(1, 1)

host_openssl_means = np.array(host_openssl_means)
host_trampoline_means = np.array(host_trampoline_means)
wasm_means = np.array(wasm_means)
zc_host_openssl_means = np.array(zc_host_openssl_means)
zc_host_trampoline_means = np.array(zc_host_trampoline_means)
zc_wasm_means = np.array(zc_wasm_means)
native_means = np.array(native_means)

ax1.bar(x - 1*width, host_openssl_means, yerr=host_openssl_std, width=width, label='Host-OpenSSL', edgecolor='black', alpha=0.75, hatch='//', error_kw=dict(lw=1.5, capthick=1.5), capsize=5)
ax1.bar(x - 1*width, host_trampoline_means, yerr=host_trampoline_std, width=width, bottom=host_openssl_means, label='Host-Trampoline', edgecolor='black', alpha=0.75, hatch='..', error_kw=dict(lw=1.5, capthick=1.5), capsize=5)
ax1.bar(x - 1*width, wasm_means, yerr=wasm_std, width=width, bottom=host_trampoline_means + host_openssl_means, label='Wasm', edgecolor='black', alpha=0.75, hatch='*', error_kw=dict(lw=1.5, capthick=1.5), capsize=5)

ax1.bar(x, zc_host_openssl_means, yerr=zc_host_openssl_std, width=width, label='Zero-Copy Host-OpenSSL', edgecolor='black', alpha=0.75, hatch='//', error_kw=dict(lw=1.5, capthick=1.5), capsize=5)
ax1.bar(x, zc_host_trampoline_means, yerr=zc_host_trampoline_std, width=width, bottom=zc_host_openssl_means, label='Zero-Copy Host-Trampoline', edgecolor='black', alpha=0.75, hatch='..', error_kw=dict(lw=1.5, capthick=1.5), capsize=5)
ax1.bar(x, zc_wasm_means, yerr=zc_wasm_std, width=width, bottom=zc_host_trampoline_means + zc_host_openssl_means, label='Zero-Copy Wasm', edgecolor='black', alpha=0.75, hatch='*', error_kw=dict(lw=1.5, capthick=1.5), capsize=5)

ax1.bar(x + 1*width, native_means, yerr=native_std, width=width, label='Native', edgecolor='black', alpha=0.75, hatch='o', error_kw=dict(lw=1.5, capthick=1.5), capsize=5)

ax1.set_ylabel('Execution Time (ms)')
ax1.set_xlabel('Message Size (bytes)')
ax1.set_title('OpenSSL AES-256-GCM')
ax1.set_xticks(x)
ax1.set_xticklabels(x_labels)

ax1.grid(axis='y', linestyle='--', linewidth=0.25)
ax1.legend(loc='upper left', fontsize='x-small', ncol=1)

ax1.set_ylim(ymin=0)

fig.set_figwidth(10)
fig.set_figheight(4)

output_file = "openssl-breakdown.png"
plt.savefig(output_file, dpi=300, bbox_inches='tight')
