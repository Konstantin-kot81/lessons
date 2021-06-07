-module(moneydenom).

%-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
% Купюры. 
% Найти:
% - Кол-во купюр в пачке (в списке) - "N";
% - Кол-во купюр по номиналу (в списке) - "[S, R]";
% - Сумму по каждому номиналу - "[S, W]";
% - Общая сумма купюр (в списке).
%-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

-export([nominal/0]).

-export([quantity_banknote/0]).
-export([quantity_banknote/1]).

-export([quantity_nominal/0]).
-export([quantity_nominal/1]).

-export([calc_nominal/2]).

-export([sum_nominal/0]).
-export([sum_nominal/1]).

-export([total_sum/0]).
-export([total_sum/1]).

-export([total/0]).
-export([total/1]).

%-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
% Купюры (гривны)
nominal() ->
    [100, 500, 1, 2, 2, 5, 5, 200, 10, 20, 20, 50, 1000, 50, 100, 100, 200, 5, 200, 1, 500, 500, 1000, 1000].
%-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
% - Кол-во купюр в пачке

quantity_banknote() ->
    quantity_banknote(nominal()).

quantity_banknote(Nominal) ->
    quantity_banknote(Nominal, 0).

quantity_banknote([_Nominal | Rest], X) ->
    quantity_banknote(Rest, X + 1);
quantity_banknote([], X) ->
    X.

%-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
% - Кол-во купюр по номиналу
% Выводит значение когда список написан в разброс
quantity_nominal() ->
    quantity_nominal(nominal()).

quantity_nominal(Nominal) ->
    quantity_nominal(sorting:sorting(Nominal), []).
quantity_nominal([Nominal | Rest], Acc) ->
    NewAcc = calc_nominal(Nominal, Acc),
    quantity_nominal(Rest, NewAcc);
quantity_nominal([], Acc) ->
     Acc.

calc_nominal(Nominal, [{Nominal, C} | Rest]) ->
    [{Nominal, C + 1} | Rest];
calc_nominal(Nominal, [H | Acc]) ->
    [H | calc_nominal(Nominal, Acc)];
calc_nominal(Nominal, []) ->
    [{Nominal, 1}].
%------------------------------
% Выводит значение когда список идет от меньшего к большему или на оборот
% quantity_nominal([]) ->
%     [];
% quantity_nominal([Nominal | Rest]) ->
%     quantity_nominal(Rest, Nominal, 1, []).
% quantity_nominal([Nominal | Rest], Nominal, Count, Acc) ->
%     quantity_nominal(Rest, Nominal, Count + 1, Acc);
% quantity_nominal([Nominal | Rest], F, Count, Acc) ->
%     quantity_nominal(Rest, Nominal, 1, [{F , Count} | Acc]);
% quantity_nominal([], F, Count, Acc) ->
%     revers:revers([{F, Count} | Acc]).

%-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
% - Сумму по каждому номиналу
% Выводит значение когда список написан в разброс
sum_nominal() ->
    sum_nominal(quantity_nominal()).

sum_nominal(Nominal) ->
    sum_nominal(Nominal, []).
sum_nominal([{Nominal, Count} | Rest], Acc) ->
    sum_nominal(Rest, [{Nominal, Nominal * Count} | Acc]);
sum_nominal([], Acc) ->
    revers:revers(Acc).
%------------------------------
% Выводит значение когда список идет от меньшего к большему или на оборот
% sum_nominal([]) ->
%     [];
% sum_nominal([Nominal | Rest]) ->
%     sum_nominal(Rest, Nominal, 1, []).
% sum_nominal([Nominal | Rest], Nominal, Count, Acc) ->
%     sum_nominal(Rest, Nominal, Count + 1, Acc);
% sum_nominal([Nominal | Rest], F, Count, Acc) ->
%     sum_nominal(Rest, Nominal, 1, [{F, Count * F} | Acc]);
% sum_nominal([], F, Count, Acc) ->
%     [{F, Count * F} | Acc].

%-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
% - Общая сумма купюр

total_sum() ->
    total_sum(nominal()).

total_sum(Nominal) ->
    total_sum(revers:revers(Nominal), 0).

total_sum([Nominal | Rest], SumAcc) ->
    total_sum(Rest, Nominal + SumAcc);
total_sum([], SumAcc) ->
    SumAcc.

%-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
% Выводим все категории

total() ->
    total(nominal()).

total(Nominal) ->
    Qty_banknote = quantity_banknote(Nominal),           % Кол-во купюр в пачке;
    Qty_nominal = quantity_nominal(Nominal),             % Кол-во купюр по номиналу;
    Sum_nominal = sum_nominal(quantity_nominal(Nominal)),                  % Сумму по каждому номиналу;
    Total_sum = total_sum(Nominal),                      % Общая сумма купюр.
    [Qty_banknote, Qty_nominal, Sum_nominal, Total_sum].