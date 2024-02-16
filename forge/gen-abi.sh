#!usr/bin/env bash

echo "Generating ABI..."

# Clean old build artifacts
rm -rf abi
rm -rf out

# forge build: outputs normal forge .json files and .abi.json files to out/
FOUNDRY_IGNORED_ERROR_CODES='[5574,5740,1878]' forge build --extra-output-files abi

# Move .abi.json files to abi/
# Cange extension from .abi.json to .json so typechain doesn't generate types like 'ContractNameAbi'
mkdir -p abi/
cp out/**/*.abi.json abi/
for file in abi/*.abi.json; do
    mv -- "$file" "${file%.abi.json}.json"
done

echo "Generated ABI!"
exit 0
