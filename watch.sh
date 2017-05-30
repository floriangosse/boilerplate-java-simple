#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

cd "$( dirname "${BASH_SOURCE[0]}" )"

source config.cfg

execute-task() {
    if [[ "x$1" == "x" ]]; then
        echo "No task specified"
        return 1
    fi

    ./${1}.sh 2>&1 | sed "s/^/${1}> /g"
    return $?
}

# Watch source directory for modification
inotifywait -m -r -q --format '%w%f' -e modify $SRC_DIR | while read filename; do
    # Check if changed file is java file
    [[ $filename == *.java ]] && execute-task clean && execute-task compile
done
