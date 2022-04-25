#!/usr/bin/env bash
set -eu
path=
options=()
# change -c to -r to get pretty-print
set -- "$@" -c .
for arg; do
  if [ -f "$arg" ]; then
    if [ -n "$path" ]; then
      echo "Cannot specify multiple paths to jq-minify" >&2
      exit 1
    fi
    path="$arg"
  else
    options+=("$arg")
  fi
done
tmp=$(mktemp)
jq "${options[@]}" "$path" >"$tmp"
cat "$tmp" >"$path"
