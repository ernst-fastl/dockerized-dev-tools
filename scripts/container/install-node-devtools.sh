#!/bin/bash

# Install Node.js & npm
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash - &&\
sudo apt-get install -y nodejs

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