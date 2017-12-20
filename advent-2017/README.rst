Advent of Code 2017
===================

These are my solutions to 2017's `Advent of Code`_, written in `Julia`_ because
why not?

.. _Advent of Code: http://adventofcode.com/2017
.. _Julia: https://julialang.org/

Latest Timing Results
---------------------

Because who doesn't like evaluating performance?

.. code-block:: bash

    $ ./time.sh
    Day 01.jl: 0.253681732
    Day 02.jl: 0.627934821
    Day 03.jl: 0.352555428
    Day 04.jl: 0.650050471
    Day 05.jl: 0.750067894
    Day 06.jl: 0.353012848
    Day 07.jl: 1.087765335
    Day 08.jl: 0.642986610
    Day 09.jl: 0.235483569
    Day 10.jl: 0.461104322
    Day 11.jl: 2.812469651
    Day 12.jl: 0.627527634
    Day 13.jl: 3.139892804
    Day 14.jl: 0.977556744
    Day 15.jl: 2.134842267
    Day 16.jl: 0.894263732
    Day 17.jl: 0.846308864
    Day 18.jl: 1.210520098
    Day 19.jl: 0.452564024
    Day 20.jl: 1.419754894

Hmm, I haven't been trying overly hard for speed here, but it's nice to see that
the tagline which attracted me to try Julia ("its like Python, but fast!") is
decently accurate.

EDIT: I may have spoke too soon. Clearly I did day 15 wrong.

EDIT OF EDIT: I did indeed do day 15 wrong. Who knew implementing a Generator
instead of using a Channel would be a 60x improvement?
