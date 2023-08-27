#!/bin/bash
set -e  # Exit on error
set -o pipefail  # Exit on command fail in pipe

if [ -z "$IMAGE_BUILD_DIR" ]; then
  echo "Error: init_environment must be invoked before running this script."
  exit 1
fi

# Build the Docker image and pipe output to both the log file and console
set -x 

docker build --no-cache -t "$IMAGE_NAME" -f "$IMAGE_BUILD_DIR/Dockerfile" $REPO_ROOT 2>&1 | tee -a "$LOG_FILE"

set +x
