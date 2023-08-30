#!/bin/bash
# Define NVM directory
export NVM_DIR="/usr/local/nvm"

# Add NVM_DIR to PATH
export PATH="$NVM_DIR:$PATH"

# Check if "/nvm.sh" exists and is not empty
if [ -s "$NVM_DIR/nvm.sh" ]; then
  # Source "/nvm.sh" if the file exists and is not empty
  . "$NVM_DIR/nvm.sh"
else
  # Print a warning if the file is missing or empty
  echo "Warning: $NVM_DIR/nvm.sh is either missing or empty."
fi