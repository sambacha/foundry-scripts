#!/usr/bin/env bash
set -o errexit

git --version

echo "[CONFIG]: Updating and init submodules"
git config --global diff.submodule log
git config --global status.submoduleSummary true
git config --global fetch.recurseSubmodules true
sleep 1

echo "[TASK]: Syncing submodules"
git submodule sync --recursive && git submodule update --init --recursive
sleep 1

git submodule foreach git reset --hard HEAD
git submodule update --remote --rebase lib/
git status
exit 0
