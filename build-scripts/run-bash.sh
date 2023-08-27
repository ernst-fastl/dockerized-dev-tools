#!/bin/bash

. $(git rev-parse --show-toplevel)/build-scripts/_common.sh "$@"

echo "docker run -it --rm \
    --name $(basename $WORKDIR) \
    --hostname $(basename $WORKDIR) \
    -v $WORKDIR/..:/workspace \
    -w /workspace \
    --entrypoint /bin/bash \
    $IMAGE_NAME -l"

# Start a login shell in the container
docker run -it --rm \
    --name $(basename $WORKDIR) \
    --hostname $(basename $WORKDIR) \
    -v $WORKDIR/..:/workspace \
    -w /workspace \
    --entrypoint /bin/bash \
    $IMAGE_NAME -l
