#!/usr/bin/env just --justfile

bt := '0'

export RUST_BACKTRACE := bt

log := "warn"

export JUST_LOG := log

_default:
  just --list

# load .env file
set dotenv-load

DAPP_BUILD_OPTIMIZE := "1"
DAPP_COVERAGE       := "1"
# when developing we only want to fuzz briefly
DAPP_TEST_FUZZ_RUNS := "100"

ALCHEMY_KEY := env_var("ALCHEMY_KEY")
MAINNET_RPC := "https://eth-mainnet.alchemyapi.io/v2/" + ALCHEMY_KEY
MNEMONIC    := env_var("MNEMONIC")






size:
	forge build --sizes --force


# build using forge
build: && _timer
	cd {{ invocation_directory() }}; forge build


# default test scripts
test: test-local

# run local forge test using --match <PATTERN>

test-local *commands="": && _timer
	cd {{ invocation_directory() }}; forge test -m ".t.sol" {{ commands }}

# run mainnet fork forge tests (all files with the extension .debug.sol)
test-mainnet *commands="": && _timer
	cd {{ invocation_directory() }}; forge test --rpc-url {{ MAINNET_RPC }} -m ".debug.sol" {{ commands }}




# utility functions
start_time := `date +%s`
_timer:
	@echo "Task executed in $(($(date +%s) - {{ start_time }})) seconds"
