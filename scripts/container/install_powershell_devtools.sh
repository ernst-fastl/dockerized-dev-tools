#!/bin/bash

set -e  # Exit on error

# Install prerequisite packages

./apt_clean_install.sh wget apt-transport-https software-properties-common

# Add Microsoft repository
wget -q "https://packages.microsoft.com/config/ubuntu/$(lsb_release -rs)/packages-microsoft-prod.deb"

sudo dpkg -i packages-microsoft-prod.deb
rm packages-microsoft-prod.deb

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