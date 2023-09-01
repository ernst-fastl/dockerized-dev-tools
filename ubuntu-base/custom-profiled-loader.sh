#!/bin/bash
export CUSTOM_PROFILED_LOADER_RAN=1
if [ ! -z "${SOURCE_SCRIPTS_FOLDER}" ]; then
  for script in ${SOURCE_SCRIPTS_FOLDER}/*; do
    source "$script"
  done
fi
