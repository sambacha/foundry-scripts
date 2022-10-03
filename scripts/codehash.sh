#!/usr/bin/env bash
set -eo pipefail

codehash() {
if [[ -z $CONTRACT ]]; then
  if [[ -z ${1} ]]; then
    echo '"$CONTRACT" env variable is not set. Set it to the name of the contract you want the codehash for.'
    exit 127
  else
    CONTRACT=${1}
    cat out/$CONTRACT.sol/$CONTRACT.json | jq -r .bytecode.object | xargs cast keccak
  fi
fi
}
