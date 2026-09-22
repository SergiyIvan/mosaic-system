#!/usr/bin/env python3

import sys
import os
import matplotlib
import matplotlib.pyplot as plt
import numpy as np

if len(sys.argv) < 2:
    print("Usage: python plot_storage.py <path_to_trace.csv>")
    sys.exit(1)

trace_file = sys.argv[1]

# Configuration Constants
MACHINES = ["c7i", "c7a", "c7g"]
COSTS_PER_HOUR = {"c7g": 0.15, "c7a": 0.21, "c7i": 0.18}
LATENCY_RESULTS_DIR = "../../lm-latency-results"

TARGET_BENCHMARKS = [
    "bfs", "compression", "dna", "dynamic-html", "mst",
    "pagerank", "thumbnailer", "video-processing", "uploader", "classify"
]

SHORTCODES = {
    "bf": "bfs", "cl": "classify", "co": "compression", "dn": "dna",
    "dh": "dynamic-html", "ms": "mst", "pr": "pagerank", "th": "thumbnailer",
    "up": "uploader", "vp": "video-processing"
}

# ==========================================
# 1. Parse Output Logs to Find Winners
# ==========================================
def parse_ab_throughput(filename):
    try:
        with open(filename, 'r') as f:
            for line in f:
                if "Requests per second:" in line:
                    return float(line.split()[3])
    except FileNotFoundError:
        pass
    return 0.0

def calculate_winners(flavor):
    perf_winners = {}
    cost_winners = {}

    for bench in TARGET_BENCHMARKS:
        best_tput = -1.0
        best_cost = -1.0
        w_tput = "c7i" # Fallback defaults
        w_cost = "c7i"

        for m in MACHINES:
            log_path = os.path.join(LATENCY_RESULTS_DIR, m, f"user-{flavor}_{bench}.log")
            rps = parse_ab_throughput(log_path)

            if rps > 0:
                req_per_dollar = (rps * 3600.0) / COSTS_PER_HOUR[m]

                if rps > best_tput:
                    best_tput = rps
                    w_tput = m
                if req_per_dollar > best_cost:
                    best_cost = req_per_dollar
                    w_cost = m

        perf_winners[bench] = w_tput
        cost_winners[bench] = w_cost

    return perf_winners, cost_winners

cpu_perf_winners, cpu_cost_winners = calculate_winners("na_na")
isa_perf_winners, isa_cost_winners = calculate_winners("na_de")

# ==========================================
# 2. Parse Size Measurements
# ==========================================
sizes = {m: {} for m in MACHINES}

for m in MACHINES:
    try:
        with open(f"./{m}/sizes.txt", "r") as f:
            for line in f:
                if line.startswith("="): continue
                parts = line.strip().split()
                if len(parts) == 2:
                    sizes[m][parts[0]] = int(parts[1])
    except FileNotFoundError:
        print(f"Error: Could not find ./{m}/sizes.txt")
        sys.exit(1)

# ==========================================
# 3. Parse Azure Trace
# ==========================================
unique_functions = {}
with open(trace_file, 'r') as f:
    lines = f.readlines()
    if len(lines) > 1:
        for line in lines[1:]:
            parts = line.strip().split(',')
            if len(parts) >= 6:
                owner = parts[0]
                function = parts[1]
                bench_short = parts[5].strip()
                if bench_short in SHORTCODES:
                    unique_functions[(owner, function)] = SHORTCODES[bench_short]

counts = {b: 0 for b in TARGET_BENCHMARKS}
for bench in unique_functions.values():
    counts[bench] += 1

# ==========================================
# 4. Calculate Storage Footprint
# ==========================================
storage = {
    "Mosaic": 0, "XaaS": 0, "Uber": 0,
    "CPU-binding": 0, "ISA-binding": 0
}

# --- A. Mosaic Global Shared Components ---
for m in MACHINES:
    for key, size in sizes[m].items():
        if key.startswith("./trampoline/native/"):
            storage["Mosaic"] += size
    storage["Mosaic"] += sizes[m].get("./ffmpeg_cpu", 0)

