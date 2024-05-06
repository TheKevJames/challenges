#!/usr/bin/env bash
set -euo pipefail

for file in $(ls *.clj); do
    echo -n "Day ${file}: "

    sudo -E chrt -f 99 /usr/bin/time --verbose clojure ${file} 10 |& awk '/User time/ {print $4 / 10}'
done
