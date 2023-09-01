#!/bin/bash
set -e  # Exit if any command fails

# Check if script is running as root
if [ "$(id -u)" != "0" ]; then
    echo "This script must be run as root"
    exit 1
fi

# Install curl and git via custom script
/opt/devbox/apt_clean_install.sh build-essential procps curl file git ca-certificates

# Set path to the Homebrew installation script
INSTALL_SCRIPT="/opt/devbox/downloaded-homebrew-install.sh"

# Download Homebrew installation script
curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh -o "$INSTALL_SCRIPT"

# Set NONINTERACTIVE environment variable
export NONINTERACTIVE=1

# bugfix
export HOMEBREW_NO_INSTALL_FROM_API=1

# Run Homebrew installation script
/bin/bash "$INSTALL_SCRIPT"

# Add brew shellenv command to /etc/profile
echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> /etc/profile
