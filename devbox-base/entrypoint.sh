#!/bin/bash

echo "Container started $(date)"
echo "Entering endless loop to keep container running while waiting for IDEs to connect..."
echo "Press [CTRL+C] to stop..."

trap "echo 'Signal caught, exiting!'; exit;" SIGINT SIGTERM
sleep infinity

