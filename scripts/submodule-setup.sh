#!/usr/env/bin bash
set -ex

echo "Setting up Git Submodules..."
sed -i 's|git@github.com:|https://github.com/|' .gitmodules
echo "Submodule syncing..."
git submodule init
git submodule sync --quiet

exit 0
