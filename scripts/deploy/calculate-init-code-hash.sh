#!/usr/bin/env bash

# Function to exit on error with a message
exit_on_error() {
  echo "Error: $1"
  exit 1
}

# Function to display usage information
usage() {
  echo "Usage: $0 <contract_path> <contract_name> [-v]"
  echo "  <contract_path> : Path to the Solidity contract file"
  echo "  <contract_name> : Name of the Solidity contract"
  echo "  -v              : Enable verbose output (optional)"
  exit 1
}

# Check if foundry is installed
if ! command -v forge &> /dev/null; then
  exit_on_error "Foundry is not installed. Please install it first."
fi

# Check if correct number of arguments is provided
if [ "$#" -lt 2 ] || [ "$#" -gt 3 ]; then
  usage
fi

# Variables from arguments
CONTRACT_PATH=$1
CONTRACT_NAME=$2
VERBOSE=false

# Check if verbose option is enabled
if [ "$#" -eq 3 ] && [ "$3" == "-v" ]; then
  VERBOSE=true
fi

# Validate contract path
if [ ! -f "$CONTRACT_PATH" ]; then
  exit_on_error "Contract path '$CONTRACT_PATH' does not exist or is not a file."
fi

# Get the directory of the contract path
CONTRACT_DIR=$(dirname "$CONTRACT_PATH")
# shellcheck disable=SC2034
CONTRACT_FILE=$(basename "$CONTRACT_PATH")

# Change to the contract directory
cd "$CONTRACT_DIR" || exit_on_error "Failed to change directory to '$CONTRACT_DIR'."

# Step 1: Compile the contract
echo "Compiling the contract..."
if $VERBOSE; then
  forge build --contracts . || exit_on_error "Failed to compile the contract."
else
  forge build --contracts . > /dev/null 2>&1 || exit_on_error "Failed to compile the contract."
fi

# Step 2: Generate the init code
echo "Generating init code..."
INIT_CODE=$(forge inspect "$CONTRACT_NAME" bytecode) || exit_on_error "Failed to generate init code."

# Step 3: Calculate the init code hash
echo "Calculating init code hash..."
INIT_CODE_HASH=$(echo -n "$INIT_CODE" | keccak-256sum | cut -d' ' -f1) || exit_on_error "Failed to calculate init code hash."

# Step 4: Write the init code hash to a file
OUTPUT_FILE="${CONTRACT_NAME}_INIT_CODE_HASH.txt"
echo "$INIT_CODE_HASH" > "$OUTPUT_FILE" || exit_on_error "Failed to write init code hash to file."

# Clean up temporary files (if any)
# (Add commands here if there are any temporary files to clean up)

# Step 5: Output the result
echo "Init code hash has been written to $OUTPUT_FILE"
if $VERBOSE; then
  echo "Init code: $INIT_CODE"
  echo "Init code hash: $INIT_CODE_HASH"
fi

# Revert to original directory
cd - > /dev/null || exit
