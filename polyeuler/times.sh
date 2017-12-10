#!/usr/bin/env bash
set -euo pipefail

for folder in $(ls -d */); do
    echo "> ${folder::-1}"
    cd $folder; ./time.sh; cd ..
done
