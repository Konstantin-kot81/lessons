-module(example).




-export([p_01/0]).
-export([p_01/1]).

-export([p_02/0]).
-export([p_02/1]).

-export([p_03/0]).
-export([p_03/2]).

-export([p_04/0]).
-export([p_04/1]).

-export([p_05/0]).
-export([p_05/1]).

-export([p_06/0]).
-export([p_06/1]).

-export([p_07/0]).
-export([p_07/1]).

-export([p_08/0]).
-export([p_08/1]).

-export([p_09/0]).
-export([p_09/1]).

-export([p_10/0]).
-export([p_10/1]).

-export([p_11/0]).
-export([p_11/1]).


-export([p_14/0]).
-export([p_14/1]).

% -export([date/0]).

% -export([area/2]).

-export([sample_tupl/1]).
-export([is_polindrom/1]).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [a,b,s,d] -> d   p_01  *

p_01() -> p_01([a,b,s,d]).
p_01([X]) -> 
    io:format("~p => X~p~n", [?LINE, X]),
    X;
p_01([H | T]) -> 
    io:format("~p => H~p, T~p~n", [?LINE, H, T]),    
    p_01(T).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [a,b,c,d,e,f,g] -> [f,g]   p_02  *

p_02() -> p_02([a,b,c,d,e,f,g]).
p_02([X, Y]) -> 
   io:format("~p => X~n, Y~p~n", [?LINE, [X, Y]]),    
    [X, Y];
p_02([_H | T]) -> 
   io:format("~p => _H~p, T~p~n", [?LINE, _H, T]),    
    p_02(T).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ([a,b,c,d,e,f,g],4) -> d   p_03  *

p_03() -> p_03([a,b,c,d,e,f,g],4).
p_03(List, X) -> 
    io:format("~p => List~p, X~p~n", [?LINE, List, X]),
    p_03(List, X, 1).
p_03([H | _T], X, X) ->
    io:format("~p => H~p, _T~p, X~p, X~p~n", [?LINE, H, _T, X, X]),
    H;
p_03([_H | T], X, Acc) ->
    %io:format("~p => _H~p, T~p, X~p, Acc~p~n", [?LINE _H, T, X, Acc]),
     p_03(T, X, Acc + 1);
p_03([], _, _) -> error.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [1,2,3,4,a,5,6,b,7] -> 9   p_04  *

p_04() -> p_04([1,2,3,4,a,5,6,b,7]).
p_04(List) -> 
    io:format("~p => List ~p~n", [?LINE, List]),    
    p_04(List, 0).
p_04([_H | T], Acc) -> 
    io:format("~p => _H~p, T~p, Acc~p~n", [?LINE, _H, T, Acc]),    
    p_04(T, Acc + 1);
p_04([], Acc) -> 
    io:format("~p => Acc ~p~n,", [?LINE, Acc]),    
    Acc.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [1,2,3,4,5,6,7] -> [7,6,5,4,3,2,1]   p_05  *

p_05() -> p_05([1,2,3,4,5,6,7]).
p_05(List) -> 
    io:format("~p => List ~p~n", [?LINE, List]),
    p_05(List, []).
p_05([H | T], Acc) -> 
    io:format("~p => H~p, T~p, Acc ~p~n", [?LINE, H, T, Acc]),
    p_05(T, [H | Acc]);
p_05([], Acc) -> 
    io:format("~p => Acc ~p~n", [?LINE, Acc]),    
    Acc.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% "madam" -> true   p_06  *

p_06() ->p_06("madam").
p_06(List) -> 
    io:format("~p => List ~p~n", [?LINE, List]),
p_05(List) == List.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [a,[b,[c,d],e]] -> [a,b,c,d,e]   p_07  **

p_07() -> p_07([a,[b,[c,d],e]]).
p_07(List) -> 
    % io:format("~p => list ~p~n", [?LINE, List]),
    p_05(p_07(List, [])).
p_07([[_H | _T] = H | T], Acc) -> 
    % io:format("~p => H~p, T~p, Acc~p~n", [?LINE, H, T, Acc]),
    NewAcc = p_07(H, Acc),
    p_07(T, NewAcc);
p_07([], Acc) ->
    % io:format("~p => Acc~p~n", [?LINE, Acc]),
    Acc;
p_07([H | T], Acc) -> 
    % io:format("~p => H~p, T~p, Acc~p~n", [?LINE, H, T, Acc]),
    p_07(T, [H | Acc]).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [a,a,a,a,b,c,c,a,a,d,e,e,e,e] -> [a,b,c,a,d,e]   p_08  **

p_08() -> p_08([a,a,a,a,b,c,c,a,a,d,e,e,e,e]).
p_08(List) -> 
    io:format("~p => List~p~n", [?LINE, List]),    
p_08(List, []).
p_08([H, H | T], Acc) -> 
    io:format("~p => H~p,  H~p, T~p~n", [?LINE, H, H, T]),
    p_08(T, [H | Acc]);
