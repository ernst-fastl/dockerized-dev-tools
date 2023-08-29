#!/bin/bash
set -e  # Exit on error

if [ -z "$IMAGE_BUILD_DIR" ]; then
  echo "Error: init_environment must be invoked before running this script."
  exit 1
fi

echo "Tagging $IMAGE_NAME as $LATEST_TAG..."

docker tag "$IMAGE_NAME" "$LATEST_TAG"

# Append the image name and tag to the log file
echo "$IMAGE_NAME" >> "$LOG_FILE"
echo "$LATEST_TAG" >> "$LOG_FILE"
