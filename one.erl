-module(one).

-export([p_01/0]).
-export([p_01/1]).
%%%%%%%%%%%%%%%%%%%%%%
-export([p_02/0]).
-export([p_02/1]).
%%%%%%%%%%%%%%%%%%%%%%
-export([p_03/0]).
-export([p_03/2]).
%%%%%%%%%%%%%%%%%%%%%%
-export([p_04/0]).
-export([p_04/1]).
%%%%%%%%%%%%%%%%%%%%%%
-export([p_05/0]).
-export([p_05/1]).
%%%%%%%%%%%%%%%%%%%%%%
-export([p_06/0]).
-export([p_06/1]).
%%%%%%%%%%%%%%%%%%%%%%
-export([p_07/0]).
-export([p_07/1]).
%%%%%%%%%%%%%%%%%%%%%%
-export([p_08/0]).
-export([p_08/1]).
%%%%%%%%%%%%%%%%%%%%%%
-export([bump/0]).
-export([bump/1]).
%%%%%%%%%%%%%%%%%%%%%%
-export([average/0]).
-export([average/1]).
%%%%%%%%%%%%%%%%%%%%%%
-export([even/0]).
-export([even/1]).
%%%%%%%%%%%%%%%%%%%%%%
-export([member/0]).
-export([member/2]).
%%%%%%%%%%%%%%%%%%%%%%
-export([p_09/0]).
-export([p_09/1]).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [a,b,s,d] -> d   p_01  *

p_01() -> p_01([a,b,s,d]).
p_01([X]) ->
    % io:format("~p => X~p~n", [?LINE, X]),
    X;
p_01([_H | T]) ->
    % io:format("~p => _H~p, T~p~n", [?LINE, _H, T]),
    p_01(T).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [a,b,c,d,e,f,g] -> [f,g]   p_02  *

p_02() -> p_02([a,b,c,d,e,f,g]).
p_02([X, Y]) ->
    % io:format("~p => X~p, Y~p~n", [?LINE, X, Y]),
    [X, Y];
p_02([_H | T]) ->
    % io:format("~p => _H~p, T~p~n", [?LINE, _H, T]),
    p_02(T).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ([a,b,c,d,e,f,g],4) -> d   p_03  *

p_03() -> p_03([a,b,c,d,e,f,g],4).
p_03(List, X) ->
    % io:format("~p => List~p, X~p~n", [?LINE, List, X]),
    p_03(List, X, 1).
p_03([H | _T], X, X) ->
    % io:format("~p => H~p, T~p, X~p, X~p~n", [?LINE, H, _T, X, X]),
    H;
p_03([_H | T], X, Acc) ->
    % io:format("~p => _H~p, T~p, X~p, Acc~p~n", [?LINE, _H, T, X, Acc]),
    p_03(T, X, Acc + 1);
p_03([], _, _) -> error.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [1,2,3,4,a,5,6,b,7] -> 9   p_04  *

p_04() -> p_04([1,2,3,4,a,5,6,b,7]).
p_04(List) ->
    % io:format("~p => List~p~n", [?LINE, list]),
    p_04(List, 0).
p_04([_H | T], Acc) ->
    % io:format("~p => _H~p, T~p, Acc~p~n", [?LINE, _H, T, Acc]),
    p_04(T, Acc + 1);
p_04([], Acc) ->
    % io:format("~p => Acc~p~n", [?LINE, Acc]),
    Acc.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [1,2,3,4,5,6,7] -> [7,6,5,4,3,2,1]   p_05  *

p_05() -> p_05([1,2,3,4,5,6,7]).
p_05(List) ->
    % io:format("~p => List~p~n", [?LINE, List]),
    p_05(List, []).
p_05([H | T], Acc) ->
    % io:format("~p => H~p, T~p, List~p~n", [?LINE, H, T, Acc]),
    p_05(T, [H | Acc]);
p_05([], Acc) ->
    % io:format("~p => Acc~p~n", [?LINE, Acc]),
    Acc.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% "madam" -> true   p_06  *

