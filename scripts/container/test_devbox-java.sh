#!/bin/bash

source /opt/devbox/test_installed_tool_versions.sh

# Call check_version for each tool with its corresponding version command
check_version "Java" "java --version"
check_version "Maven" "mvn --version"
check_version "Gradle" "gradle --version"
check_version "Ant" "ant -version"
check_version "Groovy" "groovy --version"
check_version "Scala" "scala -version"
check_version "Kotlin" "kotlin -version"
check_version "Clojure" "clojure -e '(clojure-version)'"
check_version "Leiningen" "lein --version"
check_version "Sbt" "sbt sbtVersion"

# Check failed commands and exit if needed
check_failed_commands