#!/bin/bash

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"

cd $DIR

MACHINE_ARCH=$(uname -m)
if [ "$MACHINE_ARCH" == "x86_64" ]; then
    FFMPEG_ARCH="amd64"
elif [ "$MACHINE_ARCH" == "aarch64" ]; then
    FFMPEG_ARCH="arm64"
else
    echo "Error: Unsupported architecture - $MACHINE_ARCH"
    exit 1
fi


if [ ! -f ffmpeg ];
then
    wget "https://johnvansickle.com/ffmpeg/releases/ffmpeg-release-$FFMPEG_ARCH-static.tar.xz"
    tar -xf "ffmpeg-release-$FFMPEG_ARCH-static.tar.xz"
    mv ffmpeg-*-$FFMPEG_ARCH-static/ffmpeg .
    rm -r ffmpeg-*-$FFMPEG_ARCH-static
    rm "ffmpeg-release-$FFMPEG_ARCH-static.tar.xz"
    # Installing into /tmp as video-processing benchmark expects the binary to be there.
    cp ffmpeg /tmp/ffmpeg
fi

if [ ! -f bacillus_subtilis.fasta ];
then
    wget https://github.com/spcl/serverless-benchmarks-data/raw/6a17a460f289e166abb47ea6298fb939e80e8beb/500.scientific/504.dna-visualisation/bacillus_subtilis.fasta
fi

if [ ! -f resnet50.onnx ];
then
    wget https://github.com/onnx/models/raw/main/validated/vision/classification/resnet/model/resnet50-v1-7.onnx -O resnet50.onnx
fi

cd -

docker run -d -p 8000:80 --rm -v $DIR:/usr/share/nginx/html --name web nginx

docker run -d -p 9696:8080 --rm --name web-uploader mayth/simple-upload-server -document_root=/docroot -addr=:8080 -max_upload_size=104857600
