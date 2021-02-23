-module(anles).


-export([mul/2]).
-export([mul_2/1]).          
-export([sum/2]).            
-export([div1/2]).           
-export([sub/2]). 

-export([test/0]).

-export([patern/1]).
-export([compare/2]).
-export([compare2/2]).

-export([max/2]).
-export([min/2]).
-export([pow1/2]).

-export([p_01/1]).
-export([p_02/1]).
-export([p_03/1]).
-export([p_04/1]).
-export([p_05/1]).
-export([p_06/1]).
-export([p_07/1]).
-export([p_08/1]).
-export([p_09/1]).
-export([p_10/1]).
-export([p_11/1]).
-export([p_12/1]).
-export([p_13/1]).
-export([p_14/1]).
-export([p_15/1]).
-export([p_16/2]).
-export([p_17/1]).
-export([p_18_1/0]).
-export([p_18_2/2]).
-export([p_18_2/3]).
-export([split/2]).
-export([p_19/1]).
-export([p_20/1]).
-export([p_21/1]).

-export([p_00/0]).    % бесконечная рекурсия (вечный цикл)





% %%%%%%% 28.01.2021 %%%%%%%%%%%%%%%%%%%% LESSON_1 %%%%%%%%%%%%%%%%%%%%


mul_2(X) -> X * 2.   % Умножение

mul(X, Y) -> X * Y.

sum(X, Y) -> X+Y.    % Сложение

div1(X, Y) -> X/Y.   % Диление

sub(X, Y) -> X-Y.    % Вычитание


% test() ->
% 	X = 2,
% 	Y = 3,
% 	X.

test() ->                           % присвоение чисел
		X  = 10,
		Y  = 2,
		S  = module:sum(X, Y),
		Sb = sub(X, Y),
		D  = div1(X, Y),
		io:format("sum = ~p\nsub = ~p\ndiv = ~p\n",[S, Sb, D]).


patern(1) -> one;   % Выводит значение указанное в функции в виде записи, 
patern(2) -> two;   % если его нет то выводит то значение которое задано
patern(3) -> three;
patern(X) -> X.

compare(X,Y) ->                            % Сравнивает значения если равны то true
	io:format("X = ~p Y = ~p\n", [X, Y]),  % если нет то false
	Z = X == Y,
	io:format("Z = ~p\n", [Z]),
	Z.

compare2(X,X) -> true; % Работает как строгое сравнение =:=
compare2(_,_) -> false.


%%%%%%% 28.01.2021 %%%%%%%%%%%%%%%%%%%% HOMETASKS %%%%%%%%%%%%%%%%%%%%


max(X, Y) ->            % Выводит максимальное значение из указанных
	Z = X >= Y,
	max(X, Y, Z).

max(X, _, true) -> X;
% cond(X, Y, Z) -> 1.
max(_, Y, _) -> Y.

min(X, Y) ->            % Выводит минимальное значение из указанных
	Z = X =< Y,
	min(X, Y, Z).
	
min(X, _, true) -> X;
min(_, Y, _) -> Y.

% pow1(Result, 1) -> Result;
% pow1(Num, Power) ->
% 	pow1(Num * Num, Power - 1).          % Работает не корректно

pow1(Num, Pow) ->                        % Возводит в степень
	% io:format("~n Num ~p Pow ~p", [Num, Pow]),
	pow1(Num, Pow, Num).

pow1(Result, 1, _Init) -> 
	% io:format("~n(fin) Num ~p Pow ~p Init ~p~n", [Result, 1, Init]),
	Result;
pow1(N1, P, Init) ->
	% io:format("~n Num ~p Pow ~p Init ~p", [N1, P, Init]),
	pow1(N1 * Init, P - 1, Init).


%%%%%%% 02.02.2021 %%%%%%%%%%%%%%%%%%%% LESSON_2 %%%%%%%%%%%%%%%%%%%%


p_01([Last]) -> Last;        % последний элемент списка
p_01([_ | T]) -> p_01(T).


% p_02([Last2, Last1]) -> [Last2, Last1];
% p_02([_ | T]) -> p_02(T). рабочий, но не компактный


p_02([_, _] = L) -> L;       % два полседних элемента списка
p_02([_ | T]) -> p_02(T).


p_03([_, _, _] = L) -> L;    % три последних элемента списка
p_03([_ | T]) -> p_03(T).

                             %% выводит кол-во элементов списка
p_04(List) -> p_04(List, 0). % находит исходный список и аккум для сумирования

p_04([], Count) -> Count;    % условие выхода из рекурсии которая вернет кол-во элементов
                             % в списке, которые подсчитались в рекурсивной части и могут быть
                             % получены в переменной count.D
p_04([_ | T], C0) ->          % если в списке более нуля элементов, то мы откусываем голову (один
                             % элемент из списка), а в аккум прибавляем 1, тем самым увеличивая
                             % аккум на 1 это происходит до тех пор пока список не станет пустым
	p_04(T, C0 + 1). 


