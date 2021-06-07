-module(visitlog1).

%-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
% Написать журнал и заполнить его значениями.
% Найти:
% - Тройка лучших;
% - Тройка худших;
% - Среднюю оценку группы;
% - Человек наиболее ближайший к средней оценке группы (чья оценка ближе всего к оценке группы).
%-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

-export([journal/0]).

-export([main/0]).
-export([main/1]).

-export([calc_activ/1]).
-export([avg_mark/1]).

-export([avg_visit_log/0]).
-export([avg_visit_log/1]).




-export([calc_new_el/1]).



% -export([sum_visit_log/0]).
% -export([sum_visit_log/1]).



% -export([rating_visit_log/0]).
-export([rating_visit_log/1]).

-export([get_result/1]).

-export([sort_visit_log/1]).

-export([partition_visit_log/1]).

-export([total_visit_log/0]).
-export([total_visit_log/1]).

-export([revers_visit_log/1]).
-export([avg/0]).



%-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
% Журнал с данными
journal() ->
    [{1, burchak, [true, true, false, true, true], [null, 4, null, 12, 6]},
     {2, razgulyaka, [false, false, false, false, false], [null, null, null, null, null]},
     {3, primorina, [true, true, true, false, false], [2, null, 8, null, null]},
     {4, vigodina, [false, true, true, true, true], [null, 7, 3, null, 5]},
     {5, karatov, [false, false, false, false, false], [null, null, null, null, null]},
     {6, besedin, [true, true, true, true, false], [6, 8, null, 12, null]},
     {7, shershova, [true, true, true, true, true], [7, 9, 8, 10, 11]},
     {8, oblomova, [false, false, false, false, false], [null, null, null, null, null]},
     {9, sharikov, [true, true, true, false, true], [null, 11, null, null, 10]},
     {10, zaznaikina, [true, true, true, true, true], [10, 11, 12, 9, 12]},
     {11, rezak, [true, false, false, false, false], [null, null, null, null, null]},
     {12, gromov, [true, false, true, false, false], [null, null, 7, null, null]},
     {13, gromova, [false, false, false, false, false], [null, null, null, null, null]},
     {14, skvorcov, [true, true, true, true, true], [7, 9, null, 10, null]},
     {15, razdviga, [true, true, false, true, true], [7, null, null, 10, 8]},
     {16, raskrutkina, [true, false, true, false, true], [null, null, 12, null, 12]},
     {17, nazarov, [false, false, false, false, false], [null, null, null, null, null]},
     {18, pyatakov, [true, true, true, false, false], [7, 9, null, null, null]},
     {19, razvratkina, [true, true, true, true, true], [7, 9, null, 10, 11]},
     {20, mokrikov, [true, false, true, true, true], [9, null, 10, 8, 10]},
     {21, prudnikov, [true, false, false, true, true], [9, null, null, 8, 7]}
    ].
%-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
% Выводит значение журнала с данными
main() ->
    % List = j(), либо такая запись
    % main(List).
    main(journal()).  % либо такая

main(Jornal) ->
    main(revers:revers(Jornal), []).

main([Element| Rest], Acc) ->
    NewElement = calc_new_el(Element),
    main(Rest, [NewElement | Acc]);
main([], Acc) ->
    Acc.
%------------------------------
calc_new_el({Id, Sname, Activity, Marks}) ->
    CalAct = calc_activ(Activity),
    AvgMarck = avg_mark(Marks),
    {Id, Sname, Activity, CalAct, Marks, AvgMarck}.
%------------------------------
calc_activ(Jornal) ->
    calc_activ(Jornal, 0, 0).

calc_activ([true | Rest], N, M) ->
    calc_activ(Rest, N + 1, M + 1);
calc_activ([_ | Rest], N, M) ->
    calc_activ(Rest, N, M + 1);
calc_activ([], N, M) ->
    {N, M}.
%------------------------------
avg_mark(Jornal) ->
    avg_mark(Jornal, 0, 0).

