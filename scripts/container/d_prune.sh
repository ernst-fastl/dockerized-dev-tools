#!/bin/bash

# Remove all stopped containers
sudo docker container prune -f

# Remove all unused networks
sudo docker network prune -f

# Remove all unused images
sudo docker image prune -a -f

# Remove all unused volumes
sudo docker volume prune -f

# Remove all unused build cache
sudo docker builder prune -a -f