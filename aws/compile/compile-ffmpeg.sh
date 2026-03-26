#!/bin/bash

# NOTE: this script is not intended to be used directly!
# It is expected to be called from the Ansible playbook.

function DIR {
    echo "$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
}

set -e

CONFIGS=$1
S3_BUCKET=$2
MACHINE_ALIAS=$3

echo "=========================================="
echo " Building custom FFmpeg for $MACHINE_ALIAS "
echo "=========================================="

cd /tmp
if [ ! -d "FFmpeg" ]; then
    git clone https://github.com/FFmpeg/FFmpeg.git
fi
cd FFmpeg
git checkout n7.0.2

for CONFIG in $CONFIGS; do
    if [ "$CONFIG" == "default" ]; then continue; fi

    echo "Configuring FFmpeg for: $CONFIG"

    # Map Rust configs to GCC flags.
    if [ "$CONFIG" == "native" ]; then
        OPT_FLAGS="-O3 -march=native"
    elif [ "$CONFIG" == "x86-64-v3" ]; then
        # https://gcc.gnu.org/onlinedocs/gcc/x86-Options.html
        OPT_FLAGS="-O3 -march=x86-64-v3"
    elif [ "$CONFIG" == "neoverse-v1" ]; then
        # https://gcc.gnu.org/onlinedocs/gcc/ARM-Options.html
        OPT_FLAGS="-O3 -mcpu=neoverse-v1"
    else
        echo "Unknown config for FFmpeg: $CONFIG"
        exit 1
    fi

    # Clean previous builds.
    make clean || true

    # Configure and build.
    ./configure \
        --pkg-config-flags="--static" \
        --extra-cflags="$OPT_FLAGS" \
        --extra-cxxflags="$OPT_FLAGS" \
        --extra-ldexeflags="-static" \
        --disable-doc

    make -j$(nproc)

    # Upload directly to S3.
    aws s3 cp ffmpeg s3://$S3_BUCKET/$MACHINE_ALIAS/ffmpeg/${CONFIG}/ffmpeg
done

echo "FFmpeg compilation complete!"
