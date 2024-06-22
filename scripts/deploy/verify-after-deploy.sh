#!/usr/bin/env bash
# takes in a deployment file and verifies on etherscan (useful if you deploy without verification)
# needs to have ETHERSCAN_API_KEY set in the environment
# Taken from Telegram user @riordant
# thanks bud 
set -e
set -o xtrace
INPUT_FILE=$1
ARG_FILE="$(dirname $INPUT_FILE)/arguments.json"
CHAIN_ID=$(jq -r '.chain' < $INPUT_FILE)
COMPILER_VERSION="0.8.17"

LIBRARIES=""
for row in $(jq -c '.libraries[]' < ${INPUT_FILE}); do
    LIBRARIES+=" --libraries ${row}"
done
LIBRARIES=$( echo $LIBRARIES | tr -d '"' | tr -d "'" )

for row in $(jq -c '.transactions[]' < ${INPUT_FILE}); do
    _jq() {
     echo ${row} | jq -r ${1}
    }

    if [[ $(_jq '.transactionType') == "CREATE" ]]; then

      args=$(_jq '.arguments')
      CONSTRUCTOR_ARGS_PATH=""
      if [[ ${args} != "null" ]]; then
        echo ${args} > "${ARG_FILE}"
        CONSTRUCTOR_ARGS_PATH=--constructor-args-path=${ARG_FILE}
      fi
      if ! forge verify-contract "$(_jq '.contractAddress')" "$(_jq '.contractName')" --etherscan-api-key ${ETHERSCAN_API_KEY} --chain ${CHAIN_ID} --compiler-version ${COMPILER_VERSION} ${CONSTRUCTOR_ARGS_PATH} {$LIBRARIES}
          then
              echo "failed to verify $(_jq '.contractName')"
              continue
          fi

    fi
done
