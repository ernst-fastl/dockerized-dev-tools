#!/bin/bash
set -e  # Exit on error

show_help() {
  echo "Usage: $0 [OPTION]... [DIRECTORY]"
  echo "Options:"
  echo "  -h, --help     Show help"
  echo "  -r, --run      Run bash in image"
  echo "  -p, --publish  Publish to Docker Hub"
  echo "  -s, --skip-build Skip building image"
  echo "  -t, --skip-test  Skip running tests"
}

SCRIPTS_DIR=$(git rev-parse --show-toplevel)/scripts/build

execute_script() {
  SCRIPT="$1"
  echo "Executing $SCRIPTS_DIR/$SCRIPT.sh"
  bash "$SCRIPTS_DIR/$SCRIPT.sh" || { echo "$SCRIPT failed"; exit 1; }
}

# Default directory is current
IMAGE_BUILD_DIR=$(basename $(pwd))

# Parse options
while :; do
  case "$1" in
    -h|--help)
      show_help
      exit
      ;;
    -r|--run)
      RUN_BASH=1
      ;;
    -p|--publish)
      PUBLISH=1
      ;;
    -s|--skip-build)
      SKIP_BUILD=1
      ;;
    -t|--skip-test)
      SKIP_TEST=1
      ;;
    *)
      if [ -n "$1" ]; then
        IMAGE_BUILD_DIR="$1"
      fi
      break
      ;;
  esac
  shift
done

# Call init_environment script and check for errors
. "$SCRIPTS_DIR/init_environment.sh" "$IMAGE_BUILD_DIR" || { echo "init_environment failed"; show_help; exit 1; }

# Execute scripts conditionally
[ "$SKIP_BUILD" != "1" ] && execute_script "build_image"
[ "$SKIP_TEST" != "1" ] && execute_script "run_tests"
execute_script "tag_image"

[ "$RUN_BASH" == "1" ] && execute_script "run_bash"
[ "$PUBLISH" == "1" ] && execute_script "publish"

echo "All tasks completed."
