#!/usr/bin/env bash

export LANG=C.UTF-8
function dapptest() {
  ETH_RPC_URL=${1##*/}
  if [ -d "$cloneDirName" ]; then
    hevm dapp-test --rpc="${ETH_RPC_URL}" --json-file=out/dapp.sol.json --dapp-root=. --verbose 2 --match "test_gas"
    return
  fi
exit 127
}