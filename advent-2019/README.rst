Advent of Code 2019
===================

These are my solutions to 2019's `Advent of Code`_, written in `Erlang`_.

Dev
---

::

    # compile loop
    while sleep 1; do
        fd .erl \
            | entr -d bash -x -c 'erlc -Wall $0' /_;
    done

    # run loop
    while sleep 1; do
        fd -u .beam \
            | entr -d -c bash -x -c 'erl -noshell -s $(basename -a -s .beam "$0") main -s init stop' /_;
    done

.. _Advent of Code: http://adventofcode.com/2019
.. _Erlang: https://www.erlang.org/
