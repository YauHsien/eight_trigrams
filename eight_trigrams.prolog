:- encoding(utf8).

陰爻(6).
陰爻(8).

陽爻(7).
陽爻(9).

爻變(6, 9).
爻變(7, 7).
爻變(8, 8).
爻變(9, 6).

卦([A,B,C,D,E,F], [A2,B2,C2,D2,E2,F2], Name) :-
    初爻(A, A2),
    爻二(B, B2),
    爻三(C, C2),
    爻四(D, D2),
    爻五(E, E2),
    上爻(F, F2),
    卦名(Name, [A,B,C,D,E,F]).

變卦([A,B,C,D,E,F], Result, Name, Solution/Tokens) :-
    maplist([X,Y]>>(爻變(X,Y)), [A,B,C,D,E,F], List),
    卦(List, Result, Name),
    解卦([A,B,C,D,E,F], List, Solution/Tokens).

解卦(List, List2, Solution/Tokens) :-
    maplist([A,B,C]>>( A \= B, !, C = A
                     ; C = nil/B
            ), List, List2, Tokens0),
    include(\=(nil), Tokens0, Tokens1),
    include([T/_]>>(T=nil), Tokens0, Tokens2),
    length(Tokens1, N0),
    length(Tokens2, N2),
    ( N0 =:= 6, !, Solution = '本卦', Tokens = []
    ; N0 =:= 1, !, Solution = '本卦', Tokens = Tokens1
    ; N0 =:= 2, !, Solution = '本卦', Tokens = Tokens1
    ; N0 =:= 3, !, Solution = '本卦與變卦', Tokens = []
    ; N2 =:= 2, !, Solution = '變卦', Tokens = Tokens2
    ; N2 =:= 1, !, Solution = '變卦', Tokens = Tokens2
    ; N2 =:= 6, (
          foreach(member(X,List), 陽爻(X)), !, Solution = '用九', Tokens = []
      ; foreach(member(X,List), 陰爻(X)), !, Solution = '用六', Tokens = []
      ; Solution = '變卦', Tokens = []
      )
    ).

初爻(X, '初六') :- 陰爻(X).
初爻(X, '初九') :- 陽爻(X).

爻二(X, '六二') :- 陰爻(X).
爻二(X, '九二') :- 陽爻(X).

爻三(X, '六三') :- 陰爻(X).
爻三(X, '九三') :- 陽爻(X).

爻四(X, '六四') :- 陰爻(X).
爻四(X, '九四') :- 陽爻(X).

爻五(X, '六五') :- 陰爻(X).
爻五(X, '九五') :- 陽爻(X).

上爻(X, '上六') :- 陰爻(X).
上爻(X, '上九') :- 陽爻(X).

下三爻(Name, [A,B,C,_,_,_]) :- 三爻(Name, [A,B,C]).
上三爻(Name, [_,_,_,A,B,C]) :- 三爻(Name, [A,B,C]).

三爻('天', [A,B,C]) :- foreach(member(X,[A,B,C]), 陽爻(X)).
三爻('澤', [A,B,C]) :- 陽爻(A), 陽爻(B), 陰爻(C).
三爻('火', [A,B,C]) :- 陽爻(A), 陰爻(B), 陽爻(C).
三爻('雷', [A,B,C]) :- 陽爻(A), 陰爻(B), 陰爻(C).
三爻('風', [A,B,C]) :- 陰爻(A), 陽爻(B), 陽爻(C).
三爻('水', [A,B,C]) :- 陰爻(A), 陽爻(B), 陰爻(C).
三爻('山', [A,B,C]) :- 陰爻(A), 陰爻(B), 陽爻(C).
三爻('地', [A,B,C]) :- foreach(member(X,[A,B,C]), 陰爻(X)).

