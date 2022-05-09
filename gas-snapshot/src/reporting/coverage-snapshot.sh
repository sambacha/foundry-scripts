#!/bin/bash
forge snapshot --allow-failures > 02_gas_report
01_gas_report=$(cat .gas-snapshot)
patdiff 01_gas_report 02_gas_report -html > gas_report.html
