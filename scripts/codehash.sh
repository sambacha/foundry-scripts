cat out/$CONTRACT.sol/$CONTRACT_ABI.json | jq -r .bytecode.object | xargs cast keccak