%%%%%%% 04.02.2021 %%%%%%%%%%%%%%%%%%%% LESSON_3 %%%%%%%%%%%%%%%%%%%%


p_05(List) -> p_05(List, []). % переворачиваю список аналог list:revers
p_05([H | T], Acc) ->
	p_05(T, [H | Acc]);
p_05([], Acc) -> Acc.

p_06(List) ->                 % слаживаю и умножаю элементы списока в одной функции одновременно 
	p_06(List, 0, 1).
p_06([H | T], S, P) ->
	p_06(T, S + H, P * H);
p_06([], S, P) -> {S, P}.

p_07(List) -> p_07(List, []). % дублирует элементы списка
p_07([H | T], Acc) ->
	p_07(T, [H, H | Acc]);
p_07([], Acc) -> p_05(Acc).

p_08(List) -> p_08(List, []). % убирает дубликаты списка (типа архиватора)
p_08([H, H | T], Acc)->
	p_08(T, [H | Acc]);
p_08([H | T], Acc) ->
	p_08(T, [H | Acc]);
p_08([], Acc) -> p_05(Acc).


%%%%%%% 05.02.2021 %%%%%%%%%%%%%%%%%%%% HOMETASKS %%%%%%%%%%%%%%%%%%%%


% [1,1,1,1,2,2,3,3,4] -> [{1,4}, {2,2}, {3,2}, {4,1}]


p_09([]) -> [];                     % слаживает одинаковые значения списка и выводит
p_09([H | T]) -> p_09(T, H, 1, []). % кортедж с подсчитанным колличеством одинаковых
p_09([H | T], H, C, Acc) ->         % элементоав
	p_09(T, H, C +1, Acc);
p_09([H | T], D, C, Acc) ->
	p_09(T, H, 1, [{D, C}| Acc]);
p_09([], D, C, Acc) ->
	p_05([{D, C}| Acc]). 


%%%%%%% 09.02.2021 %%%%%%%%%%%%%%%%%%%% LESSON_4 %%%%%%%%%%%%%%%%%%%%


p_10(Pal) ->                % функция проверят слова полиндромы "мадам"
	Pal =:= p_05(Pal).

p_11(N) -> p_11(N, []).       % функчия генерирует список заданной дины
p_11(1, Acc) -> [1 | Acc];    %  4 -> [1,2,3,4]
p_11(N, Acc) ->               % если задать 0 то будет бесконечный цикл
	p_11(N - 1, [N | Acc]).

p_12(N) -> p_12(N, []).       % генерирует последовательность чисел от 1 до заданного
p_12(0, Acc) -> Acc;
p_12(N, Acc) ->
	p_12(N - 1, [N | Acc]).

p_13(N) -> X = p_11(N), p_05(X). % тоже что и р_11 только числа выводит в 
								 % обратном порядке

% p_13(0) -> [];                 % сначала считает  головы к хвосту,
% p_13(N) ->                     % а потом от хвоста к олове
%	[N | p_13(N - 1)].

% [1,2,3,4,5] -> [2,4,6,8,10]

p_14(List) -> p_14(List, []). % каждое число списка умножается на 2
p_14([], Acc) -> p_05(Acc);
p_14([H | T], Acc) ->
	p_14(T, [H * 2 | Acc]).

% [1,3,5,4,9,8,6,2,7] -> {[1,3,5,9,7], [4,8,6,2]}

p_15(List) -> p_15(List, [], []).   % разбиваем входной список чисел на четные и не четные
p_15([], EV, OD) -> {EV, OD};       % в результате формируеться кортеж со списком четных и не четных
p_15([H | T], EV, OD) ->
	case (H rem 2) of
		0 ->
			p_15(T, EV, [H | OD]);
		_ ->
			p_15(T, [H | EV], OD)
	end.

% p_15(List) -> p_15(p_05(List), [], []).     % реверс (для корректного вывода такого как в задании

% [1,2,3,4] , 3 -> true                       % нужно заменить 219 строку)

p_16([], _) -> false;             % находит в списке заданное значение, если присутствует trye,
p_16([H | _], H) -> true;         % если нет false
p_16([_ | T], N) ->  
	p_16(T, N).


% e() ->
% 	lists:member(1, [1,2,3]).


%%%%%%% 11.02.2021 %%%%%%%%%%%%%%%%%%%% HOMETASKS %%%%%%%%%%%%%%%%%%%%


%[1,3,5,7,9,2,4,6,8,10,0] -> {[1,7,4,10], [3,9,6,0], [5,2,8]} 
%- условное название "на 1й-3й расчитайсь" - тоесть каждый 3й элемент 
%попадет в 3й список 2й - во второй, 1й в 1й.


p_17(List) -> 
	p_17(p_05(List), [], [], [], 1).

