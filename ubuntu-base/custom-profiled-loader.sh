#!/bin/bash
echo "$(date +"%Y-%m-%d %T") - Running custom profiled loader in ${SOURCE_SCRIPTS_FOLDER}" >> /tmp/custom-profiled-loader.log
if [ ! -z "${SOURCE_SCRIPTS_FOLDER}" ]; then
  for script in ${SOURCE_SCRIPTS_FOLDER}/*; do
    echo "$(date +"%Y-%m-%d %T") - Sourcing script: $script" >> /tmp/custom-profiled-loader.log
    source "$script"
  done
fi
