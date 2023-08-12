#!/bin/bash

# Get the absolute path of the Git repo root
REPO_ROOT=$(git rev-parse --show-toplevel)

# Get the absolute path of the current directory
CURRENT_DIR=$(pwd)

# Check if the current directory is a subdirectory of the repo root
if [[ "$CURRENT_DIR" != "$REPO_ROOT"* ]]; then
  echo "Error: Script must be executed in a subdirectory of the Git repo root."
  exit 1
fi

# Set the log directory and file name based on the current date and directory name
LOG_DIR="../build-logs"
LOG_FILE="$LOG_DIR/$(date +%Y-%m-%d)-$(basename $(pwd)).log"

# Set the Docker image name based on the current directory name, version number, and date
IMAGE_NAME="ernst-fastl/$(basename $(pwd)):$(cat ../version.txt)-nightly-$(date +%Y-%m-%d)"

# Create the log directory if it doesn't exist
mkdir -p "$LOG_DIR"