p_06() -> p_06("madam").
p_06(List) ->
    % io:format("~p => List~p~n", [?LINE, List]),
    p_05(List) == List.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [a,[b,[c,d],e]] -> [a,b,c,d,e]   p_07  **

p_07() -> p_07([a,[b,[c,d],e]]).
p_07(List) ->
    % io:format("~p => List~p~n", [?LINE, List]),
    p_05(p_07(List, [])).
p_07([[_H | _T] = H | T], Acc) ->
    % io:format("~p => _H~p, _T~p, Acc~p~n", [?LINE, _H, _T, Acc]),
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
    % io:format("~p => List~p~n", [?LINE, List]),
    p_08(List, []).
p_08([H, H | T], Acc) ->
    % io:format("~p => H~p, H~p, T~p, Acc~p~n", [?LINE, H, H, T, Acc]),
    p_08(T, [H | Acc]);
p_08([H | T], Acc) ->
    % io:format("~p => H~p, T~p, Acc~p~n", [?LINE, H, T, Acc]),
    p_08(T, [H | Acc]);
p_08([], Acc) ->
    % io:format("~p => Acc~p~n", [?LINE, Acc]),
    p_05(Acc).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [1,2,3] -> [2,3,4]

bump() -> bump([1,2,3]).
bump([]) -> [];
bump([H | T]) ->
    % io:format("~p => H~p, T~p~n", [?LINE, H, T]),
    [H +1 | bump(T)].
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [1,2,3] -> 2

average() -> average([1,2,3]).
average(List) ->
    % io:format("~p => List~p~n", [?LINE, List]),
    sum(List) / len(List).
    % io:format("~p => sum(List)~p / len(List)~p~n", [?LINE, sum(List) / len(List)]),
sum([]) -> 0;
sum([H | T]) ->
    io:format("~p => H~p, T~p~n", [?LINE, H, T]),
    Result = H + sum(T),
    io:format("~p => H~p, T~p~n", [?LINE, H, T]),
    Result.
len([]) -> 0;
len([_H | T]) ->
    io:format("~p => _H~p, T~p~n", [?LINE, _H, T]),
    Result = 1 + len(T),
    io:format("~p => _H~p, T~p~n", [?LINE, _H, T]),
    Result.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [10,11,12] -> [10,12]

even() -> even([10,11,12]).
even([]) -> [];
even([H | T]) when ((H rem 2) == 0) ->
    % io:format("~w => H~w, T~w~n", [?LINE, H, T]),
    [H | even(T)];
even([_H | T]) ->
    % io:format("~w => _H~w, T~w~n", [?LINE, _H, T]),
    even(T).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (friday, [monday, tuesday, wednesday, thursday, friday]) -> true

member() -> member(friday, [monday, tuesday, wednesday, thursday, friday]).
member(_H, []) ->
    % io:format("~p => _H~p~n", [?LINE], _H),
    false;
member(H, [H | _T]) ->
    % io:format("~p => H~p, H~p, _T~p~n", [?LINE, H, H, _T]),
    true;
member(H, [_H | T]) ->
    % io:format("~p => H~p, _H~p, T~p~n", [?LINE, H, _H, T]),
    member(H, T).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% average(List) -> average_acc(List, 0, 0).
% average_acc([], Sum, Length) ->
%     Sum/Length;
% average_acc([H | T], Sum, Length) ->
%     average_acc(T, Sum + H, Length + 1).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [a,a,a,a,b,c,c,a,a,d,e,e,e,e] -> [[a,a,a,a],[b],[c,c],[a,a],[d],[e,e,e,e]]   p_09  **

p_09() -> p_09([a,a,a,a,b,c,c,a,a,d,e,e,e,e]).
p_09(List) -> p_09(List, []).
p_09([H, H | T], Acc) -> p_09([H | T], Acc + 1);
p_09([H | T], Acc) -> p_09(T, [H | Acc]);
p_09([], Acc) -> p_05(Acc).