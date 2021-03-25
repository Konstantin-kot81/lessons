-module(les).


-export([sum/2]).
-export([sum/1]).
-export([last_1/1]).
-export([last_2/1]).
-export([len/1]).
-export([len_2/1]).




% [1, 2, 3, 4, 5] -> 5
last_1([X]) -> X;
last_1([_ | T]) ->  last_1(T).


% [1, 2, 3, 4, 5] -> [4, 5] 
last_2([X, Y]) -> [Y, X];
last_2([_ | T]) -> last_2(T).



sum(X, Y) -> X + Y.

sum(X) -> X + X.


% [1, 2, 3, 4, a] -> 5
len([]) -> 0;
len([_| T]) -> 1 + len(T).


% [1, 2, 3, 4, a] -> 5
len_2(List) -> len_2(List, 0).
len_2([_ | T], Acc) -> len_2(T, Acc + 1);
len_2([], Acc) -> Acc.