#!/bin/bash

source /opt/devbox/test_installed_tool_versions.sh

# Call check_version for each tool with its corresponding version command
check_version "SSH" "ssh -V"
check_version "GCC" "gcc --version"
check_version "Git" "git --version"
check_version "Curl" "curl --version"
check_version "Wget" "wget --version"
check_version "Tar" "tar --version"
check_version "Unzip" "unzip -v"

# Check failed commands and exit if needed
check_failed_commands