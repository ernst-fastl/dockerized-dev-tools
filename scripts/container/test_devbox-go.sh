#!/bin/bash

source /opt/devbox/test_installed_tool_versions.sh

# Call check_version for each tool with its corresponding version command
check_version "Go" "go version"
check_version "GolangCI-Lint" "golangci-lint --version"
check_version "Ginkgo" "ginkgo version"
check_version "Gomega" "ginkgo version"
check_version "GoMock" "mockgen --version"
check_version "GoMock" "mockery --version"

# Check failed commands and exit if needed
check_failed_commands