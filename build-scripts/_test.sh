#!/bin/bash

. $(git rev-parse --show-toplevel)/build-scripts/_common.sh

# Run a shell command in the Docker container and verify that it echoes the string
if docker run --rm \
    --name $(basename $(pwd)) \
    --hostname $(basename $(pwd)) \
    --entrypoint "/bin/bash" \
    "$IMAGE_NAME" -c 'echo "Hello World"' | grep -q "Hello World"; then
    echo "Test passed"
else
    echo "Test failed: docker run --rm --name $(basename $(pwd)) --hostname $(basename $(pwd)) --entrypoint \"/bin/bash\" \"$IMAGE_NAME\" -c 'echo \"Hello World\"' | grep -q \"Hello World\""
    exit 1
fi