#!/usr/env/bin bash

# ensure ETH_FROM is set and give a meaningful error message
if [[ -z ${ETH_FROM} ]]; then
  echo "ETH_FROM not found, please set it and re-run the last command."
  exit 1
fi

# Make sure address is checksummed
if [ "$ETH_FROM" != "$(seth --to-checksum-address "$ETH_FROM")" ]; then
  echo "ETH_FROM not checksummed, please format it with 'seth --to-checksum-address <address>'"
  exit 1
fi
