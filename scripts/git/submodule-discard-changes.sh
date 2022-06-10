#!/usr/bin/env bash
echo "[TASK]: Discarding local changes made in all submodules..."
git status
git gc
git restore . --recurse-submodules
git push --recurse-submodules=on-demand
