#!/bin/bash

# Initialize failed_commands array
failed_commands=()

check_version() {
  local tool=$1
  local command=$2
  # Extract the command name without arguments
  local cmd_name=$(echo "$command" | awk '{print $1}')
  if command -v "$cmd_name" &> /dev/null; then
    version_output=$($command 2>&1)
    echo "$tool Version: $version_output"
  else
    echo "$tool Command Error: Not Installed"
    failed_commands+=("$tool")
  fi
}

check_failed_commands() {
  if [ ${#failed_commands[@]} -ne 0 ]; then
    echo "Failed Commands: ${failed_commands[*]}"
    exit 1
  fi
}
