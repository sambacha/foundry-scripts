#!/usr/bin/env bash

set -e

while getopts t:r: flag
do
    case "${flag}" in
        t) test=${OPTARG};;
        r) runs=${OPTARG};;
    esac
done

runs=$([ -z "$runs" ] && echo "1" || echo "$runs")

[[ $SKIP_MAINNET_CHECK || "$ETH_RPC_URL" && "$(cast chain)" == "ethlive" ]] || { echo "Please set a mainnet ETH_RPC_URL"; exit 1; }

export DAPP_FORK_BLOCK=14341118
export DAPP_SOLC_VERSION=0.8.7
export DAPP_SRC="src"
export PROPTEST_CASES=$runs

if [ -z "$test" ]; then match="[src/test/*.t.sol]"; else match=$test; fi

forge test --match "$match" --rpc-url "$ETH_RPC_URL" --lib-paths "lib" -vvv --optimize
