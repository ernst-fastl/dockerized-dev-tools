#!/bin/bash

# Check if script is running as root
if [ "$(id -u)" != "0" ]; then
    echo "This script must be run as root"
    exit 1
fi

# Install curl and git via custom script
/opt/devbox/apt-clean-install.sh curl git

# Set path to the Homebrew installation script
INSTALL_SCRIPT="/opt/devbox/homebrew-head-install.sh"

# Download Homebrew installation script
curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh -o "$INSTALL_SCRIPT"

# Set NONINTERACTIVE environment variable
export NONINTERACTIVE=1

# Run Homebrew installation script
/bin/bash "$INSTALL_SCRIPT"

# Move Homebrew installation to global path
mv /home/linuxbrew/.linuxbrew /usr/local/

# Add brew shellenv command to /etc/profile
echo 'eval "$(/usr/local/bin/brew shellenv)"' >> /etc/profile
