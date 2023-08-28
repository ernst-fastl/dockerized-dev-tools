#!/bin/bash

set +e # Exit on error

show_help() {
  echo "Usage: $0 [OPTION]..."
  echo "Options:"
  echo "  -h, --help        Show help"
  echo "  -r, --run         Run bash in image"
  echo "  -p, --publish     Publish to Docker Hub"
  echo "  -s, --skip-build  Skip building image"
  echo "  -t, --skip-test   Skip running tests"
  echo "  -i, --skip-image  Skip building specific image (can be used multiple times)"
}


# Create an array to hold options to be passed to subscripts
build_sh_options=()

# Create an array to hold images to skip
SKIP_IMAGES=()

# Parse options
while (( "$#" )); do
  case "$1" in
    -h|--help)
      show_help
      exit 0
      ;;
    -i|--skip-image)
      shift
      SKIP_IMAGES+=("$1")
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
  shift
  if containsElement "$image_name" "${SKIP_IMAGES[@]}"; then
    echo "Skipped: $image_name"
  else
    echo "Starting build of: $image_name"
    ./build.sh "${build_sh_options[@]}" "$image_name"
    local exit_code=$?
    status["$image_name"]=$exit_code
  fi
}

# Function to check statuses and exit if any failed
check_statuses_and_exit() {
  local exit_script=0
  for image in "${!status[@]}"; do
    if [ "${status[$image]}" -eq 0 ]; then
      echo "Success: $image"
    else
      echo "Failed: $image"
      exit_script=1
    fi
  done

  if [ $exit_script -ne 0 ]; then
    exit 1
  fi
}

# build multiple images in parallel wait for all to finish
build_images_parallel() {
  for image_name in "$@"; do
    execute_build "$image_name" &
  done

  # Wait for all background jobs to finish
  wait

  check_statuses_and_exit
}

echo "Stage 1: Starting build of base images"

execute_build "ubuntu-base"
execute_build "devbox-base"
execute_build "devbox-helm"


echo "Stage 2: parallel build of Scripting images"

set +e # Don't exit on error of one subprocess

build_images_parallel "devbox-python" "devbox-ruby" "devbox-perl" "devbox-node" "devbox-powershell" "devbox-scripting"

echo "Stage 3: parallel build of larger high-level images"

build_images_parallel "devbox-java" "devbox-dotnet" "devbox-go" "devbox-ultimate"
