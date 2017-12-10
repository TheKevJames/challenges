#!/usr/bin/env bash
set -euo pipefail

for file in $(ls *.scala); do
    echo -n "Problem ${file}: "

    scalac ${file}

    # realtime, but only once
    # sudo -E chrt -f 99 /usr/bin/time --verbose scala "q${file/.scala/}" |& awk '/User time/ {print $4}'

    # may context-switch, but averages over 10
    perf stat -r 10 -d scala "q${file/.scala/}" |& awk '/time elapsed/ {print $1}'

    rm *.class
done
