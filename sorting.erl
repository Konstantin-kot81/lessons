-module(sorting).

-export([numbers/0]).

-export([sorting/0]).
-export([sorting/1]).

numbers() ->
    [23, 6, 45, 2, 9, 27, 400, 78, 45, 61, 82, 14].

sorting() ->
    sorting(numbers()).
sorting([]) ->
    [];

sorting([Pivot | Rest]) ->
    sorting([Smaller || Smaller <- Rest, Smaller < Pivot])
    ++ [Pivot] ++
    sorting([Larger || Larger <- Rest, Larger >= Pivot]).