#!/bin/bash

#This script updates, upgrades, installs packages, and cleans up unused files on an Ubuntu system.

# Ensure script has been called with at least one argument
if [ $# -eq 0 ]; then
    echo "No packages provided. Usage: $0 package1 [package2 ...]"
    exit 1
fi

# Update the package list, upgrade all installed packages, and install the packages
apt-get update
apt-get upgrade -y
apt-get install -y "$@"

# Cleanup
apt-get clean
apt-get autoremove -y
rm -rf /var/lib/apt/lists/*