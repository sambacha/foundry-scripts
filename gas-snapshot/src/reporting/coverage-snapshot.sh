#!/usr/bin/env bash
patdiff -version || exit 127
forge snapshot --allow-failures >02_gas_report
patdiff .gas-snapshot 02_gas_report -html >gas_report.html
rm 02_gas_report
echo "Gas Report generated"
