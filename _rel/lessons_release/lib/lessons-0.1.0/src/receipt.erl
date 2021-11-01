%%%-------------------------------------------------------------------
%%% @author kot
%%% @copyright (C) 2021, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 25. Oct 2021 22:25
%%%-------------------------------------------------------------------
-module(receipt).
-author("kot").

%% API
-export([shopping_list/0]).

-export([total_sum/0]).
-export([total_sum/1]).

-export([max_price_single/0]).
-export([max_price_single/1]).

-export([max_price/0]).
-export([max_price/1]).

-export([sum_bill/0]).
-export([sum_bill/1]).

-export([avg_cat/0]).
-export([avg_cat/1]).

-export([max_price_cat/0]).
-export([max_price_cat/1]).

-export([total/0]).


%%------------------------------------------------------------------------------
shopping_list() ->
  [ {moloko, pp, 49.20},
    {hleb, pp, 12.40},
    {shokolad, pp, 27.80},
    {yabloko, pp, 19.70},
    {milo, bh, 15.70},
    {stir_por, bh, 205.00},
    {zub_pasta, bh, 35.50},
    {molotok, in, 120.40},
    {nivilir, in, 5890.75},
    {perforator, in, 2450.80}
  ].
%%------------------------------------------------------------------------------
total_sum() ->
  total_sum(shopping_list()).

total_sum(ShopList) ->
  total_sum(ShopList, 0).

total_sum([{_Name, _Category, Price} | Goods], SumAcc) ->
  total_sum(Goods, Price + SumAcc);

total_sum([], SumAcc) -> SumAcc.
%%------------------------------------------------------------------------------
max_price_single() ->
  max_price_single(shopping_list()).

max_price_single(ShopList) ->
  max_price_single(ShopList, {no_name, no_category, 0}).

max_price_single([{Name, Category, Price} | Goods], {_, _, OldPrice} = Old) ->
  case(Price > OldPrice) of
    true ->
      max_price_single(Goods, {Name, Category, Price});
    false ->
      max_price_single(Goods, Old)
  end;

max_price_single([], Acc) -> Acc.
%%------------------------------------------------------------------------------
max_price() ->
  max_price(shopping_list()).

max_price(ShopList) ->
  max_price(ShopList, [{no_name, no_category, 0}]).

max_price([{Name, Category, Price} | Goods], [{_, _, OldPrice} | _] = OldAcc) ->
  case Price of
    _Price when Price > OldPrice ->
      max_price(Goods, [{Name, Category, Price} | OldAcc]);
    _Price when Price == OldPrice ->
      max_price(Goods, [{Name, Category, Price} | OldAcc]);
    _->
      max_price(Goods, OldAcc)
  end;
max_price([], Acc) -> Acc.
%%------------------------------------------------------------------------------
sum_bill() ->
  sum_bill(shopping_list()).

sum_bill(ShopList) ->
  sum_bill(ShopList, []).

sum_bill([{_Name, Category, Price} | Goods], Acc) ->
  NewAcc = calc_categ_price(Category, Price, Acc),
  sum_bill(Goods, NewAcc);

sum_bill([], Acc) -> Acc.
%%---------------------------------------------------
calc_categ_price(Category, Price, []) ->
  [{Category, Price}];

calc_categ_price(Category, Price, [{Category, OldPrice} | Acc]) ->
  [{Category, OldPrice + Price} | Acc];

calc_categ_price(Category, Price, [H | Acc]) ->
  [H | calc_categ_price(Category, Price, Acc)].
%%------------------------------------------------------------------------------
avg_cat() ->
  avg_cat(shopping_list()).

avg_cat(ShopList) ->
  avg_cat(ShopList, []).

avg_cat([{_Name, Category, Price} | Goods], Acc) ->
  NewAcc = calc_category(Category, Price, Acc),
  avg_cat(Goods, NewAcc);

avg_cat([], Acc) ->
  [{Category, TotalSum / Count} || {Category, Count, TotalSum} <- Acc].
%%---------------------------------------------------
calc_category(Category, Price, []) ->
  [{Category, 1, Price}];

calc_category(Category, Price, [{Category, Cc, Sc} | Acc]) ->
  [{Category, Cc + 1, Sc + Price} | Acc];

calc_category(Category, Price, [H | Acc]) ->
  [H | calc_category(Category, Price, Acc)].
%%------------------------------------------------------------------------------
max_price_cat() ->
  max_price_cat(shopping_list).

max_price_cat(ShopList) ->
  max_price_cat(ShopList, []).

max_price_cat([{_, Category, Price} | Goods], Acc) ->
  NewAcc = calc_categ_max_price(Category, Price, Acc),
  max_price_cat(Goods, NewAcc);

max_price_cat([], Acc) -> Acc.
%%---------------------------------------------------
calc_categ_max_price(Category, Price, []) ->
  [{Category, Price}];

calc_categ_max_price(Category, Price, [{Category, OldPrice} | Acc]) ->
  case Price > OldPrice of
    true ->
      [{Category, Price} | Acc];
    _ ->
      [{Category, OldPrice} | Acc]
  end;

calc_categ_max_price(Category, Price, [H | Acc]) ->
  [H | calc_categ_max_price(Category, Price, Acc)].
%%------------------------------------------------------------------------------
total() ->
  total(shopping_list()).

total(ShopList) ->
  TotalSum       = total_sum(ShopList),
  MaxPriceSingle = max_price_single(ShopList),
  MaxPrice       = max_price(ShopList),
  SumBill        = sum_bill(ShopList),
  AvgCat         = avg_cat(ShopList),
  MaxPriceCat    = max_price_cat(ShopList),
  {TotalSum, MaxPriceSingle, MaxPrice, SumBill, AvgCat, MaxPriceCat}.