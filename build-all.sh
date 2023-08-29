#!/bin/bash

set +e # Exit on error

# Initialize log directory and variables
REPO_ROOT=$(git rev-parse --show-toplevel)
source "$REPO_ROOT/scripts/build/init_log_dir.sh"

# Initialize skip stage flags
skip_stage1=0
skip_stage2=0

show_help() {
  echo "Usage: $0 [OPTION]..."
  echo "Options:"
  echo "-h, --help        Show help"
  echo "-r, --run         Run bash in image"
  echo "-p, --publish     Publish to Docker Hub"
  echo "-s, --skip-build  Skip building image"
  echo "-t, --skip-test   Skip running tests"
  echo "-i, --skip-image  Skip building specific image (can be used multiple times)"
  echo "-1, --skip-stage1 Skip stage 1"
  echo "-2, --skip-stage2 Skip stage 2"
}

# Create an array to hold options to be passed to subscripts
build_sh_options=()

# Create an array to hold images to skip
SKIP_IMAGES=()

# Parse options
while (("$#")); do
  case "$1" in
  -h | --help)
    show_help
    exit 0
    ;;
  -i | --skip-image)
    shift
    SKIP_IMAGES+=("$1")
    shift
    ;;
  -1 | --skip-stage1)
    skip_stage1=1
    shift
    ;;
  -2 | --skip-stage2)
    skip_stage2=1
    shift
    ;;
  *)
    # unknown options are passed to build.sh
    build_sh_options+=("$1")
    shift
    ;;
  esac
done

echo "Parsed SKIP_IMAGES: ${SKIP_IMAGES[*]}"
echo "Parsed build_sh_options: ${build_sh_options[*]}"

# Declare associative array to store statuses
declare -A status

# Function to check if an element is in an array
containsElement() {
  local element
  for element in "${@:2}"; do [[ "$element" == "$1" ]] && return 0; done
  return 1
}

# build a single docker image
execute_build() {
  local image_name=$1
  local timestamp
  timestamp=$(date '+%Y-%m-%d %H:%M:%S')
  if containsElement "$image_name" "${SKIP_IMAGES[@]}"; then
    echo "$timestamp - Skipped: $image_name" >> $SUMMARY_LOG_FILE
  else
    echo "Starting build of: $image_name"
    ./build.sh "${build_sh_options[@]}" "$image_name"
    if [ $? -eq 0 ]; then
      echo "$timestamp - $image_name - Success" >> $SUMMARY_LOG_FILE
    else
      echo "$timestamp - $image_name - Error" >> $SUMMARY_LOG_FILE
    fi
  fi
}

# Function to check statuses and exit on error from summary file
check_summary_and_exit_on_error() {
  if grep -q "Error" $SUMMARY_LOG_FILE; then
    cat $SUMMARY_LOG_FILE
    exit 1
  fi
}

# build multiple images in parallel and wait for all to finish
build_images_parallel() {
  echo "Building images in parallel: $*"
  for image_name in "$@"; do
    execute_build "$image_name" &
  done

  # Wait for all background jobs to finish
  wait

  check_summary_and_exit_on_error
}

printf "\n Build Summary: \n\n" > $SUMMARY_LOG_FILE
echo "$(date '+%Y-%m-%d %H:%M:%S') - Build started" >> $SUMMARY_LOG_FILE

# Stages
if [ $skip_stage1 -eq 0 ]; then
  printf "\nStage 1: Starting build of base images \n\n"
  execute_build "ubuntu-base"
  check_summary_and_exit_on_error
  execute_build "devbox-base"
  check_summary_and_exit_on_error
  execute_build "devbox-helm"
  check_summary_and_exit_on_error
fi

set +e

if [ $skip_stage2 -eq 0 ]; then
  printf "\nStage 2: parallel build of Scripting images \n\n"
  build_images_parallel "devbox-scripting" "devbox-python" "devbox-ruby" "devbox-perl" "devbox-node" "devbox-powershell"
fi

printf "\nStage 3: parallel build of larger high-level images \n\n"

build_images_parallel "devbox-java" "devbox-dotnet" "devbox-go" "devbox-ultimate"
