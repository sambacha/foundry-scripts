#!/bin/bash

# Etherscan requires leading 'v' which isn't in the artifacts
version="v${version}"

# Get the list of supported solc versions and compare
# Etherscan uses the js solc, which is not guaranteed to match the C distribution signature

version_list=$(curl -fsS "https://raw.githubusercontent.com/ethereum/solc-bin/gh-pages/bin/list.txt")
# There have been a couple of instances where the solc js release used by
#   Etherscan does not match the tag of the C distributions.
if [[ $version_list != *"$version"* ]]; then
  regex="(.+commit+.)"
  # Version incompatible with js release
  echo "Compiler version $version is not compatible with etherscan"
  if [[ $version =~ $regex ]]; then
    version_proto=${BASH_REMATCH[1]}
    version=$(echo "$version_list" | grep -o "${version_proto}\{8\}")
    echo "Attempting ${version}"
  fi
fi
