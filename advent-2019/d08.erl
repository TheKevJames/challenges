-module(d08).
-export([main/0]).

readlines(File) ->
    {ok, Data} = file:read_file(File),
    Bin = binary:split(Data, [<<"\n">>], [global, trim]),
    Layers = layers(lists:nth(1, Bin)),
    [binary_to_list(L) || L <- Layers].

layers(<<>>) -> [];
layers(<<H:150/binary, T/binary>>) -> [H|layers(T)];
layers(<<B/binary>>) -> [B].

value(L) ->
    {Ones, Twos} = lists:partition(fun(X) -> X == 49 end, L),
    length(Ones) * length(Twos).

% the first non-transparent pixel is visible
overlay(P, Cover) -> case Cover of 50 -> P; X -> X end.
overlay(Ps) -> lists:foldl(fun(P, Cover) -> overlay(P, Cover) end, 50, Ps).

transpose([[]|_]) -> [];
transpose(Ls) -> [lists:map(fun hd/1, Ls) | transpose(lists:map(fun tl/1, Ls))].

display([]) -> ok;
display(Layer) ->
    {Row, Tail} = lists:split(25, Layer),
    Viz = lists:map(fun(X) -> if X == 49 -> "X"; true -> " " end end, Row),
    io:fwrite("~s~n", [Viz]),
    display(Tail).

part1(Layers) ->
    Parts = [lists:partition(fun(X) -> X == 48 end, L) || L <- Layers],
    Vals = lists:map(fun({Zeros, Data}) -> {length(Zeros), value(Data)} end, Parts),
    {_, Sum} = lists:nth(1, lists:sort(Vals)),
    Sum.
part2(Layers) ->
    Overlayed = lists:map(fun(Xs) -> overlay(Xs) end, transpose(Layers)),
    display(Overlayed).

main() ->
    L = readlines("in08"),
    io:fwrite("~w\n~w\n", [part1(L), part2(L)]).
