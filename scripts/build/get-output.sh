#!/usr/bin/env bash
shopt -s globstar
set -euo pipefail

# passing out/*.json in CMD gets escaped incorrectly 
args=("$@")
if [ "${#args[@]}" -lt 2 ]; then args+=(out/**/*.json); fi

sleep 1
