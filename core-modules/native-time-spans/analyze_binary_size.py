#!/usr/bin/env python3

import os
import re
import subprocess
import sys

# Convert everything to KiB for uniform math
def to_kib(value_str, unit):
    val = float(value_str)
    if unit == 'B':
        return val / 1024.0
    elif unit == 'KiB':
        return val
    elif unit == 'MiB':
        return val * 1024.0
    return val

def main():
    # Matches: " 2.4%  10.2% 217.9KiB zstd_sys"
    crate_pattern = re.compile(r'^\s*[\d\.]+%\s+[\d\.]+%\s+([\d\.]+)(B|KiB|MiB)\s+(.+)$')
    # Matches: "... .text section size, the file size is 8.7MiB"
    file_size_pattern = re.compile(r'the file size is ([\d\.]+)(B|KiB|MiB)')

    benchmarks = [
        "bfs", "classify", "compression", "dna", "dynamic-html",
        "mst", "pagerank", "thumbnailer", "uploader", "video-processing"
    ]

    base_dir = os.path.dirname(os.path.abspath(__file__))

    print("Starting binary size analysis...")

    # Store results for the LaTeX table
    latex_data = []

    for bench in benchmarks:
        bench_dir = os.path.join(base_dir, bench)
        if not os.path.isdir(bench_dir):
            print(f"\nSkipping {bench} (directory not found).")
            latex_data.append((bench, 0.0, 0.0, 0.0))
            continue

        print(f"\n======================================")
        print(f" Analyzing: {bench}")
        print(f"======================================")

        # -n 0 ensures cargo-bloat lists ALL crates
        cmd = ["cargo", "bloat", "--release", "--crates", "-n", "0"]
        try:
            res = subprocess.run(cmd, cwd=bench_dir, capture_output=True, text=True, check=True)
        except subprocess.CalledProcessError:
            print(f"Failed to run cargo-bloat for {bench}.")
            latex_data.append((bench, 0.0, 0.0, 0.0))
            continue

        total_file_size_kib = 0.0
        deps_size_kib = 0.0

        bench_crate_name = bench.replace('-', '_')

        # Items strictly excluded from "dependencies"
        exclude_list = {'std', '[Unknown]', bench_crate_name, 'core', 'alloc', 'compiler_builtins'}

        for line in res.stdout.splitlines():
            # 1. Look for crate sizes
            c_match = crate_pattern.match(line)
            if c_match:
                size_val, unit, crate_name = c_match.groups()
                crate_name = crate_name.strip()

                if crate_name not in exclude_list:
                    deps_size_kib += to_kib(size_val, unit)

            # 2. Look for total file size at the bottom
            fs_match = file_size_pattern.search(line)
            if fs_match:
                size_val, unit = fs_match.groups()
                total_file_size_kib = to_kib(size_val, unit)

        base_app_size = total_file_size_kib - deps_size_kib

        # Calculate Percentage
        pct = (deps_size_kib / total_file_size_kib * 100.0) if total_file_size_kib > 0 else 0.0

        print(f"  Total Binary Size : {total_file_size_kib:8.2f} KiB")
        print(f"  Dependencies Size : {deps_size_kib:8.2f} KiB")
        print(f"  Base App Overhead : {base_app_size:8.2f} KiB (Total - Deps)")
        print(f"  Dependency Ratio  : {pct:8.2f} %")

        latex_data.append((bench, base_app_size, deps_size_kib, pct))

    # ==========================================
    # Print the final LaTeX snippet
    # ==========================================
    print("\n\n" + "="*40)
    print(" LaTeX Table Snippet")
    print("="*40 + "\n")

    for bench, user_code, deps, pct in latex_data:
        # Format variables to match the desired Latex table output
        # User Code size is rounded to the nearest integer
        # Deps size has 1 decimal place (e.g., 1.5)
        # Percentage is rounded to the nearest integer
        row = f"  {bench:<18} &  {int(round(user_code)):<6} &   {deps:.1f} ({int(round(pct))}) \\\\"
        print(row)

if __name__ == "__main__":
    main()
