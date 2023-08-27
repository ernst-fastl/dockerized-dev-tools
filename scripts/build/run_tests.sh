#!/bin/bash

set -e  # Exit on error

if [ -z "$IMAGE_BUILD_DIR" ]; then
  echo "Error: init_environment must be invoked before running this script."
  exit 1
fi


# Run a shell command in the Docker container and verify that it echoes the string
set -x

docker run --rm \
    --name $(basename $(pwd)) \
    --hostname $(basename $(pwd)) \
    --entrypoint "/bin/bash" \
    "$IMAGE_NAME" -c 'echo "Hello World"' | grep -q "Hello World"

set +x

echo "Test passed"