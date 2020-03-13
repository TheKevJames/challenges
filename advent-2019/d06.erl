-module(d06).
-export([main/0]).

readlines(File) ->
    {ok, Data} = file:read_file(File),
    Bins = binary:split(Data, [<<"\n">>], [global, trim_all]),
    [binary:split(L, [<<")">>]) || L <- Bins].

tree(L) -> lists:foldl(fun([X,Y], Acc) -> dict:store(Y, X, Acc) end, dict:new(), L).
parents(K, T) -> case dict:find(K, T) of {ok, V} -> lists:append([V], parents(V, T)); _Else -> [] end.
count_parents(T) -> lists:sum([length(parents(K, T)) || K <- dict:fetch_keys(T)]).

index_of(X, L) -> index_of(X, L, 1).
index_of(E, [E|_], I) -> I;
index_of(E, [_|T], I) -> index_of(E, T, I+1);
index_of(_, [], _) -> not_found.

part1(L) -> count_parents(tree(L)).

part2(L) ->
    T = tree(L),
    OrbitsYou = parents(<<"YOU">>, T),
    OrbitsSan = parents(<<"SAN">>, T),
    Common = lists:dropwhile(fun(P) -> not lists:member(P, OrbitsSan) end, OrbitsYou),
    Target = lists:nth(1, Common),
    index_of(Target, OrbitsYou) + index_of(Target, OrbitsSan) - 2.

main() ->
    L = readlines("in06"),
    io:fwrite("~w\n~w\n", [part1(L), part2(L)]).
