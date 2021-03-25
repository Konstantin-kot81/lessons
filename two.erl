-module(two).

-export([mul_2/1]).
-export([mul/2]).
-export([sum/2]).
-export([div1/2]).
-export([sub/2]).
-export([test/0]).
-export([patern/1]).
-export([compare/2]).
-export([compare2/2]).
-export([max/2]).
-export([max/3]).
-export([min/3]).
% -export([pow1/2]).
-export([p_01/1]).

% умножение
mul_2(X) -> X * 2.

% умножение
mul(X, Y) -> X * Y.

% сложение
sum(X, Y) -> X + Y.

% деление
div1(X, Y) -> X / Y.

% вычитание
sub(X, Y) -> X - Y.


test() ->
        X = 10,
        Y = 2,
        S = two:sum(X, Y),
        Sb = sub(X, Y),
        D = div1(X, Y),
        io:format("sum = ~p\nsub = ~p\ndiv1 = ~p\n", [S, Sb, D]).

% выводит значение указанное в функции в виде записи, если его нет то выводит то значение которое задано
patern(1) -> one;
patern(2) -> two;
patern(3) -> three;
patern(X) -> X.

% сравнивает значения если равны то "true", если нет то "false"
compare(X, Y) ->
    io:format("X = ~p, Y = ~p\n", [X, Y]),
    Z = X == Y,
    io:format("Z = ~p\n", [Z]),
    Z.

% работает как строгое сравнение =:=

compare2(X, X) -> true;
compare2(_, _) -> false.

% выводит максимальное значение из указанных

max(X, Y) ->
    Z = X >= Y,
    max(X, Y, Z).


max(X, _, true) -> X;
max(_, Y, _) -> Y.

% выводит минимальное значение из указанных
min(X, _, true) -> X;
min(_, Y, _) -> Y.

% возводит в степень

% pow1(Num, Pow) ->
%     io:format("~n Num~p, Pow~p", [Num, Pow]),
%     pow1(Num, Pow, Num);
% pow1(Result, 1, _Init) ->
%     io:format("~n(fin) Num~p, Pow~p, _Init~p~n", [Result, 1, _Init]),
%     Result;
% pow1(N1, P, Init) ->
%     io:format("~n Num~p, Pow~p, Init~p~n", [N1, P, Init]),
% pow1(N1 * Init, P - 1, Init).

% [1,2,3,4,5,6,7] -> [7] последний элемент списка

p_01([X]) -> X;
p_01([_H | T]) -> p_01(T).