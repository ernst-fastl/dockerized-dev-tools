#!/bin/bash

#This script updates, upgrades, installs packages, and cleans up unused files on an Ubuntu system.

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
            # Split line into package names and add to array
            read -ra pkgs <<< "$line"
            for pkg in "${pkgs[@]}"; do
                packages+=("$pkg")
            done
        done < "$arg"
    else
        # Collect package
        packages+=("$arg")
    fi
done

# Update the package list
echo "Updating APT package list"
echo -e "\n--- Updating APT package list: ---\n"
apt update -yq

# Log the package list to the console
echo -e "\n--- Installing APT packages: ---\n"
printf '%s\n' "${packages[@]}"
echo -e "\n---\n"

# Set DEBIAN_FRONTEND to noninteractive to suppress prompts
export DEBIAN_FRONTEND=noninteractive

# Install APT packages and exit with an error if any installation fails
if ! apt-get install -yq --no-install-recommends "${packages[@]}"; then
    echo "Error: APT package installation failed"
    exit 1
fi

# Cleanup

echo -e "\n--- Cleaning up ---\n"

apt clean -q
apt autoremove -yq
rm -rf /var/lib/apt/lists/*