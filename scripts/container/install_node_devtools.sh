#!/bin/bash

set -e  # Exit on error

# printf "\nAdding node repository...\n"

# curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
# NODE_MAJOR=20
# echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list

# printf "\nInstalling nodejs... \n"

# ./apt_clean_install.sh nodejs

echo "Fetching latest NVM version..."

# Get latest version
latest_nvm_version=$(curl -s https://api.github.com/repos/nvm-sh/nvm/releases/latest | grep 'tag_name' | cut -d\" -f4)
echo "Latest version is $latest_nvm_version"

# Create directory for all users
mkdir -p /usr/local/nvm

# Download installer
echo "Installing NVM..."
curl -o- "https://raw.githubusercontent.com/nvm-sh/nvm/$latest_nvm_version/install.sh" | NVM_DIR=/usr/local/nvm bash

# Echo source lines
echo "Add these lines to /etc/profile or /etc/bash.bashrc for all users to access NVM"
echo "export NVM_DIR=\"/usr/local/nvm\""
echo "[ -s \"$NVM_DIR/nvm.sh\" ] && \\. \"$NVM_DIR/nvm.sh\""

# Add to /etc/profile for all users
echo "Adding nvm shell init to /etc/profile..."

echo "source /opt/devbox/nvm_shell_init.sh" >> /etc/profile

source ./nvm_shell_init.sh

# Install latest version
echo "Installing latest version of NodeJS..."

nvm install node

# Install latest LTS version
echo "Installing latest LTS version of NodeJS..."
nvm install --lts

# Set as default
echo "Setting latest LTS version as default..."
nvm alias default lts/*

printf "\nInstalling npm packages... \n"

# Global npm packages
npm install -g npm@latest

# Angular CLI
npm install -g @angular/cli

# React CLI
npm install -g create-react-app

# ESLint & TypeScript
npm install -g eslint typescript

# Yarn package manager
npm install -g yarn

# Gulp
npm install -g gulp

# Grunt
npm install -g grunt

# Webpack
npm install -g webpack webpack-cli

# Vue CLI
npm install -g @vue/cli

# Ember CLI
npm install -g ember-cli

# Ionic CLI
npm install -g @ionic/cli
