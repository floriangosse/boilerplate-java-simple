#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

cd "$( dirname "${BASH_SOURCE[0]}" )"

source config.cfg

[[ -d "$BIN_DIR" ]] && rm -r "$BIN_DIR"
mkdir -p "$BIN_DIR"

echo "Clean finish"
