#!/bin/bash

source /opt/devbox/test_installed_tool_versions.sh

# Call check_version for each tool with its corresponding version command
check_version "Docker" "docker --version"
check_version "Docker Compose" "docker compose version"
check_version "Kubectl" "kubectl version --client"
check_version "Helm" "helm version --short"
check_version "Helmfile" "helmfile --version"

# Check failed commands and exit if needed
check_failed_commands