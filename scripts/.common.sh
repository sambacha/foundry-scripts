#!/bin/bash

# get full path to current script/file
# http://stackoverflow.com/questions/4774054/reliable-way-for-a-bash-script-to-get-the-full-path-to-itself#comment15185627_4774063
SCRIPT_PATH=$( cd $(dirname $0) ; pwd -P )
SCRIPT_NAME=`basename ${BASH_SOURCE[0]}`

# stop execution if anything fails and exit with non-zero status
set -o errexit # -e
trap "{ echo -e \"\nError: Something went wrong in $SCRIPT_NAME. ($*)\">&2; exit 1; }" ERR

# allow DEBUG env variable to trigger simple bash debugging when it is set to 
# anything but 'false'
if [ ${DEBUG:=false} != 'false' ] ; then
  # useful for debugging how exactly this script is called.
  echo "$*"
  echo ""
  set -o verbose # -v
  set -o xtrace  # -x
fi
