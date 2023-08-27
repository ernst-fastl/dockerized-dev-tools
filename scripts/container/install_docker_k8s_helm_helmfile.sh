#!/bin/bash

# Docker CLI Installation
curl -fsSL https://get.docker.com -o get-docker.sh && sh get-docker.sh

# Kubernetes (kubectl) Installation
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x kubectl && mv kubectl /usr/local/bin/

# Helm Installation
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh && ./get_helm.sh

# Helmfile Installation (aktuellste Version)
LATEST_HELMFILE=$(curl --silent "https://api.github.com/repos/roboll/helmfile/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')
wget "https://github.com/roboll/helmfile/releases/download/${LATEST_HELMFILE}/helmfile_linux_amd64"
chmod +x helmfile_linux_amd64 && mv helmfile_linux_amd64 /usr/local/bin/helmfile
