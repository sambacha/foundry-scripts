#!/usr/bin/env bash

CONTRACT_DIR=source/contracts

set -e
mkdir -p $CONTRACT_DIR && cd $CONTRACT_DIR

function cloneCheckoutCommit() {
  cloneDirName=${1##*/}
  if [ -d "$cloneDirName" ]; then
    (cd "$cloneDirName" && [ -z "$(git status --porcelain)" ] && git checkout "$2") || (echo Unclean "$cloneDirName" && exit 1)
    return
  fi
  git clone https://github.com/"$1" && (cd "$cloneDirName" && git checkout "$2")
}
