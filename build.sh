#!/bin/bash
set -e  # Exit on error

show_help() {
  echo "Usage: $0 [OPTION]... [DIRECTORY]"
  echo "Options:"
  echo "  -h, --help     Show help"
  echo "  -r, --run      Run bash in image"
  echo "  -p, --publish  Publish to Docker Hub"
  echo "  -s, --skip-build Skip building image"
  echo "  -t, --skip-test  Skip running tests"
}

SCRIPTS_DIR=$(git rev-parse --show-toplevel)/scripts/build

execute_script() {
  SCRIPT="$1"
  echo "Executing $SCRIPTS_DIR/$SCRIPT.sh"
  bash "$SCRIPTS_DIR/$SCRIPT.sh" || { echo "$SCRIPT failed"; exit 1; }
}

init_environment() {
  REPO_ROOT=$(git rev-parse --show-toplevel)
  CLEAN_ARG=$(echo "$1" | sed 's:/*$::')

  if [ -z "$CLEAN_ARG" ]; then
    IMAGE_BUILD_DIR=$(pwd)
  else
    IMAGE_BUILD_DIR="$REPO_ROOT/$CLEAN_ARG"
  fi

  if [ ! -d "$IMAGE_BUILD_DIR" ]; then
    echo "Error: Image build dir does not exist: $IMAGE_BUILD_DIR"
    show_help
    exit 1
  fi

  if [[ "$IMAGE_BUILD_DIR" == "$REPO_ROOT" || "$IMAGE_BUILD_DIR" != "$REPO_ROOT"* ]]; then
    echo "Error: image build dir must be a subdirectory of the Git repo root but is $IMAGE_BUILD_DIR"
    show_help
    exit 1
  fi

  IMAGE_BASE_NAME=$(basename $IMAGE_BUILD_DIR)  

  LOG_DIR="$REPO_ROOT/build-logs"
  LOG_FILE="$LOG_DIR/$(date +%Y-%m-%d)-$IMAGE_BASE_NAME.log"
  IMAGE_NAME="ernst-fastl/$IMAGE_BASE_NAME:$(cat $REPO_ROOT/version.txt)-nightly-$(date +%Y-%m-%d)"

  mkdir -p "$LOG_DIR"

  export REPO_ROOT
  export IMAGE_BUILD_DIR
  export LOG_DIR
  export LOG_FILE
  export IMAGE_BASE_NAME
  export IMAGE_NAME
}

# Default directory is current
IMAGE_BUILD_DIR=$(basename $(pwd))

# Parse options
while :; do
  case "$1" in
    -h|--help)
      show_help
      exit
      ;;
    -r|--run)
      RUN_BASH=1
      ;;
    -p|--publish)
      PUBLISH=1
      ;;
    -s|--skip-build)
      SKIP_BUILD=1
      ;;
    -t|--skip-test)
      SKIP_TEST=1
      ;;
    *)
      if [ -n "$1" ]; then
        IMAGE_BUILD_DIR="$1"
      fi
      break
      ;;
  esac
  shift
done

init_environment "$IMAGE_BUILD_DIR"

# Execute scripts conditionally
[ "$SKIP_BUILD" != "1" ] && execute_script "build_image"
[ "$SKIP_TEST" != "1" ] && execute_script "run_tests"
execute_script "tag_image"

[ "$RUN_BASH" == "1" ] && execute_script "run_bash"
[ "$PUBLISH" == "1" ] && execute_script "publish"

echo "All tasks completed."

