# dockerized-dev-tools
Ubuntu, DinD, DooD &amp; dev-container images.

# Unified Docker Images Collection

This repository hosts a collection of scripts and Dockerfiles designed to streamline development and deployment processes. It includes a base Ubuntu rolling image with essential command-line tools, Docker-in-Docker (DinD), Docker-outside-of-Docker (DooD), and specialized images tailored for development containers.

## Table of Contents

- [Features](#features)
- [Getting Started](#getting-started)

## Features

This repo contains build scripts and docker files to create the following docker images:

### Stage 1: Base Images

1. **ubuntu-base**: This is the base image with Ubuntu setup, which serves as a foundation for other images.
2. **devbox-base**: Built upon the ubuntu-base, it includes essential tools and configurations common across the dev environments.
3. **devbox-helm**: This includes Helm setup, configured and ready to use for Kubernetes package management.

### Stage 2: Scripting Images

In this stage, several images are built in parallel to save time. These images are:

1. **devbox-scripting**: An image that contians all of the stage 2 scripting languages dev tools.
2. **devbox-python**: A Python development environment.
3. **devbox-ruby**: A Ruby development environment.
4. **devbox-perl**: A Perl development environment.
5. **devbox-node**: A Node.js development environment, ideal for JavaScript and TypeScript development.
6. **devbox-powershell**: A PowerShell development environment, tailored for Windows PowerShell scripting.

### Stage 3: High-Level Images

This stage focuses on building images for high-level programming languages. All of these images are based on **devbox-scripting**:

1. **devbox-java**: An environment suited for Java development, including JDK setup.
2. **devbox-dotnet**: A .NET development environment with necessary SDKs and runtimes.
3. **devbox-go**: A Go development environment with the Go language SDK installed.

### Stage 4: Ultimate Image

1. **devbox-ultimate**: This image integrates elements from all the above images, providing a comprehensive development environment with a wide array of tools and SDKs, making it the ultimate development toolbox.

## Getting Started

This guide will help you to get started with building and using the development environment docker images.

### Prerequisites

Ensure you have the following installed:
- Docker
- Git

### Clone the Repository

Start by cloning the repository to your local machine:

```bash
git clone https://github.com/ernst-fastl/dockerized-dev-tools.git
cd dockerized-dev-tools
```

### Building Images


#### Building All Images

To build all the images at once, you can use the ./build-all.sh script. Simply run:

```bash
./build-all.sh
```

#### Building a Single Image
To build a single image, use the ./build.sh script followed by the folder name of the image you wish to build. For example, to build the devbox-java image, you would run:

```bash
./build.sh devbox-java
```

### Help
Both build.sh and build-all.sh scripts support the -h and --help options to provide more information on how to use the scripts. Use them as follows:

```bash
./build.sh -h
# or
./build-all.sh --help
```
Now you are ready to build and explore the dockerized development environments. Happy coding!