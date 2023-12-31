#!/bin/bash

# Initialize log directory and variables
REPO_ROOT=$(git rev-parse --show-toplevel)
source "$REPO_ROOT/scripts/build/init_log_dir.sh"

CLEAN_ARG=$(echo "$1" | sed 's:/*$::')

if [ -z "$CLEAN_ARG" ]; then
  IMAGE_BUILD_DIR=$(pwd)
else
  IMAGE_BUILD_DIR="$REPO_ROOT/$CLEAN_ARG"
fi

if [ ! -d "$IMAGE_BUILD_DIR" ]; then
  echo "Error: Image build dir does not exist: $IMAGE_BUILD_DIR"
  exit 1
fi

if [[ "$IMAGE_BUILD_DIR" == "$REPO_ROOT" || "$IMAGE_BUILD_DIR" != "$REPO_ROOT"* ]]; then
  echo "Error: image build dir must be a subdirectory of the Git repo root but is $IMAGE_BUILD_DIR"
  exit 1
fi

IMAGE_BASE_NAME=$(basename $IMAGE_BUILD_DIR)
LATEST_TAG="${DOCKER_USERNAME:-dockerized-dev-tools}/$IMAGE_BASE_NAME:latest"

LOG_FILE="$LOG_DIR/$(date +%Y-%m-%d)-$IMAGE_BASE_NAME.log"
IMAGE_NAME="${DOCKER_USERNAME:-dockerized-dev-tools}/$IMAGE_BASE_NAME:$(cat $REPO_ROOT/version.txt)-nightly-$(date +%Y-%m-%d)"

export REPO_ROOT
export IMAGE_BUILD_DIR
export LOG_DIR
export LOG_FILE
export IMAGE_BASE_NAME
export IMAGE_NAME
export LATEST_TAG
export SUMMARY_LOG_FILE