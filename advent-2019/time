#!/usr/bin/env bash
set -euo pipefail

for file in $(ls *.erl); do
    erlc "${file}" >/dev/null

    hyperfine -sbasic "erl -noshell -s '${file%.erl}' main -s init stop"
done
