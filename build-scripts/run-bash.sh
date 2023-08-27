#!/bin/bash

. $(git rev-parse --show-toplevel)/build-scripts/_common.sh

echo "docker run -it --rm \
    --name $(basename $(pwd)) \
    --hostname $(basename $(pwd)) \
    -v $(pwd)/..:/workspace \
    -w /workspace \
    --entrypoint /bin/bash \
    $IMAGE_NAME -l"

# start a login shell as in the container
docker run -it --rm \
    --name $(basename $(pwd)) \
    --hostname $(basename $(pwd)) \
    -v $(pwd)/..:/workspace \
    -w /workspace \
    --entrypoint /bin/bash \
    $IMAGE_NAME -l