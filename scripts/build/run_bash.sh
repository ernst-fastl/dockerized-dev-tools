#!/bin/bash

set -e  # Exit on error

if [ -z "$IMAGE_BUILD_DIR" ]; then
  echo "Error: init_environment must be invoked before running this script."
  exit 1
fi

# Start a login shell in the container
set -x
docker run -it --rm \
    --name $IMAGE_BASE_NAME \
    --hostname $IMAGE_BASE_NAME \
    -v $REPO_ROOT:/workspace \
    -w /workspace \
    --entrypoint /bin/bash \
    $IMAGE_NAME -l

set +x