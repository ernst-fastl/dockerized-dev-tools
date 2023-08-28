#!/bin/bash

set -e  # Exit on error

skip_all_base=false
skip_ubuntu_base=false
skip_devbox_base=false
skip_devbox_helm=false

# Create an array to hold options to be passed to subscripts
subscript_options=()

# Parse options
for arg in "$@"; do
  case $arg in
    --skip-all)
      skip_all_base=true
      ;;
    --skip-ubuntu)
      skip_ubuntu_base=true
      ;;
    --skip-devbox)
      skip_devbox_base=true
      ;;
    --skip-helm)
      skip_devbox_helm=true
      ;;
    *)
      # Unknown options are added to subscript_options array
      subscript_options+=("$arg")
      ;;
  esac
done

# Declare associative array to store statuses
declare -A status

# Existing execute_build function
execute_build() {
  local image_name=$1
  shift
  ./build.sh "${subscript_options[@]}" "$image_name"
  local exit_code=$?
  status["$image_name"]=$exit_code
}

# New function to build multiple images in parallel
build_images_parallel() {
  for image_name in "$@"; do
    execute_build "$image_name" &
  done

  # Wait for all background jobs to finish
  wait

  # Check statuses and exit if any failed
  local exit_script=0
  for image in "${!status[@]}"; do
    if [ ${status[$image]} -eq 0 ]; then
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

# Stage 1 - Base images

if [ "$skip_all_base" = false ]; then
  [ "$skip_ubuntu_base" = false ] && execute_build "ubuntu-base"
  [ "$skip_devbox_base" = false ] && execute_build "devbox-base"
  [ "$skip_devbox_helm" = false ] && execute_build "devbox-helm"
fi

# Stage 2 - Scripting images

set +e  # Don't exit on error of one subprocess

build_images_parallel  "devbox-python" "devbox-ruby" "devbox-perl" "devbox-node" "devbox-powershell" "devbox-scripting"

# Stage 3 - Larger high-level images

build_images_parallel "devbox-java" "devbox-dotnet" "devbox-go" "devbox-ultimate"

