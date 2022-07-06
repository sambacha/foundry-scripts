#!/usr/bin/env bash
set -o errexit


for branch in $fetch; do
  git fetch origin $branch
  git branch $branch FETCH_HEAD
done

if [ "$ref" == "HEAD" ]; then
  return_ref=$(git rev-parse HEAD)
else
  return_ref=$ref
fi


git --version

echo "[CONFIG]: Updating and init submodules"
git config --global diff.submodule log
git config --global status.submoduleSummary true
git config --global fetch.recurseSubmodules true
sleep 1

# 
# Git Submodules syncing
#
#   Alternative oneliner
#
# ```shell
# git submodule status | awk '{print $2}' | xargs -P5 -n1 git submodule update --init $depthflag --recursive
#```
#

echo "[TASK]: Syncing submodules"
git submodule sync --recursive && git submodule update --init --recursive --jobs=8
git submodule foreach --recursive git clean -ffdx
sleep 1



git submodule foreach git reset --hard HEAD --jobs=8
git submodule update --remote --rebase lib/ --jobs=8
git status
exit 0
