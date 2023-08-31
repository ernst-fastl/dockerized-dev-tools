#!/bin/bash
# custom-profiled-loader.sh

if [ ! -z "${SOURCE_SCRIPTS_FOLDER}" ]; then
  for script in ${SOURCE_SCRIPTS_FOLDER}/*; do
    source "$script"
  done
fi
