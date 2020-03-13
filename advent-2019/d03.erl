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

travel([], M, _S, {_X,_Y}) -> M;
travel([H|T], M, S, {X,Y}) ->
    Dist = element(2, H),
    case element(1, H) of
        'R' ->
            Indexes = dict:from_list([{{X+I,Y}, S+I} || I <- lists:seq(1, Dist)]),
            travel(T, dict:merge(fun(_, V1, V2) -> min(V1, V2) end, M, Indexes), S + Dist, {X+Dist, Y});
        'L' ->
            Indexes = dict:from_list([{{X-I,Y}, S+I} || I <- lists:seq(1, Dist)]),
            travel(T, dict:merge(fun(_, V1, V2) -> min(V1, V2) end, M, Indexes), S + Dist, {X-Dist, Y});
        'U' ->
            Indexes = dict:from_list([{{X,Y+I}, S+I} || I <- lists:seq(1, Dist)]),
            travel(T, dict:merge(fun(_, V1, V2) -> min(V1, V2) end, M, Indexes), S + Dist, {X, Y+Dist});
        'D' ->
            Indexes = dict:from_list([{{X,Y-I}, S+I} || I <- lists:seq(1, Dist)]),
            travel(T, dict:merge(fun(_, V1, V2) -> min(V1, V2) end, M, Indexes), S + Dist, {X, Y-Dist})
    end.

part1(L) ->
    [L0, L1] = [travel(X, dict:new(), 0, {0,0}) || X <- L],
    Inters = sets:intersection(sets:from_list(dict:fetch_keys(L0)), sets:from_list(dict:fetch_keys(L1))),
    Sorted = lists:usort([abs(X) + abs(Y) || {X,Y} <- sets:to_list(Inters)]),
    lists:nth(1, Sorted).

part2(L) ->
    [L0, L1] = [travel(X, dict:new(), 0, {0,0}) || X <- L],
    Inters = sets:intersection(sets:from_list(dict:fetch_keys(L0)), sets:from_list(dict:fetch_keys(L1))),
    Sorted = lists:usort([dict:fetch({X,Y}, L0) + dict:fetch({X,Y}, L1) || {X,Y} <- sets:to_list(Inters)]),
    lists:nth(1, Sorted).

main() ->
    L = readlines("in03"),
    io:fwrite("~w\n~w\n", [part1(L), part2(L)]).
