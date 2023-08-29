#!/bin/bash

# Initialize failed_commands array
failed_commands=()

check_version() {
  local tool=$1
  local command=$2
  version_output=$($command 2>&1)
  if [ $? -eq 0 ]; then
    echo "$tool Version: $version_output"
  else
    echo "$tool Command Error: $version_output"
    failed_commands+=("$tool")
  fi
}

check_failed_commands() {
  if [ ${#failed_commands[@]} -ne 0 ]; then
    echo "Failed Commands: ${failed_commands[*]}"
    exit 1
  fi
}
