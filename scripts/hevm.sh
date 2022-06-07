#!/bin/bash
hevm() {
  hevm dapp-test --rpc="${ETH_RPC_URL}" --json-file=out/dapp.sol.json --dapp-root=. --verbose 2 --match "test_gas"
}
