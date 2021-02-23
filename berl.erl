-module(berl).



-export([p_05/1]).
-export([p_15/1]).
-export([p_19/1]).


p_05(List) -> p_05(List, []). % переворачиваю список аналог list:revers
p_05([H | T], Acc) ->
	p_05(T, [H | Acc]);
p_05([], Acc) -> Acc.


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



p_19(List) ->
	p_19(p_05(List), [], []).

p_19([], VO, CO) -> {VO, CO};
p_19([H | T], VO, CO) ->
	case (H div 2) of
		a ->
		p_19(T, VO, [H | CO]);
		_->
		p_19(T, [H | VO], CO)
	end.