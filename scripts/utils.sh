#!/bin/bash

####################################################################################################################################
# SPDX-License-Identifier: ISC
# Bash Utilities
####################################################################################################################################

# exit_with_error - Prints passed message with [Error] prefix and exits with error code 1
# exit_on_error - If current status is non-0, prints passed message with [Error] prefix and exits with error code 1

# check_for_required_variables - Validates whether passed array each element is defined as variable

# Global variable ${logging_lvl} is used for logging level. Currently supported: debug, info, error(default)

# log_debug - If global variable ${logging_lvl} set up to debug, log passed message with [Debug] prefix
# log_info - If global variable ${logging_lvl} set at least to info, log passed message with [Info] prefix
# log_debug - If global variable ${logging_lvl} set at least to error(default), log passed message with [Error] prefix
# log_set_logging_lvl - If not defined, set ${logging_lvl}=error
# logging_lvl_validate - Validate if set loging level is suported.


### Error Handling

exit_with_error() {
  echo
  echo "[Error] $@"
  exit 1
}

exit_on_error() {
  if [ $? -ne 0 ]; then
    echo
    echo "[Error] $@"
    exit 1
  fi
}

random() { cat /dev/urandom | env LC_CTYPE=C tr -dc $1 | head -c $2; echo; }

randompw() {
  # Generate a random password (16 characters) that starts with an alpha character
  echo `random [:alpha:] 1``random [:alnum:] 15`
}

### Logging

log_debug () {
  if [ "${logging_lvl}" == "debug" ]; then echo "[Debug] $@"; fi
}

log_info () {
  if [[ "${logging_lvl}" =~ (debug|info) ]]; then echo "[Info] $@"; fi
}

log_error () {
  if [[ "${logging_lvl}" =~ (debug|info|error) ]]; then echo && echo "[Error] $@"; fi
}

log_set_logging_lvl () {
  if [ -z ${logging_lvl} ]; then
    logging_lvl="error"
    echo "[Info] Logging level not set, defaulting to 'error'."
  fi
}

logging_lvl_validate () {
  if [[ "${logging_lvl}" =~ (debug|info|error) ]]; then
    log_debug " [Validation Passed] logging_lvl = '${logging_lvl}'"
  else
    exit_with_error " [Validation Failed] Unsupported logging level '${logging_lvl}'. Supported loggin levels are 'debug|info|error'."
  fi  
}

# Function wrapper for friendly logging and basic timing
run() {
  SECONDS=0
  echo "[Running '$@']"
  $@
  echo "['$@' finished in $SECONDS seconds]"
  echo ""
}