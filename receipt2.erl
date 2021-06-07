-module(receipt2).

%-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
% Список покупок.
% Найти:
% - Общую сумму чека;
% - Мах цену товара, не зависимо от названя;
% - Все мах цены товаров, не зависимо от названя;
% - Мах сумму чека;
% - Среднее по всем категориям;
% - Мах цена по категориям.
%-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

-export([shopping_list/0]).

-export([total_sum/0]).
-export([total_sum/1]).

-export([max_price_single/0]).
-export([max_price_single/1]).

-export([max_price/0]).
-export([max_price/1]).

-export([sum_cat/0]).
-export([sum_cat/1]).
-export([calc_category_price/3]).

-export([avg_cat/0]).
-export([avg_cat/1]).
-export([calc_category/3]).

-export([max_price_cat/0]).
-export([max_price_cat/1]).
-export([calc_category_max_price/3]).

-export([total/0]).
-export([total/1]).

%-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
% Список покупок
shopping_list() ->
                  [{hleb, pp, 10.50},
                   {moloko, pp, 35.70},
                   {shokolad, pp, 14.50}, 
                   {yabloko, pp, 18.95},
                   {stir_por, bh, 70.59},
                   {zub_past, bh, 24.75},
                   {milo, bh, 17.65},
                   {perforator, in, 120.50},
                   {nivilir, in, 120.50}
                  ].

%-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
% Общая сумма чека

total_sum() ->
    total_sum(shopping_list()).

total_sum(ShopList) ->
    total_sum(ShopList, 0).
total_sum([{_Name, _Category, Price} | Goods], SumAcc) ->
    total_sum(Goods, Price + SumAcc);
total_sum([], SumAcc) ->
    SumAcc.

%-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
% - Мах цену товара, не зависимо от названя

max_price_single() ->
    max_price_single(shopping_list()).

max_price_single(ShopList) ->
    max_price_single(ShopList, {no_name, no_category, 0}).

max_price_single([{Name, Category, Price} | Goods], {_, _, OldPrice} = Old) ->
    case (Price > OldPrice) of
        true ->
            max_price_single(Goods, {Name, Category, Price});
        false ->
            max_price_single(Goods, Old)
    end;
max_price_single([], Acc) ->
    Acc.

%-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
% - Все мах цены товаров, не зависимо от названя

max_price() ->
    max_price(shopping_list()).

max_price(ShopList) ->
    max_price(ShopList, [{no_name, no_category, 0}]).

max_price([{Name, Category, Price} | Goods], [{_, _, OldPrice} | _] = OldAcc) ->
    case Price of
        _Price when Price > OldPrice ->
            max_price(Goods, [{Name, Category, Price}]);
        _Price when Price == OldPrice ->
            max_price(Goods, [{Name, Category, Price} | OldAcc]);
        _ -> 
            max_price(Goods, OldAcc)
    end;
max_price([], Acc) ->
    Acc.

%-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
% - Мах сумму чека

sum_cat() ->
    sum_cat(shopping_list()).
sum_cat(ShopList) ->
    sum_cat(ShopList, []).
sum_cat([{_, Category, Price} | Goods], Acc) ->
    NewAcc = calc_category_price(Category, Price, Acc),
    sum_cat(Goods, NewAcc);
sum_cat([], Acc) ->
    Acc.
%------------------------------
calc_category_price(Category, Price, []) ->
    [{Category, Price}];
calc_category_price(Category, Price, [{Category, OldPrice} | Acc]) ->
    [{Category, OldPrice + Price} | Acc];
calc_category_price(Category, Price, [H | Acc]) ->
    [H | calc_category_price(Category, Price, Acc)].

%-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
% - Среднее по всем категориям

avg_cat() ->
    avg_cat(shopping_list()).

avg_cat(ShopList) ->
    avg_cat(ShopList, []).

avg_cat([{_Name, Category, Price} | Goods], Acc) ->
    NewAcc = calc_category(Category, Price, Acc),
    avg_cat(Goods, NewAcc);
avg_cat([], Acc) ->
    [{Category, TotalSum / Count}|| {Category, Count, TotalSum} <- Acc].
%------------------------------
calc_category(Category, Price, []) ->
    [{Category, 1, Price}];
calc_category(Category, Price, [{Category, Cc, Sc} | Acc]) ->
    [{Category, Cc + 1, Sc + Price} | Acc];
calc_category(Category, Price,[H | Acc]) ->
    [H | calc_category(Category, Price, Acc)].

%-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
% - Мах цена по категориям

max_price_cat() ->
    max_price_cat(shopping_list()).

max_price_cat(ShopList) ->
    max_price_cat(ShopList, []).
max_price_cat([{_, Category, Price} | Goods], Acc) ->
    NewAcc = calc_category_max_price(Category, Price, Acc),
    max_price_cat(Goods, NewAcc);
max_price_cat([], Acc) ->
    Acc.
%------------------------------
calc_category_max_price(Category, Price, []) ->
    [{Category, Price}];
calc_category_max_price(Category, Price, [{Category, OldPrice} | Acc]) ->
        case Price > OldPrice of
            true ->
                [{Category, Price} | Acc];
            _ ->
                [{Category, OldPrice} | Acc]
        end;   

calc_category_max_price(Category, Price, [H | Acc]) ->
    [H | calc_category_max_price(Category, Price, Acc)].

%-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
% Выводим все категории

total() ->
    total(shopping_list()).

total(ShopList) ->
    TotalSum = total_sum(ShopList),           % Общая сумма чека;
    MaxPriceSingle = max_price_single(ShopList),             % Мах цену товара, не зависимо от названя;
    MaxPrice = max_price(ShopList),                          % Все мах цены товаров, не зависимо от названя;
    SumCat = sum_cat(ShopList),                              % Мах сумму чека;
    AvgCat = avg_cat(ShopList),                              % Среднее по всем категориям;
    MaxPriceCat = max_price_cat(ShopList),                   % Мах цена по категориям.
    {TotalSum, MaxPriceSingle, MaxPrice, SumCat, AvgCat, MaxPriceCat}.