#!/bin/bash

set -e  # Exit if any command fails

# SSH server and shell utilities
./apt_clean_install.sh --skip-cleanup openssh-server bash-completion bash-doc zsh zsh-syntax-highlighting 

# Essential system tools 
./apt_clean_install.sh --skip-cleanup --skip-update man-db procps file htop lsof 

# Essential build tools
./apt_clean_install.sh --skip-cleanup --skip-update gcc build-essential vim cmake gdb make libffi-dev \
    libssl-dev zlib1g-dev liblzma-dev libreadline-dev libsqlite3-dev software-properties-common 

# Git Version Control
./apt_clean_install.sh --skip-cleanup --skip-update git git-flow gh git-lfs pre-commit tig git-extras git-secrets

# Text and search utilities
./apt_clean_install.sh --skip-cleanup --skip-update jq mlocate wget fzf 

# Security and certificates
./apt_clean_install.sh --skip-cleanup --skip-update ca-certificates curl gnupg openssl fail2ban

# Network tools
./apt_clean_install.sh --skip-cleanup --skip-update dhcping iputils-ping iputils-tracepath iptraf-ng \
    httpie nmap netcat-traditional traceroute

#archive tools
./apt_clean_install.sh --skip-update unzip zip rar unrar bzip2 gzip tar