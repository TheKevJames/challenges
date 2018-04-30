#!/usr/bin/env bash
set -euo pipefail

for file in $(ls *.py); do
    echo -n "Problem ${file/.py/}: "

    # realtime, but only once
    # sudo -E chrt -f 99 /usr/bin/time --verbose "cat ${file/.py/.in} | ./${file}" |& awk '/User time/ {print $4}'

    # may context-switch, but averages over 10
    # perf stat -r 10 -d "cat ${file/.py/.in} | ./${file}" |& awk '/time elapsed/ {print $1}'

    # TODO: figure out how to use `perf` on OSX
    python3 -m timeit -n100 -r3 -s "x = open('${file/.py/.in}').readlines(); from ${file/.py/} import main" 'main(*x)' |& awk '{$1=$2=$3=$4=$5=""; sub(/^[ \t]+/, ""); print $0}'
done