p_17([], Ft, Sd, Th, _) -> {Ft, Sd, Th};   % {p_05(Ft), p_05(Sd), p_05(Th)} можно и сдесь
p_17([H | T], Ft, Sd, Th, Count) ->        % перевернуть список
	case (Count rem 3) of
		0 ->
			p_17(T, [H | Ft], Sd, Th, Count + 1);
		1 ->
			p_17(T, Ft, [H | Sd], Th, Count + 1);
		_ ->
			p_17(T, Ft, Sd, [H | Th], Count + 1)
	end.


%%%%%%% 11.02.2021 %%%%%%%%%%%%%%%%%%%% LESSON_5 %%%%%%%%%%%%%%%%%%%%


p_18_1() ->                  %создали список пар ключь-значение
	[
		{name, kot}, 
		{sname, bur},
		{age, 40},
		{gender, m},
		{it, null}
	].

p_18_2([], _) -> null;
p_18_2([{Key, Value} | _], Key) -> {ok, Value};
p_18_2([_ | T], Key) -> 
	p_18_2(T, Key).


p_18_2(List, Key, Default) ->
	case p_18_2(List, Key) of
	     {ok, Value} -> Value;
		  _ -> Default
    end.

% функция SPLIT

split(List, Div) -> 
	p_05(split(List, Div, [], [])).

split([], _, Word, Tokens) -> [p_05(Word) | Tokens]; % или р_05([p_05(Word) | Tokens])  
split([H | T], H, Word, Tokens) ->
	split(T, H, [], [p_05(Word) | Tokens]);
split([H | T], Div, Word, Tokens) ->
	split(T, Div, [H | Word], Tokens).


%%%%%%% 16.02.2021 %%%%%%%%%%%%%%%%%%%% HOMETASKS %%%%%%%%%%%%%%%%%%%%


%[a, b, c, d, e, f, g, h, i, j, k, l, 
%m, n, o, p , q, r, s, t, u, v, w, x, y, z] -> {[a, e, i, o, u], [b, c, d, f, g, h, j, k, l, m, n, 
%p, q, r, s, t, v, w, x, y, z]}

p_19(List) -> 
	TempVO = [a, e, i, o, u],
	TempCO = [b, c, d, f, g, h, j, k, l, m, n, p, q, r, s, t, v, w, x, y, z],
	p_19(p_05(List), TempVO, TempCO, [], []).

p_19([],_, _, VO, CO) -> {VO, CO};  % вв данномслучае функцию р_05 лучше поставить сдесь
p_19([H | T], TempVO, TempCO, VO, CO) ->
	case (p_16(TempVO, H)) of
		true ->
			p_19(T, TempVO, TempCO, [H | VO], CO);
		_-> 
			case (p_16(TempCO, H)) of
				true ->
					p_19(T, TempVO, TempCO, VO, [H | CO]);
				_ ->
					p_19(T, TempVO, TempCO, VO, CO)
			end
	end.


%%%%%%% 16.02.2021 %%%%%%%%%%%%%%%%%%%% LESSON_6 %%%%%%%%%%%%%%%%%%%%


% 
 -> [1,2,3,a,d,v,4,4,5,6,12]

p_20(List) -> 
	Acc = p_20(List, []),
	p_05(Acc).

p_20([], Acc) -> Acc;
p_20([[] | T], Acc) ->
	p_20(T, Acc);
p_20([[H|T0] | T], Acc) ->
	p_20([T0|T], [H|Acc]);
p_20([H | T], Acc) ->
	p_20(T, [H|Acc]).


% [[1,2,3], [a,d,v], 4, [4,5,6,12]] -> [1,2,3,a,d,v,4,4,5,6,12]
% [[[[],[1],2],3], [a,d,v], 4, [4,5,6,12]] -> [1,2,3,a,d,v,4,4,5,6,12]


p_21(List) ->
	io:format("~p => List ~p~n", [?LINE, List]),
	p_05(p_21(List, [])).

p_21([], Acc) -> 
	io:format("~p => Acc ~p~n",[?LINE, Acc]),
	Acc;
p_21([H | T], Acc) ->
	io:format("~p => H ~p, T ~p, Acc ~p~n",[?LINE, H, T, Acc]),
	NewAcc = p_21(H, Acc),                                                 % вызов для головы
	io:format("~p => NewAcc ~p~n",[?LINE, NewAcc]),
	p_21(T, NewAcc);                                                       % вызов для хвоста
p_21(El, Acc) -> 
	io:format("~p => El ~p, Acc ~p~n",[?LINE, El, Acc]),
	[El|Acc].


% бесконечная рекурсия (вечный цикл)
p_00() -> p_00().


%%%%%%% 18.02.2021 %%%%%%%%%%%%%%%%%%%% LESSON_7 %%%%%%%%%%%%%%%%%%%%


%p_22()