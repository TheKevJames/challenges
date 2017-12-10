#!/usr/bin/env bash
set -euo pipefail

for file in $(ls *.clj); do
    echo -n "Problem ${file/.clj/}: "

    # realtime, but only once
    # sudo -E chrt -f 99 /usr/bin/time --verbose clojure ${file} |& awk '/User time/ {print $4}'

    # may context-switch, but averages over 10
    perf stat -r 10 -d clojure ${file} |& awk '/time elapsed/ {print $1}'
done
