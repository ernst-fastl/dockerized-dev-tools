#!/bin/bash
$(git rev-parse --show-toplevel)/build-scripts/build-image.sh "$@" && $(git rev-parse --show-toplevel)/build-scripts/run-bash.sh "$@"