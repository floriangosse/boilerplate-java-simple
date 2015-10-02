#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

cd "$( dirname "${BASH_SOURCE[0]}" )"

source config.cfg

# Initialize classpath
CLASSPATH="$BIN_DIR"
# Detect all libs
LIBS=$(find $LIB_DIR -maxdepth 1 -iname "*.jar")

if [[ "x$LIBS" != "x" ]]
then
    # Add libs to classpath
    CLASSPATH="$(echo "${LIBS}" | paste -sd ':' -):$CLASSPATH"
fi

# Run main class
java -classpath $CLASSPATH $MAIN_CLASS $MAIN_CLASS_ARGUMENTS

