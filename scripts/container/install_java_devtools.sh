#!/bin/bash

set -e  # Exit on error

# Install Java
./apt_clean_install.sh default-jdk scala leiningen maven gradle

# Install SDKMAN
curl -s https://get.sdkman.io | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"

# Update SDKMAN
sdk selfupdate

# Config file path
CONFIG_FILE="/root/.sdkman/etc/config"

# Validate existence
[ ! -f "$CONFIG_FILE" ] && echo "Error: Config file not found." && exit 1

# Replace auto answer value
sed -i 's/sdkman_auto_answer=false/sdkman_auto_answer=true/' $CONFIG_FILE

# Find latest Corretto versions
set -x # Enable debug

LATEST_CORRETTO_8=$(sdk list java | grep -E '8.0.*-amzn' | head -n 1 | awk '{print $NF}')
LATEST_CORRETTO_11=$(sdk list java | grep -E '11.0.*-amzn' | head -n 1 | awk '{print $NF}')
LATEST_CORRETTO_17=$(sdk list java | grep -E '17.0.*-amzn' | head -n 1 | awk '{print $NF}')
LATEST_CORRETTO=$(sdk list java | grep 'amzn' | head -n 1 | awk '{print $NF}')

# Install Java versions
sdk install java $LATEST_CORRETTO_8
sdk install java $LATEST_CORRETTO_11
sdk install java $LATEST_CORRETTO_17
sdk install java $LATEST_CORRETTO

# Set default version
sdk default java $LATEST_CORRETTO

sdk install kotlin
sdk install groovy
sdk install sbt
sdk install ant
sdk install grails
sdk install jmeter
sdk install jmc
sdk install springboot

# Install Clojure
./brew_clean_install.sh clojure/tools/clojure