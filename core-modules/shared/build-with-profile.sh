#!/bin/bash

set -e

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"

# Default to the 'default' profile if none is provided.
PROFILE=${1:-default}

if [[ "$EXECUTION_ENVIRONMENT" != "local" ]]; then
    echo "Launching mosaic-builder container for profile: $PROFILE."

    # Dynamically find the root of the repository so we can mount the whole workspace.
    REPO_ROOT=$(git -C "$DIR" rev-parse --show-toplevel)

    # Calculate the relative path of THIS specific project folder from the repo root.
    REL_PATH="${DIR#$REPO_ROOT/}"

    docker run --rm \
        -u "$(id -u):$(id -g)" \
        -e EXECUTION_ENVIRONMENT="local" \
        -v "$REPO_ROOT:/workspace" \
        -w "/workspace/$REL_PATH" \
        mosaic-builder \
        bash build.sh "$PROFILE"

else
    echo "Building locally (Profile: $PROFILE)..."
    cd "$DIR"

    cargo "build-$PROFILE"
fi
