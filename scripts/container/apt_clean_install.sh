#!/bin/bash

set -e # Exit if any command fails

show_help() {
    echo "Usage: $0 [OPTION]... [PACKAGE]..."
    echo "Options:"
    echo "  -h, --help     Show help"
    echo "  -s, --skip-update  Skip updating APT package list"
    echo "  -c, --skip-cleanup  Skip cleanup after installation"
}

SKIP_UPDATE=0
SKIP_CLEANUP=0

# Parse options
while :; do
    case "$1" in
    -h | --help)
        show_help
        exit
        ;;
    -s | --skip-update)
        SKIP_UPDATE=1
        ;;
    -c | --skip-cleanup)
        SKIP_CLEANUP=1
        ;;
    *)
        break
        ;;
    esac
    shift
done

# Proceed only if arguments are left after option parsing
if [ $# -eq 0 ]; then
    echo "No packages provided. Use -h for help."
    exit 1
fi

# Verify root privileges
if [ "$(id -u)" != "0" ]; then
    echo "Must be run as root."
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
            read -ra pkgs <<<"$line"
            for pkg in "${pkgs[@]}"; do
                packages+=("$pkg")
            done
        done <"$arg"
    else
        # Collect package
        packages+=("$arg")
    fi
done


# Log the package list to the console
echo -e "\n--- Installing APT packages: ---\n"
printf '%s\n' "${packages[@]}"
echo -e "\n---\n"

# Set DEBIAN_FRONTEND to noninteractive to suppress prompts
export DEBIAN_FRONTEND=noninteractive

# Update, if not skipped
if [ "$SKIP_UPDATE" -eq 0 ]; then
    echo "--- Updating APT ---"
    apt update -yq
    apt upgrade -yq
fi

# Installation
echo "--- Installing Packages ---"
apt-get install -yq --no-install-recommends "${packages[@]}"

# Cleanup, if not skipped
if [ "$SKIP_CLEANUP" -eq 0 ]; then
    echo -e "\n--- Cleaning up Apt package lists, autoremove etc. ---\n"
    apt clean -q
    apt autoremove -yq
    rm -rf /var/lib/apt/lists/*
fi
