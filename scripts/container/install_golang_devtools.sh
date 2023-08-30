#!/bin/bash
set -e  # Exit on error

# Fetch latest Go version
FILE_NAME=$(curl -s https://go.dev/dl/ | grep -oP 'go([0-9\.]+)\.linux-amd64\.tar\.gz' | head -n 1)

# Download and install Go
echo "Downloading Go Version ${FILE_NAME}"

DOWNLOAD_URL="https://go.dev/dl/${FILE_NAME}"

echo $DOWNLOAD_URL

wget $DOWNLOAD_URL

echo "Extracting Go ${LATEST_GO_VERSION}..."

tar -xvf $FILE_NAME
mv go /usr/local
rm $FILE_NAME

# Set GOPATH and add to PATH
echo "Setting GOPATH and adding to PATH..."

echo 'export GOPATH=$HOME/go' >> /etc/profile
echo 'export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin' >> /etc/profile

source /etc/profile