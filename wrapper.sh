#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

cd /usr/src
/root/.cabal/bin/shellcheck "$@"
