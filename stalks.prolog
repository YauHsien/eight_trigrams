:- encoding(utf8).

起卦(Lines) :- findnsols(6, X, (repeat,揲蓍(X)), Lines), !.

揲蓍(Line) :-
    Stalks is 50 - 1,
    揲蓍2(3, 0, Stalks, nil, Line).

揲蓍2(N, N, _Stalks, Line, Line) :- !.
揲蓍2(N, M, Stalks, Acc, Line) :-
    N > M,
    分二(Stalks, A, B),
    掛一((A,B), (A2,B2)),
    maplist([X,Q]>>(
                揲四(X,R),
                歸奇(X,R,Q)
            ), [A2,B2], Qs),
    sum_list(Qs, Stalks2),
    M2 is M+1,
    ( N =:= M+1, !,
      Acc2 is Stalks2 div 4,
      揲蓍2(N, M2, Stalks2, Acc2, Line)
    ; 揲蓍2(N, M2, Stalks2, Acc, Line)
    ).

分二(Stalks, A, B) :-
    L is 5,
    U is Stalks - 5,
    random_between(L, U, A),
    B is Stalks - A.

掛一((A,B), (A2,B2)) :-
    random_between(0, 1, R),
    ( R =:= 0, !,
      A2 is A - 1, B2 = B
    ; A2 = A, B2 is B - 1
    ).

% +R: member(R,[1,2,3,4]).
揲四(X, R) :-
    R0 is X rem 4,
    ( R0 =:= 0, !,
      R = 4
    ; R = R0
    ).

歸奇(X, R, Q) :- Q is X - R.
