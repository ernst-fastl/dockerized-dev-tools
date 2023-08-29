#!/bin/bash

source /opt/devbox/test_installed_tool_versions.sh

# Call check_version for each tool with its corresponding version command
check_version "Node" "node --version"
check_version "NPM" "npm --version"
check_version "Yarn" "yarn --version"
check_version "Gulp" "gulp --version"
check_version "Grunt" "grunt --version"
check_version "Webpack" "webpack --version"
check_version "Vue" "vue --version"
check_version "Angular" "ng --version"
check_version "React" "react --version"
check_version "Ember" "ember --version"
check_version "Ionic" "ionic --version"


# Check failed commands and exit if needed
check_failed_commands