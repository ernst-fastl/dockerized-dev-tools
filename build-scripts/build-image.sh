#!/bin/bash
set -e  # Exit on error

. $(git rev-parse --show-toplevel)/build-scripts/_common.sh "$@"

# Build the Docker image and pipe output to both the log file and console
docker build --no-cache -t "$IMAGE_NAME" $WORKDIR 2>&1 | tee -a "$LOG_FILE"

# Run tests
$REPO_ROOT/build-scripts/_test.sh

# Tag the Docker image with the latest tag
echo "Tagging image with latest tag"
LATEST_TAG="ernst-fastl/$(basename $WORKDIR):latest"
docker tag "$IMAGE_NAME" "$LATEST_TAG"

# Append the image name and tag to the log file
echo "$IMAGE_NAME" >> "$LOG_FILE"
echo "$LATEST_TAG" >> "$LOG_FILE"
