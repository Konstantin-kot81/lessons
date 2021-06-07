-module(revers).

-export([revers/0]).
-export([revers/1]).

revers() ->
    revers([1,2,3,4,5,6,7]).

revers(List) ->
    revers(List, []).
revers([List | Rest], Acc) ->
    revers(Rest, [List | Acc]);
revers([], Acc) ->
    Acc.