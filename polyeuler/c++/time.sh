#!/usr/bin/env bash
set -euo pipefail

for file in $(ls *.cpp); do
    echo -n "Problem ${file/.cpp/}: "

    clang++ -O3 ${file} -o compiled.exe

    # realtime, but only once
    # sudo -E chrt -f 99 /usr/bin/time --verbose ./compiled.exe |& awk '/User time/ {print $4}'

    # may context-switch, but averages over 10
    perf stat -r 10 -d ./compiled.exe |& awk '/time elapsed/ {print $1}'

    rm compiled.exe
done
