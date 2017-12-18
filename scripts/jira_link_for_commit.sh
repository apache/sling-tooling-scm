#!/bin/sh -e

if [ $# -eq 0 ]; then
    commit=HEAD
else
    commit=$1
fi
hash=$(git rev-parse --short ${commit})
base=$(git remote get-url origin)
url=${base%.git}/commit/${hash}

echo "[commit ${hash}|${url}]"
