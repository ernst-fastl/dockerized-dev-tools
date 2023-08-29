#!/bin/bash

set -e  # Exit on error

if [ -z "$IMAGE_BUILD_DIR" ]; then
  echo "Error: init_environment must be invoked before running this script."
  exit 1
fi


# Run a shell command in the Docker container and verify that it echoes the string

TEST_SCRIPT="/opt/devbox/test_$IMAGE_BASE_NAME.sh" 

echo "Running test script $TEST_SCRIPT"

docker run --rm \
    --name $IMAGE_BASE_NAME \
    --hostname $IMAGE_BASE_NAME \
    --entrypoint "/bin/bash" \
    "$IMAGE_NAME" -c "$TEST_SCRIPT" 

echo "Test passed"