#!/bin/bash

. $(git rev-parse --show-toplevel)/build-scripts/_common.sh

# Build the Docker image and pipe output to both the log file and console
if ! docker build --no-cache -t "$IMAGE_NAME" . 2>&1 | tee -a "$LOG_FILE"; then
    echo "Error: Docker build failed. Aborting."
    exit 1
fi

# Run tests and abort if the test fails
if ! $REPO_ROOT/build-scripts/_test.sh; then
    echo "Error: Test failed. Aborting."
    exit 1
fi

# Tag the Docker image with the latest tag
echo "Tagging image with latest tag"
LATEST_TAG="ernst-fastl/$(basename $(pwd)):latest"
docker tag "$IMAGE_NAME" "$LATEST_TAG"

# Append the image name and tag to the log file
echo "$IMAGE_NAME" >> "$LOG_FILE"
echo "$LATEST_TAG" >> "$LOG_FILE"