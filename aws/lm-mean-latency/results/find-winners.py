#!/usr/bin/python3

import os

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

COSTS_PER_HOUR = {
    "c7g": 0.15,
    "c7a": 0.21,
    "c7i": 0.18
}

MACHINES = {
    "c7i": "Intel",
    "c7a": "AMD",
    "c7g": "ARM"
}

NATIVE_FLAVORS = {
    "na_na": "CPU",
    "na_de": "ISA"
}


def parse_ab_throughput(filename):
    """Parses an ApacheBench log file to extract the raw Requests Per Second."""
    try:
        with open(filename, 'r') as f:
            for line in f:
                if "Requests per second:" in line:
                    parts = line.split()
                    return float(parts[3])
    except FileNotFoundError:
        pass
    except Exception as e:
        print(f"Error parsing {filename}: {e}")
    return 0.0


def calculate_winners(is_mosaic=False):
    flavors = ["mo"] if is_mosaic else ["na_na", "na_de"]

    best_raw_tput = {b: {"val": -1.0, "winner": "N/A"} for b in target_benchmarks}
    best_cost_eff = {b: {"val": -1.0, "winner": "N/A"} for b in target_benchmarks}

    for bench in target_benchmarks:
        for machine, machine_name in MACHINES.items():
            cost = COSTS_PER_HOUR[machine]

            for flavor in flavors:
                filename = f"./{machine}/user-{flavor}_{bench}.log"
                rps = parse_ab_throughput(filename)

                if rps > 0:
                    # Calculate Cost Efficiency (Requests per Dollar).
                    req_per_dollar = (rps * 3600.0) / cost

                    if is_mosaic:
                        # Mosaic always uses march=native trampolines
                        combo_label = f"{machine_name} - CPU"
                    else:
                        combo_label = f"{machine_name} - {NATIVE_FLAVORS[flavor]}"

                    # Check for new Raw Throughput winner.
                    if rps > best_raw_tput[bench]["val"]:
                        best_raw_tput[bench]["val"] = rps
                        best_raw_tput[bench]["winner"] = combo_label

                    # Check for new Cost Efficiency winner.
                    if req_per_dollar > best_cost_eff[bench]["val"]:
                        best_cost_eff[bench]["val"] = req_per_dollar
                        best_cost_eff[bench]["winner"] = combo_label

    return best_raw_tput, best_cost_eff


def print_table(title, best_raw_tput, best_cost_eff):
    print(f"\n{title}:")
    print("============================================================================")
    print(f"{'Benchmark':<20} | {'Best Raw Throughput':<25} | {'Best Cost Efficiency (Perf/$)':<25}")
    print("----------------------------------------------------------------------------")

    for bench in target_benchmarks:
        tput_winner = best_raw_tput[bench]["winner"]
        cost_winner = best_cost_eff[bench]["winner"]

        print(f"{bench:<20} | {tput_winner:<25} | {cost_winner:<25}")

    print("============================================================================\n")


if __name__ == "__main__":
    if not (os.path.exists("c7i") and os.path.exists("c7a") and os.path.exists("c7g")):
        print("Error: c7i, c7a, or c7g directory missing. Run this inside the 'results' folder.")
        exit(1)

    # Generate NATIVE table
    native_tput, native_cost = calculate_winners(is_mosaic=False)
    print_table("NATIVE", native_tput, native_cost)

    # Generate MOSAIC table
    mosaic_tput, mosaic_cost = calculate_winners(is_mosaic=True)
    print_table("MOSAIC", mosaic_tput, mosaic_cost)
