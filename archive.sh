#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

cd "$( dirname "${BASH_SOURCE[0]}" )"

source config.cfg

NAME=${1:-}
MAIN_CLASS=${2:-}

# Checkf if main class is given
if [[ -z "$MAIN_CLASS" ]]; then
    echo "Please pass name as argument." >&2
    exit 1
fi

# Checkf if main class is given
if [[ -z "$MAIN_CLASS" ]]; then
    echo "Please pass class as argument." >&2
    exit 1
fi

jar cfe $NAME.jar $PACKAGE.$MAIN_CLASS -C $BIN_DIR .;