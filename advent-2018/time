#!/usr/bin/env bash
set -euo pipefail

for file in $(ls *.nim); do
    echo -n "Day ${file}: "

    nim c -d:release "${file}" 2>/dev/null

    # realtime, but only once
    # sudo -E chrt -f 99 /usr/bin/time --verbose "./${file%.nim}" |& awk '/User time/ {print $4}'

    # may context-switch, but averages over 10
    perf stat -r 10 -d "./${file%.nim}" |& awk '/time elapsed/ {print $1}'
done
