-module(d03).
-export([main/0]).

readlines(File) ->
    {ok, Data} = file:read_file(File),
    Bins = binary:split(Data, [<<"\n">>], [global, trim_all]),
    [parseAll(L) || L <- Bins].

parse(B) ->
    <<Dir:1/binary, Val/binary>> = B,
    {binary_to_atom(Dir, utf8), binary_to_integer(Val)}.

parseAll(Data) ->
    Bin = binary:split(Data, [<<",">>], [global, trim_all]),
    [parse(X) || X <- Bin].

travel([], M, {X,Y}) -> M;
travel([H|T], M, {X,Y}) ->
    case element(1, H) of
        'R' ->
            Indexes = sets:from_list([{X+I,Y} || I <- lists:seq(1, element(2, H))]),
            travel(T, sets:union(M, Indexes), {X+element(2, H), Y});
        'L' ->
            Indexes = sets:from_list([{X-I,Y} || I <- lists:seq(1, element(2, H))]),
            travel(T, sets:union(M, Indexes), {X-element(2, H), Y});
        'U' ->
            Indexes = sets:from_list([{X,Y+I} || I <- lists:seq(1, element(2, H))]),
            travel(T, sets:union(M, Indexes), {X, Y+element(2, H)});
        'D' ->
            Indexes = sets:from_list([{X,Y-I} || I <- lists:seq(1, element(2, H))]),
            travel(T, sets:union(M, Indexes), {X, Y-element(2, H)})
    end.

part1(L) ->
    [L0, L1] = [travel(X, sets:new(), {0,0}) || X <- L],
    Inters = sets:intersection(L0, L1),
    Sorted = lists:usort([abs(X) + abs(Y) || {X,Y} <- sets:to_list(Inters)]),
    lists:nth(1, Sorted).

part2(_L) -> 0.

main() ->
    L = readlines("in03"),
    io:fwrite("~w\n~w\n", [part1(L), part2(L)]).
