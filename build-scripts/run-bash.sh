#!/bin/bash

. $(git rev-parse --show-toplevel)/build-scripts/_common.sh

# start a login shell as in the container
docker run -it --rm \
    --name $(basename $(pwd)) \
    --hostname $(basename $(pwd)) \
    --entrypoint /bin/bash \
    $IMAGE_NAME -l