卦名('乾', List) :- 下三爻('天', List), 上三爻('天', List).
卦名('夬', List) :- 下三爻('天', List), 上三爻('澤', List).
卦名('大有', List) :- 下三爻('天', List), 上三爻('火', List).
卦名('大壯', List) :- 下三爻('天', List), 上三爻('雷', List).
卦名('小畜', List) :- 下三爻('天', List), 上三爻('風', List).
卦名('需', List) :- 下三爻('天', List), 上三爻('水', List).
卦名('大畜', List) :- 下三爻('天', List), 上三爻('山', List).
卦名('泰', List) :- 下三爻('天', List), 上三爻('地', List).
卦名('履', List) :- 下三爻('澤', List), 上三爻('天', List).
卦名('兌', List) :- 下三爻('澤', List), 上三爻('澤', List).
卦名('睽', List) :- 下三爻('澤', List), 上三爻('火', List).
卦名('歸妹', List) :- 下三爻('澤', List), 上三爻('雷', List).
卦名('中孚', List) :- 下三爻('澤', List), 上三爻('風', List).
卦名('節', List) :- 下三爻('澤', List), 上三爻('水', List).
卦名('損', List) :- 下三爻('澤', List), 上三爻('山', List).
卦名('臨', List) :- 下三爻('澤', List), 上三爻('地', List).
卦名('同人', List) :- 下三爻('火', List), 上三爻('天', List).
卦名('革', List) :- 下三爻('火', List), 上三爻('澤', List).
卦名('離', List) :- 下三爻('火', List), 上三爻('火', List).
卦名('豐', List) :- 下三爻('火', List), 上三爻('雷', List).
卦名('家人', List) :- 下三爻('火', List), 上三爻('風', List).
卦名('既濟', List) :- 下三爻('火', List), 上三爻('水', List).
卦名('賁', List) :- 下三爻('火', List), 上三爻('山', List).
卦名('明夷', List) :- 下三爻('火', List), 上三爻('地', List).
卦名('无妄', List) :- 下三爻('雷', List), 上三爻('天', List).
卦名('隨', List) :- 下三爻('雷', List), 上三爻('澤', List).
卦名('噬嗑', List) :- 下三爻('雷', List), 上三爻('火', List).
卦名('震', List) :- 下三爻('雷', List), 上三爻('雷', List).
卦名('益', List) :- 下三爻('雷', List), 上三爻('風', List).
卦名('屯', List) :- 下三爻('雷', List), 上三爻('水', List).
卦名('頤', List) :- 下三爻('雷', List), 上三爻('山', List).
卦名('復', List) :- 下三爻('雷', List), 上三爻('地', List).
卦名('姤', List) :- 下三爻('風', List), 上三爻('天', List).
卦名('大過', List) :- 下三爻('風', List), 上三爻('澤', List).
卦名('鼎', List) :- 下三爻('風', List), 上三爻('火', List).
卦名('恒', List) :- 下三爻('風', List), 上三爻('雷', List).
卦名('巽', List) :- 下三爻('風', List), 上三爻('風', List).
卦名('井', List) :- 下三爻('風', List), 上三爻('水', List).
卦名('蠱', List) :- 下三爻('風', List), 上三爻('山', List).
卦名('升', List) :- 下三爻('風', List), 上三爻('地', List).
卦名('訟', List) :- 下三爻('水', List), 上三爻('天', List).
卦名('困', List) :- 下三爻('水', List), 上三爻('澤', List).
卦名('未濟', List) :- 下三爻('水', List), 上三爻('火', List).
卦名('解', List) :- 下三爻('水', List), 上三爻('雷', List).
卦名('渙', List) :- 下三爻('水', List), 上三爻('風', List).
卦名('坎', List) :- 下三爻('水', List), 上三爻('水', List).
卦名('蒙', List) :- 下三爻('水', List), 上三爻('山', List).
卦名('師', List) :- 下三爻('水', List), 上三爻('地', List).
卦名('遯', List) :- 下三爻('山', List), 上三爻('天', List).
卦名('咸', List) :- 下三爻('山', List), 上三爻('澤', List).
卦名('旅', List) :- 下三爻('山', List), 上三爻('火', List).
卦名('小過', List) :- 下三爻('山', List), 上三爻('雷', List).
卦名('漸', List) :- 下三爻('山', List), 上三爻('風', List).
卦名('蹇', List) :- 下三爻('山', List), 上三爻('水', List).
卦名('艮', List) :- 下三爻('山', List), 上三爻('山', List).
卦名('謙', List) :- 下三爻('山', List), 上三爻('地', List).
卦名('否', List) :- 下三爻('地', List), 上三爻('天', List).
卦名('萃', List) :- 下三爻('地', List), 上三爻('澤', List).
卦名('晉', List) :- 下三爻('地', List), 上三爻('火', List).
卦名('豫', List) :- 下三爻('地', List), 上三爻('雷', List).
卦名('觀', List) :- 下三爻('地', List), 上三爻('風', List).
卦名('比', List) :- 下三爻('地', List), 上三爻('水', List).
卦名('剝', List) :- 下三爻('地', List), 上三爻('山', List).
卦名('坤', List) :- 下三爻('地', List), 上三爻('地', List).
