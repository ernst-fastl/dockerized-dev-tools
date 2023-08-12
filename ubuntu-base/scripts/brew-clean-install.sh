#!/bin/bash

#This script updates, upgrades, installs packages, and cleans up unused files using homebrew.

# Ensure script has been called with at least one argument
if [ $# -eq 0 ]; then
    echo "No packages provided. Usage: $0 package1 [package2 ...] [file1.txt ...]"
    exit 1
fi

# Check if script is running with root privileges
if [ "$(id -u)" != "0" ]; then
    echo "This script must be run as root"
    exit 1
fi

. /etc/profile

# Update Homebrew and upgrade all installed packages
brew update
brew upgrade

# Collect package names in an array
packages=()
for arg in "$@"; do
    if [ -f "$arg" ]; then
        # Collect packages listed in text file
        while read line; do
            # Ignore comments and empty lines
            if [[ "$line" =~ ^\s*# ]] || [[ -z "$line" ]]; then
                continue
            fi
            packages+=("$line")
        done < "$arg"
    else
        # Collect package
        packages+=("$arg")
    fi
done

# Log the package list to the console
echo "Installing Homebrew packages:"
printf '%s\n' "${packages[@]}"

# Install packages
brew update
brew install "${packages[@]}"

# Cleanup
brew cleanup
rm -rf $(brew --cache)