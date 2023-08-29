#!/bin/bash

source /opt/devbox/test_installed_tool_versions.sh

# Call check_version for each tool with its corresponding version command
check_version "Python" "python --version"
check_version "Pip" "pip --version"
check_version "Pipenv" "pipenv --version"

# Check failed commands and exit if needed
check_failed_commands