#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

cd "$( dirname "${BASH_SOURCE[0]}" )"

source config.cfg

MAIN_CLASS=${1:-}

# Checkf if main class is given
if [[ -z "$MAIN_CLASS" ]]; then
    echo "Please pass class to run as argument." >&2
    exit 1
fi

# Remove the first argument - main class
shift

# Detect all libs
LIBS=""
if [[ -d $LIB_DIR ]]; then
    LIBS=$(find $LIB_DIR -maxdepth 1 -iname "*.jar")
fi

# Initialize classpath
CLASSPATH="$BIN_DIR"
if [[ "x$LIBS" != "x" ]]; then
    # Add libs to classpath
    CLASSPATH="$(echo "${LIBS}" | paste -sd ':' -):$CLASSPATH"
fi

# Run main class
java -classpath $CLASSPATH $PACKAGE.$MAIN_CLASS "$@"