# --- B. Per-Function Duplications ---
for bench in TARGET_BENCHMARKS:
    count = counts[bench]
    if count == 0:
        continue

    safe_bench = bench.replace('-', '_')

    # 1. Mosaic
    wasm_key = f"./wasm/{safe_bench}.wasm"
    storage["Mosaic"] += count * sizes["c7i"].get(wasm_key, 0)

    # 2. XaaS
    src_size = sizes["c7i"].get(f"source/native/{bench}", 0)
    if bench == "video-processing":
        src_size += sizes["c7i"].get("source/lib/ffmpeg", 0)
    elif bench == "dna":
        src_size += sizes["c7i"].get("source/lib/squiggle-lib", 0)
    elif bench == "pagerank":
        src_size += sizes["c7i"].get("source/lib/pagerank-lib", 0)
    storage["XaaS"] += count * src_size

    # 3. Uber-Mode
    uber_size = 0
    for m in MACHINES:
        uber_size += sizes[m].get(f"./native/native/lib{safe_bench}.so", 0)
        if bench == "video-processing":
            uber_size += sizes[m].get("./ffmpeg_cpu", 0)
    storage["Uber"] += count * uber_size

    # 4. CPU-Binding
    w_perf = cpu_perf_winners[bench]
    cpu_perf_size = sizes[w_perf].get(f"./native/native/lib{safe_bench}.so", 0)
    if bench == "video-processing":
        cpu_perf_size += sizes[w_perf].get("./ffmpeg_cpu", 0)
    storage["CPU-binding"] += count * cpu_perf_size

    # 5. ISA-Binding
    i_perf_raw = isa_perf_winners[bench]
    i_perf_m = "c7g" if i_perf_raw == "c7g" else "c7i"
    isa_perf_size = sizes[i_perf_m].get(f"./native/default/lib{safe_bench}.so", 0)
    if bench == "video-processing":
        isa_perf_size += sizes[i_perf_m].get("./ffmpeg_isa", 0)
    storage["ISA-binding"] += count * isa_perf_size

GB = 1024 ** 3
for mode, size_bytes in storage.items():
    storage[mode] = size_bytes / GB

# ==========================================
# 5. Plotting
# ==========================================
matplotlib.rcParams['pdf.fonttype'] = 42
matplotlib.rcParams['ps.fonttype'] = 42
matplotlib.rcParams.update({'font.size': 13}) # Match cold-start font size

labels = ["Tessera", "XaaS", "Uber", "CPU-binding", "ISA-binding"]
values = [storage["Mosaic"] if l == "Tessera" else storage[l] for l in labels]
colors = ['#2ca02c', '#8c564b', '#9467bd', '#1f77b4', '#ff7f0e']
hatches = ['', 'o', '.', '//', '\\\\']

# Narrower figure for side-by-side layout
fig, ax = plt.subplots(figsize=(5.5, 4))
x_pos = np.arange(len(labels))

bars = ax.bar(x_pos, values, color=colors, hatch=hatches, width=0.65, edgecolor='black', linewidth=1.2, alpha=0.85)

ax.set_ylabel("Storage Footprint (GBs)")
ax.grid(axis='y', linestyle='--', alpha=0.7)

# Rotate labels to fit the narrower width
ax.set_xticks(x_pos)
ax.set_xticklabels(labels, rotation=30, ha='right')

ax.set_ylim(ymin=0, ymax=(max(values) + max(values) * 0.18))

# Add text labels on top of the bars
for bar in bars:
    yval = bar.get_height()
    ax.text(bar.get_x() + bar.get_width()/2, yval + (max(values)*0.02),
            f'{yval:.1f}', ha='center', va='bottom', fontsize=11, fontweight='bold')

plt.tight_layout()
output_file = "storage-footprint.pdf"
plt.savefig(output_file, bbox_inches="tight")
print(f"Plot saved successfully to: '{output_file}'")