avg_mark([null | Rest], X, Y) ->
    avg_mark(Rest, X, Y);
avg_mark([Mark | Rest], X, Y) ->
    avg_mark(Rest, X + 1, Y + Mark);
avg_mark([], 0, _) ->
    null;
avg_mark([], _, 0) ->
    null;
avg_mark([], X, Y) ->
    Y / X.

%-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

avg_visit_log() ->
    avg_visit_log(journal()).

avg_visit_log(Jornal) ->
    avg_visit_log(revers:revers(Jornal), []).

avg_visit_log([{Id, _Sname, _Flag, Degree} | Group], Acc) ->
    io:format("~p => Id ~p, _Sname ~p, _Flag ~p, Degree ~p~n", [?LINE, Id, _Sname, _Flag, Degree]),
    New = get_result(Degree),
    avg_visit_log(Group, [{Id, New} |Acc]);
avg_visit_log([], Acc) ->
    io:format("~p => []~p, Acc~p~n", [?LINE, [], Acc] ),
    Acc.
    % [{Sum / Count} || {Count, Sum} <- Acc].
%------------------------------
% [null, null, 12, null, 12] -> 24/2 = 12

get_result(Degree) ->
    get_result(Degree, 0, 0).

get_result([null | Rest], C, S) ->
    get_result(Rest, C, S);
get_result([Degree | Rest], C, S) ->
    get_result(Rest, C + 1, S + Degree);
get_result([], 0, _) ->
    null;
get_result([], _, 0) ->
    null;
get_result([], C, S) ->
    S / C.

%-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

% [1,2,3,4,5,6,7,8,9,10,11]

avg() ->
    Marks = [1.2, 2.9, 3.7, 4.6, 5, 6.8 ,7,8,9,10,11],
    Avg = avg_mark(Marks),
    {Avg, median(Marks, Avg)}.

median(List, X) ->
    median(List, X, 0, 999).

median([H | T], X, Y, Z) ->
    Abs = abs(H-X),
    case Abs < Z of
        true -> 
            median(T, X, H, Abs);
        false ->
            median(T, X, Y, Z)
    end;
median([], _, Y, _) ->
    Y.


























% main() ->
%     List = j(),
%     main(List).

% main(List) ->
%     main(List, []).

% main([Elem| Rest], Acc) ->
%     NewElement = calcnewEl(Elem),
%     main(Rest, [NewElement | Acc]);
% main([], Acc) -> Acc.

% calcnewEl({Id, Sname, Activity, Marks}) ->
%     CalAct = calcactiv(Activity),
%     AvgMarck = avgmark(Marks),
%     {Id, Sname, Activity, CalAct, Marks, AvgMarck}.

% calcactiv(List) ->
%     calcactiv(List, 0, 0).

% calcactiv([true | T], N, M) ->
%     calcactiv(T, N + 1, M + 1);
% calcactiv([_ | T], N, M) ->
%     calcactiv(T, N, M + 1);
% calcactiv([], N, M) ->
%     {N, M}.

% avgmark(List) ->
%     avgmark(List, 0, 0).

% avgmark([null | T], X, Y) ->
%     avgmark(T, X, Y);
% avgmark([Mark | T], X, Y) ->
%     avgmark(T, X + 1, Y + Mark);
% avgmark([], X, Y) ->
%     Y / X.


% j(List) ->
%     True = [true],
%     False = [false],
%     j(List, True, False, [], []);

% j([{_, _, [Flag], [_Digit]} | Rest], True, False, T, F) ->
%     case (True, Flag) of
%         true ->
%             j(Rest, True, False, [H | T], F);
%         false ->
%             j(Rest, True, False, T, [H | F]);
%     end,
% j([], _, _, T, F) ->
%     {T, F}.   



%     io:format("~p => List~p~n", [?LINE, List]),
%     j(List, [], 0).

