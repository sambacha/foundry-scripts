#!/usr/bin/env bash
set -eu
export LC_ALL=C
forge build
ABI=$(cat out/$CONTRACT_NAME.sol/$CONTRACT_NAME.json | jq .abi)
echo $ABI > ../dist/src/abi/$CONTRACT_NAME.json
