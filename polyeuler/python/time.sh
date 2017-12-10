#!/usr/bin/env bash
set -euo pipefail

for file in $(ls *.py); do
    echo -n "Problem ${file}: "

    # realtime, but only once
    # sudo -E chrt -f 99 /usr/bin/time --verbose ./${file} |& awk '/User time/ {print $4}'

    # may context-switch, but averages over 10
    perf stat -r 10 -d ./${file} |& awk '/time elapsed/ {print $1}'
done