% j([{_, _, [Flag], [_Digit]} | Rest], Acc, Count) ->
%     io:format("~p => _~p, _~p, Flag~p, _Digial~p, Rest~p, Acc~p, Count~p~n", [?LINE, _, _, Flag, _Digial, Rest, Acc, Count]),
%     j(Rest, [Flag | Acc], Count + 1);
% j([], Acc) ->
%     io:format("~p => []~p, Acc~p~n", [?LINE, [], Acc]),
%     Acc.







rating_visit_log(List) ->
    rating_visit_log(List, []).

rating_visit_log([{_, _, [_], {_, _}, [Rating, _], _} | Group], Acc) ->
    rating_visit_log(Group, [Rating | Acc]);

rating_visit_log([], Acc) ->
    sort_visit_log(Acc).

sort_visit_log([]) ->
    [];

sort_visit_log([Rating | Group]) ->
    sort_visit_log([X || X <- Group, X < Rating])
    ++ [Rating] ++
    sort_visit_log([Y || Y <- Group, Y >= Rating]).

%\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\

partition_visit_log(List) ->
    partition_visit_log(List, [], [], 1).

partition_visit_log([], Wt, Bt, _) ->
    {Wt, Bt};
partition_visit_log([H | Rest], Wt, Bt, Count) ->
    case(Count rem 2) of
        0 ->
            partition_visit_log(Rest, [H | Wt], Bt, Count + 1);
        1 ->
            partition_visit_log(Rest, Wt, [H | Bt], Count + 1)
    end.

%\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\

revers_visit_log(List) ->
    revers_visit_log(List, []).

revers_visit_log([H | Rest], Acc) ->
    revers_visit_log(Rest, [H | Acc]);
revers_visit_log([], Acc) ->
    Acc.

%-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

total_visit_log() ->
    total_visit_log([{1, svistunov, [true], {1, 5}, [7, 12], 6.4},
                     {2, razgulyaka, [false], {0, 5}, [2, 12], 3.2},
                     {3, primorina, [true], {3, 5}, [8, 12], 8.4},
                     {4, vigodina, [true], {4, 5}, [4, 12], 3.8},
                     {5, karatov, [false], {0, 5}, [null, 12], 0.0},
                     {6, besedin, [true], {4, 5}, [6, 12], 4.7},
                     {7, shershova, [true], {5, 5}, [10, 12], 8.9},
                     {8, oblomova, [false], {0, 5}, [null, 12], 11.7},
                     {9, sharikov, [true], {4, 5}, [null, 12], 5.6},
                     {10, zaznaikina, [true], {5, 5}, [12, 12], 6.8},
                     {11, rezak, [false], {1, 5}, [4, 12], 1.2},
                     {12, gromov, [true], {2, 5}, [7, 12], 4.0},
                     {13, gromova, [false], {0, 5}, [null, 12], 8.7},
                     {14, skvorcov, [true], {5, 5}, [null, 12], 6.6},
                     {15, razdviga, [teue], {4, 5}, [7, 12], 5.1},
                     {16, raskrutkina, [true], {2, 5}, [4, 12], 2.8},
                     {17, nazarov, [false], {0, 5}, [null, 12], 1.9},
                     {18, pyatakov, [false], {3, 5}, [8, 12], 4.9},
                     {19, razvratkina, [true], {5, 5}, [10, 12], 8.1},
                     {20, mokrikov, [true], {4, 5}, [null, 12], 2.5},
                     {21, prudnikov, [false], {3, 5}, [5, 12], 7.2}              
                    ]).

total_visit_log(List) ->
    % Sum = sum_visit_log(List),
    % Avg = avg_visit_log(List),
    Rating = rating_visit_log(List),
    { Rating}.





    % sum_visit_log(List) ->
    %     sum_visit_log(List, 0).
    
    % sum_visit_log([{_, _, [_Flag], {_, _}, [_, _], Degree} | Group], SumAcc) ->
    %     sum_visit_log(Group, Degree + SumAcc);
    
    % sum_visit_log([], SumAcc) ->
    %     SumAcc.