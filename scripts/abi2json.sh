#!/bin/bash
echo "Converting ABI to JSON-ABI..."
for f in *.abi; do mv "$f" "${f%.*}".json; done | exit 127
sleep 1
exit 0
