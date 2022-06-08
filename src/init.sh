#!/usr/bin/env bash

set -euo pipefail
test "${DEBUG:-}" && set -x

## Override any user-supplied umask that could cause problems
umask 002

## @note https://unix.stackexchange.com/a/145654/108960
log_file="foundry_script_log-`date +'%Y-%m-%d_%H-%M-%S'`.txt"
exec &> >(tee -a "$log_file")

# Work from /install/ for install.sh, project root otherwise
if [[ "$(basename $0)" = "install.sh"  ]]; then
  cd "$(dirname $0)/install/"
else
  cd "$(dirname $0)"  # assume we're a test script or some such
fi

## Allow `.env` overrides using the `.env.custom` file
if [[ -f "../.env.custom" ]]; then
  _ENV="$(realpath ../.env.custom)"
else
  _ENV="$(realpath ../.env)"
fi

## Read .env for default values
## @see https://stackoverflow.com/a/59831605/90297
t=$(mktemp) && export -p > "$t" && set -a && . $_ENV && set +a && . "$t" && rm "$t" && unset t
