#!/bin/bash

source /opt/devbox/test_installed_tool_versions.sh

# Call check_version for each tool with its corresponding version command
check_version "Ruby" "ruby --version"
check_version "Bundler" "bundle --version"
check_version "Rake" "rake --version"

# Check failed commands and exit if needed
check_failed_commands