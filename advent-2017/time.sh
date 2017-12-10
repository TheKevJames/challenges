#!/usr/bin/env bash
set -euo pipefail

for file in $(ls *.jl); do
    echo -n "Day ${file}: "

    # realtime, but only once
    # sudo -E chrt -f 99 /usr/bin/time --verbose julia ${file} |& awk '/User time/ {print $4}'

    # may context-switch, but averages over 10
    perf stat -r 10 -d julia ${file} |& awk '/time elapsed/ {print $1}'
done