p_08([H | T], Acc) -> 
    io:format("~p => H~p, T~p~n", [?LINE, H, T]),    
    p_08(T, [H | Acc]);
p_08([], Acc) -> 
    io:format("~p => Acc~p~n",[?LINE, Acc]),    
p_05(Acc). 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [a,a,a,a,b,c,c,a,a,d,e,e,e,e] -> [[a,a,a,a],[b],[c,c],[a,a],[d],[e,e,e,e]]   p_09  **

p_09() -> p_09([a,a,a,a,b,c,c,a,a,d,e,e,e,e]).
p_09(List) -> 
    io:format("~p => List~p~n", [?LINE, List]),    
p_09(List, []).
p_09([H, H | T], Acc) -> 
    io:format("~p => H~p, H~p, T~p, Acc~p~n", [?LINE, H, H, T, Acc]),    
p_09([H | T], Acc + 1);
p_09([H | T], Acc) -> 
    io:format("~p => H~p, T~p, Acc~p~n", [?LINE, H, T, Acc]),    
p_09(T, [H | Acc]);
p_09([], Acc) -> 
    io:format("~p => []~p, Acc~p~n", [?LINE, [], Acc]),    
p_05(Acc). 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [a,a,a,a,b,c,c,a,a,d,e,e,e,e] -> [[4,a],[1,b],[2,c],[2,a],[1,d],[4,e]]   p_10  *

p_10() ->
    p_10([a,a,a,a,b,c,c,a,a,d,e,e,e,e]).

p_10(List) -> 
    io:format("~p => List~p~n", [?LINE, List]),    
    p_10(List, 1, []).
p_10([H, H | T], D, Acc) -> 
    io:format("~p => H~p, H~p, T~p, D~p, Acc~p~n", [?LINE, H, H, T, D, Acc]),    
    p_10([H | T], D + 1, Acc);
p_10([H | T], D, Acc) -> 
    io:format("~p => H~p, T~p, D~p, Acc~p~n", [?LINE, H, T, D, Acc]),    
    p_10(T, 1, [[D, H] | Acc]);
p_10([], _H, Acc) -> 
    io:format("~p => _H~p, Acc~p~n", [?LINE, _H, Acc]),    
    p_05(Acc).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [a,a,a,a,b,c,c,a,a,d,e,e,e,e] -> [[4,a],b,[2,c],[2,a],d,[4,e]]   p_11  *

p_11() -> p_11([a,a,a,a,b,c,c,a,a,d,e,e,e,e]).
p_11(List) ->
    io:format("~p => List~p~n", [?LINE, List]), 
    p_11(List, 1, []).
p_11([H, H | T], F, Acc) ->
    % io:format("~p => H~p, H~p, T~p, F~p, Acc~p~n", [?LINE], H, H, T, F, Acc),
    p_11([H | T], F + 1, Acc);
p_11([H | T], F, Acc) ->
    io:format("~p => H~p, T~p, F~p, Acc~p~n", [?LINE, H, T, F, Acc]),
    p_11(T, 1, [[F, H] | Acc]);
p_11([], _H, Acc) ->
    io:format("~p => _H~p, Acc~p~n", [?LINE, _H, Acc]),
    p_05(Acc).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% p_12 **

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% area({square,Side}) -> Side * Side;
% area({circule, Radius}) -> math:pi() * Radius * Radius;
% area({triangle, A, B, C}) -> S = (A + B + C) / 2,
% math:sqrt(S * (S - A) * (S - B) * (S - C));
% area(Other) -> {error, invalid_object}.





% listlen([]) -> 0;
% listlen([_ | Xs]) -> 1 + listlen(Xs).


% date() -> (date).


sample_tupl(X) ->
    case (X) of
        {1, true} -> false;
        {2, false} -> true;
        {_, _} -> wow
end.


is_polindrom(List) when ((tl(List) == []) or (List == [])) -> true;
is_polindrom([_H | T]) ->
    Last = list:last(T),
    if _H == Last -> is_polindrom(list:sublist(T, length(T)- 1));
    true -> false
end. 

% bump([]) -> [];
% bump([Head | Tail]) -> [Head + 1 | bump(Tail)].


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [a,b,c,c,d] -> [a,a,b,b,c,c,c,cd,e,e,e,e]       p_14 *
p_14() -> p_14([a,b,c,c,d]).
p_14(List) ->
    io:format("~p => List ~p~n", [?LINE, List]),
    p_05(p_14(List, [])).
p_14([H | T], Acc) ->
    % io:formatr("~p => H~p, T~p, Acc~p~n", [?LINE, H, T, Acc]),
    p_14(T, [H, H | Acc]);
p_14([], Acc) ->
    io:format("~p => Acc~p~n",[?LINE, Acc]), 
    Acc.




