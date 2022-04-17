#!/usr/bin/env bash

# Usage: check-shell

set -euo pipefail

cd "${0%/*}/.."

echo "Checking Shellcode"

# FIXME: Avoid inplace (-w) modifications for now.
find sh -type f \
    -exec shfmt -s -i 2 -ln bash -l {} \+ \
    -exec shellcheck --shell=bash --format=tty {} \+
