#!/bin/bash
# removes top line from output
forge $cmd | tail -n +2 | tee $outputFile
