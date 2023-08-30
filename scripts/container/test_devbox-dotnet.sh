#!/bin/bash

source /opt/devbox/test_installed_tool_versions.sh

# Call check_version for each tool with its corresponding version command
check_version "Dotnet" "dotnet --info"
#TODO: check why this hangs
# check_version "Nuget" "nuget"

# Check failed commands and exit if needed
check_failed_commands