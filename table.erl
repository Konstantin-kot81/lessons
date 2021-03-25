-module(table).

% -export([tab/0]).
-export([row_1/0]).
-export([row_2/0]).
-export([row_3/0]).
-export([row_4/0]).
-export([row_5/0]).
-export([tab/0]).
-export([select_star/3]).





-export([p_01/0]).
-export([p_01/1]).

-export([p_02/0]).
-export([p_02/1]).

-export([anon/0]).


% [{name, kot, lora, gleb, snegana}, {sname, bur}, {age, 40, 41, 11, 4}, {gender, m, f}, {phone, 123456789, 987654321, 543219876, no}, {email, no, yes, yes, no}, {married, yes, yes, no, no}]

% tab() -> tab([{name, kot}, {sname, bur}, {age, 40}, {gender, m}, {phone, 123456789}, {email, no}, {married, yes}]).

row_1() ->
    [
    {id, 1},
    {name, kot},
    {sname, bur},
    {age,40},
    {gender, m},
    {phone, 123456789},
    {email, "321@gmail.com"},
    {married, yes}
    ].
row_2() ->
    [
    {id, 2},
    {name, lora},
    {sname, bur},
    {age, 41},
    {gender, f},
    {phone, 987654321},
    {email, "213@gmail.com"},
    {married, yes}
    ].
row_3() ->
    [
    {id, 3},
    {name, gleb},
    {sname, bur},
    {age, 11},
    {gender, m},
    {phone, 543219876},
    {email, "123@gmail.com"},
    {married, null}
    ].
row_4() ->
    [
    {id, 4},
    {name, snegana},
    {sname, bur},
    {age, 4},
    {gender, f},
    {phone, null},
    {email, null},
    {married, null}
    ].
row_5() ->
    [
    {id, 5},
    {name, dominica},
    {smail, null},
    {age, 5},
    {gender, f},
    {phone, null},
    {email, null},
    {married, null}
    ].

tab() ->
    [row_1(), row_2(), row_3(), row_4(), row_5()].

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% select_star([H | _T], Wc, Wv) -> 
%     Pattern = (Wc, Wv),
%     case anles:p_16(H, Pattern) of
%         true -> H;
%         _    -> select-star(_T, Wc, Wv)
%     end.
% select_star([], _, _) -> error.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% select_star(List, Wc, Wv) ->
%     select_star(List, Wc, Wv, []).
% select_star([H | _T], Wc, Wv, Acc) ->
%    Pattern = {Wc, Wv},
%     case anles:p_16(H, Pattern) of
%         true -> select_star(_T, Wc, Wv, [H | Acc]);
%         _    -> select_star(_T, Wc, Wv, Acc)
%     end;
% select_star([], _, _, Acc) -> Acc.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
select_star(ListDb, ListConditions) ->
    select_start(List, Wc, Wc2, Wv)









% анонимная функция
anon() ->
fun() -> {ok, anon} end.

% tab_5([], _) -> null;
% tab_5([{Key, Value} | _], Key) -> {ok, Value};
% tab_5([_H | T], Key) -> 
%     tab_5(T, Key).

% tab_6(List, Key, Default) ->
%     case tab_6(List, Key) of
%         {ok, Value} -> Value;
%         _           -> Default
% end. 




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [a,[b,[c,d],e]] -> [a,b,c,d,e]   p_01


p_01() -> p_01([a,[b,[c,d],e]]).

p_01(List) ->
    io:format("~p => List~p~n", [?LINE, List]),
    p_02(p_01(List, [])).
p_01([[_H | _T] = H | T], Acc) ->
    io:format("~p => H~p, T~p, Acc~p~n", [?LINE, H, T, Acc]),
    NewAcc = p_01(H, Acc),
    p_01(T, NewAcc);
p_01([], Acc) ->
    io:format("~p => Acc~p~n", [?LINE, Acc]),
    Acc;
p_01([H | T], Acc) ->
    io:format("~p => H~p, T~p, Acc~p~n", [?LINE, H, T, Acc]),
    p_01(T, [H | Acc]).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

p_02() -> p_02([1,2,3,4,5,6,7]).

p_02(List) -> 
    p_02(List, []).
p_02([H | T], Acc) -> 
    p_02(T, [H | Acc]);
p_02([], Acc) -> 
    Acc.