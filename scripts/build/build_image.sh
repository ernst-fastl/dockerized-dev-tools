#!/bin/bash
set -e  # Exit on error
set -o pipefail  # Exit on command fail in pipe

if [ -z "$IMAGE_BUILD_DIR" ]; then
  echo "Error: init_environment must be invoked before running this script."
  exit 1
fi

# Initialize command line argument for verbose mode
verbose=0

# Parse command line arguments
while getopts "v" option; do
  case $option in
        v)
          verbose=1
          ;;
        *)
          echo "Invalid flag provided."
          exit 1
          ;;
      esac
done

# Function to build Docker image
build_docker() {
  echo "Building Docker image $IMAGE_NAME with Dockerfile $IMAGE_BUILD_DIR/Dockerfile"
  if [ $verbose -eq 1 ]; then
    docker build --no-cache -t "$IMAGE_NAME" -f "$IMAGE_BUILD_DIR/Dockerfile" $REPO_ROOT 2>&1 | tee -a "$LOG_FILE"
  else
    docker build --no-cache -t "$IMAGE_NAME" -f "$IMAGE_BUILD_DIR/Dockerfile" $REPO_ROOT >> "$LOG_FILE" 2>&1
  fi

  if [ "${PIPESTATUS[0]}" -ne 0 ]; then
    echo "Docker build failed for $IMAGE_NAME." >&2
    exit 1
  fi
}

# Invoke the function
build_docker