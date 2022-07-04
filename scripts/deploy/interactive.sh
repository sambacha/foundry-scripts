#!/usr/bin/env bash

export LC_ALL=C

# CONTRACT=src/Entrypoint.sol:EntrypointName
CONTRACT= 
BASE_ARGS="--rpc-url $ETH_RPC_URL --json $CONTRACT"

if [ "$1" == "-e" ]; then
    SHOW_ENV=1
fi

printEnv() {
    if [ "$SHOW_ENV" == "1" ]; then
        echo -e "ETH_RPC_URL\t\t\t$ETH_RPC_URL"
        echo -e "SIGNER_KEY\t\t$SIGNER_KEY"
        echo -e "CHAIN_OVERRIDE\t\t$CHAIN_OVERRIDE"
    fi
}

fsSync_Address() {
    echo $OUTPUT
    ADDRESS=$(echo $OUTPUT | jq .deployedTo)
    echo "{\"address\": $ADDRESS}" > contract.json
}

if [[ -f .env ]]; then
    echo "Loading '.env'..."
    # load .env
    set -a
    source <(cat .env | sed -e '/^#/d;/^\s*$/d' -e "s/'/'\\\''/g" -e "s/=\(.*\)/='\1'/g")
    set +a
    printEnv

    if [ -z $CHAIN_OVERRIDE ]; then
        echo "Using default CHAIN_ID"
    else
        CHAIN_ARG="--chain $CHAIN_OVERRIDE"
    fi

    echo "Deploying ($CONTRACT)..."
    OUTPUT=$(forge create --private-key $SIGNER_KEY $CHAIN_ARG $BASE_ARGS)
    fsSync_Address
else
    if [ -z $ETH_RPC_URL ]; then
        echo "![ERR]: ETH_RPC_URL must be set."
    else
        printEnv
        echo "[TASK]: Deploying..."
        # use interactive prompt
        script -q -c "forge create --interactive $BASE_ARGS" tmpOutput
        OUTPUT=$(cat tmpOutput | tail -n +4 | head -n 1)
        fsSync_Address
    fi
fi

echo "You can remove tmpOutput file after deployment."

#  LC_ALL=C sort -t. -k 1,1 -k 2,2n -k 3,3n
