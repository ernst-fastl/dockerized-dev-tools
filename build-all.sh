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

execute_build() {
  local image_name=$1
  shift  # Remove the first argument
  ./build.sh "${subscript_options[@]}" "$image_name" 
  local exit_code=$?
  status["$image_name"]=$exit_code
  if [ $exit_code -ne 0 ]; then
    echo "Failed: $image_name"
    exit 1
  fi
}

if [ "$skip_all_base" = false ]; then
  [ "$skip_ubuntu_base" = false ] && execute_build "ubuntu-base"
  [ "$skip_devbox_base" = false ] && execute_build "devbox-base"
  [ "$skip_devbox_helm" = false ] && execute_build "devbox-helm"
fi

# Devbox images - parallel execution
execute_build "devbox-python" &
execute_build "devbox-ruby" &
execute_build "devbox-perl" &
execute_build "devbox-node" &
execute_build "devbox-java" &
execute_build "devbox-dotnet" &
execute_build "devbox-go" &
execute_build "devbox-ultimate" &

wait

# Summary
echo "Summary of build statuses:"
for key in "${!status[@]}"; do
  if [ ${status[$key]} -eq 0 ]; then
    echo "$key: SUCCEEDED"
  else
    echo "$key: FAILED"
  fi
done
