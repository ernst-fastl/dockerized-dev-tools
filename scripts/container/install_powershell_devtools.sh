#!/bin/bash

set -e  # Exit on error

# Install prerequisite packages

./apt_clean_install.sh wget apt-transport-https software-properties-common

# Download the Microsoft repository GPG keys
# NOTE unfortunatly microsofts package lists for lunar don't contain powershell so we use 22.04 LTS
wget -q "https://packages.microsoft.com/config/ubuntu/22.04/packages-microsoft-prod.deb"

# Register the Microsoft repository GPG keys
sudo dpkg -i packages-microsoft-prod.deb
# Delete the the Microsoft repository GPG keys file
rm packages-microsoft-prod.deb
# Update the list of packages after we added packages.microsoft.com
sudo apt-get update
# Install PowerShell
./apt_clean_install.sh powershell

# Install Pester for testing
pwsh -Command 'Install-Module -Name Pester -Force -SkipPublisherCheck'

# Install PSReadline for better CLI experience
pwsh -Command 'Install-Module -Name PSReadline -Force -SkipPublisherCheck'

# Print installed versions
echo "Installed PowerShell version:"
pwsh --version
echo "Installed Pester version:"
pwsh -Command 'Get-Module -Name Pester -ListAvailable | Select-Object -Property Version'