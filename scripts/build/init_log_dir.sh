#!/bin/bash

REPO_ROOT=$(git rev-parse --show-toplevel)
LOG_DIR="$REPO_ROOT/build-logs"
SUMMARY_LOG_FILE="$LOG_DIR/$(date +%Y-%m-%d)-summary.log"
mkdir -p "$LOG_DIR"

export REPO_ROOT
export LOG_DIR
export SUMMARY_LOG_FILE