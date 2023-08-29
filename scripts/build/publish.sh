#!/bin/bash

set -e  # Exit on error 

if [ -z "$IMAGE_BUILD_DIR" ]; then
  echo "Error: init_environment must be invoked before running this script."
  exit 1
fi

# Path to .env file
ENV_FILE="$REPO_ROOT/.env"

# Check if .env file exists
if [ -f "$ENV_FILE" ]; then
  source $ENV_FILE
else
  echo "Error: .env file is missing."
  exit 1
fi

# Authenticate to Docker Hub
echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin

# Push the Docker image to Docker Hub
echo "Pushing $IMAGE_NAME to Docker Hub..."
docker push "$IMAGE_NAME"

echo "Pushing $LATEST_TAG to Docker Hub..."
docker push "$LATEST_TAG"