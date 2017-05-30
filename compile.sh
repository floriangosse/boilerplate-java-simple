#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

cd "$( dirname "${BASH_SOURCE[0]}" )"

source config.cfg

# Create bin directory of not exists
[ -d $BIN_DIR ] || mkdir -p $BIN_DIR

# Detect all libs
LIBS=""
if [[ -d $LIB_DIR ]]; then
    LIBS=$(find $LIB_DIR -maxdepth 1 -iname "*.jar")
fi
# Detect all java files
FILES=$(find $SRC_DIR -type f -iname "*.java" | paste -sd ' ' -)

# Initialize classpath
CLASSPATH="$BIN_DIR"
if [[ "x$LIBS" != "x" ]]; then
    # Add libs to classpath
    CLASSPATH="$(echo "${LIBS}" | paste -sd ':' -):$CLASSPATH"
fi

echo "Start compiling"

# Compile all java files
javac \
    -sourcepath $SRC_DIR \
    $([[ "x$CLASSPATH" != "x" ]] && echo "-classpath $CLASSPATH ") \
    -d $BIN_DIR \
    $FILES
exit_status=$?

[[ $exit_status == 0 ]] \
    && echo "Finish compiling successful" \
    || echo "Finish compiling unsuccessful"

exit $exit_status

