#!/usr/bin/env just --justfile

alias t := test

alias c := check

bt := '0'

export RUST_BACKTRACE := bt

log := "warn"

export JUST_LOG := log

test:
  forge test

build:
  forge build --root .

run:
  forge run
  
install:
  forge install

check:
  forge test -f $ETH_RPC_URL -vvv
  
payload:
  env_vars_payload () {
    echo "{\"deployment_configs\":{\"$1\":{\"env_vars\":$2}}}"
 }

# mode: makefile
# End:
# vim: set ft=make :
