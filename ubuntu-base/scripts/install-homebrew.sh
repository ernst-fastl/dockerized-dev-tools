#!/bin/bash

# Check if script is running with root privileges
if [ "$(id -u)" != "0" ]; then
    echo "This script must be run as root"
    exit 1
fi

/opt/devbox/apt-clean-install.sh curl git

# Set the path to the install script
INSTALL_SCRIPT="/opt/devbox/homebrew-head-install.sh"

# Download the install script
curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh -o "$INSTALL_SCRIPT"

# Set the NONINTERACTIVE environment variable
export NONINTERACTIVE=1

# Run the install script
/bin/bash "$INSTALL_SCRIPT"

# Add the brew shellenv command to /etc/profile
echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> /etc/profile