#!/bin/bash
set -e  # Exit on error

# Get the absolute path of the Git repo root
REPO_ROOT=$(git rev-parse --show-toplevel)

# Remove trailing slashes from $1
CLEAN_ARG=$(echo "$1" | sed 's:/*$::')

# Determine the target directory
if [ -z "$CLEAN_ARG" ]; then
  TARGET_DIR=$(pwd)
else
  TARGET_DIR="$REPO_ROOT/$CLEAN_ARG"
fi

# Check if the target directory exists
if [ ! -d "$TARGET_DIR" ]; then
  echo "Error: Target directory does not exist."
  exit 1
fi

# Check if the target directory is strictly a subdirectory of the repo root
if [[ "$TARGET_DIR" == "$REPO_ROOT" || "$TARGET_DIR" != "$REPO_ROOT"* ]]; then
  echo "Error: Target directory must be a subdirectory of the Git repo root but is $TARGET_DIR"
  exit 1
fi

# Set the log directory and file name based on the current date and directory name
LOG_DIR="$REPO_ROOT/build-logs"
LOG_FILE="$LOG_DIR/$(date +%Y-%m-%d)-$(basename $TARGET_DIR).log"

# Set the Docker image name based on the directory name, version number, and date
IMAGE_NAME="ernst-fastl/$(basename $TARGET_DIR):$(cat $REPO_ROOT/version.txt)-nightly-$(date +%Y-%m-%d)"

# Create the log directory if it doesn't exist
mkdir -p "$LOG_DIR"

export WORKDIR="$TARGET_DIR"