#!/bin/bash

set -e  # Exit on error

# Install prerequisite packages

./apt_clean_install.sh wget apt-transport-https software-properties-common

# Import Microsoft repository key
wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -

# Add Microsoft Package Feed
sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/ubuntu/$(lsb_release -rs)/prod $(lsb_release -cs) main"

# Update package list again
sudo apt-get update

# Install PowerShell
sudo apt-get install -y powershell

# Install Pester for testing
pwsh -Command 'Install-Module -Name Pester -Force -SkipPublisherCheck'

# Install PSReadline for better CLI experience
pwsh -Command 'Install-Module -Name PSReadline -Force -SkipPublisherCheck'

# Print installed versions
echo "Installed PowerShell version:"
pwsh --version
echo "Installed Pester version:"
pwsh -Command 'Get-Module -Name Pester -ListAvailable | Select-Object -Property Version'