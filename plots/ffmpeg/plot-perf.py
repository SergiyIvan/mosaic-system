#!/usr/bin/python3

import matplotlib
import matplotlib.pyplot as plt
import numpy as np

def parse_ffmpeg_log(filename):
    """
    Parses the FFmpeg benchmark log.
    Returns:
      file_size (int): The detected file size
      mean (float): Average ops/sec
      std (float): Standard deviation of ops/sec
    """
    throughput_samples = [] 
    detected_size = 0
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
                # We expect lines like: "1570024      316        300.76       1.65"
                if len(parts) >= 4 and parts[0].isdigit():
                    size = int(parts[0])
                    
                    # Capture the file size (assuming it's constant)
                    if detected_size == 0:
                        detected_size = size
                    
                    # Ensure we are reading lines for the correct file size
                    if size == detected_size:
                        ops = float(parts[1])
                        time = float(parts[2])
                        
                        if time > 0:
                            throughput_samples.append(ops / time)

    except FileNotFoundError:
        print(f"Error: Could not find file {filename}")
        return 0, 0.0, 0.0

    if not throughput_samples:
        return 0, 0.0, 0.0

    return detected_size, np.mean(throughput_samples), np.std(throughput_samples)

# --- Main Execution ---
wasm_size, wasm_mean, wasm_std = parse_ffmpeg_log("ffmpeg-wasm.log")
native_size, native_mean, native_std = parse_ffmpeg_log("ffmpeg-native.log")

# Validation
file_size = wasm_size if wasm_size != 0 else native_size
if wasm_size != 0 and native_size != 0 and wasm_size != native_size:
    print(f"Warning: Logs contain different file sizes! Wasm: {wasm_size}, Native: {native_size}")

print(f"Wasm:   Mean={wasm_mean:.4f}, Std={wasm_std:.4f}")
print(f"Native: Mean={native_mean:.4f}, Std={native_std:.4f}")

# --- Plotting ---
labels = [str(file_size)] 
x = np.arange(len(labels))
width = 0.35

matplotlib.rcParams.update({'font.size': 16})
fig, ax1 = plt.subplots(1, 1)

# Note: We wrap the single mean/std values in lists [] because .bar expects a sequence
ax1.bar(x - width/2, [native_mean], width=width, yerr=[native_std], hatch='//', label='Native', alpha=0.75, error_kw=dict(lw=1.5, capthick=1.5), capsize=5)
ax1.bar(x + width/2, [wasm_mean],   width=width, yerr=[wasm_std], hatch='..', label='Wasm',   alpha=0.75, error_kw=dict(lw=1.5, capthick=1.5), capsize=5)

# Styling
ax1.set_ylabel('Throughput (ops/sec)')
ax1.set_xlabel('Video File Size (bytes)')
ax1.set_title('FFmpeg Transcoding Performance')
ax1.set_xticks(x)
ax1.set_xticklabels(labels)

ax1.grid(axis='y', linestyle='--', linewidth=0.25)
# ax1.set_yscale('log')

ax1.legend(loc='upper right')

fig.set_figwidth(10)
fig.set_figheight(4)

output_file = "ffmpeg-perf.png"
plt.savefig(output_file, dpi=300, bbox_inches='tight')
