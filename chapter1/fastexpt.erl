-module(fastexpt).
-export([fastexpt/2, test/0]).

test() ->
    1 = fastexpt(2, 0),
    2 = fastexpt(2, 1),
    4 = fastexpt(2, 2),
    8 = fastexpt(2, 3),

    0 = multi(2, 0),
    2 = multi(2, 1),
    4 = multi(2, 2),
    6 = multi(2, 3),

    0 = mul(2, 0),
    2 = mul(2, 1),
    4 = mul(2, 2),
    6 = mul(2, 3),
    test_worked.

mul(A, B) -> mul(A, B, 0).
mul(A, B, R) -> 
    IsEven = even(B),
    if
        B == 0 -> R;
        IsEven == true -> mul(double(A), halve(B), R);
        IsEven == false -> mul(A, B-1, A+R)
    end.


multi(A, B) ->
    IsEven = even(B),
    if 
        B == 0 -> 
            0;
        IsEven == true -> 
            double(multi(A, halve(B)));
        IsEven == false -> 
            A + multi(A, B-1)
    end.

fastexpt(B, N) ->
    fastexpt(B, N, 1).
         
fastexpt(B, N, A) ->
    IsEven = even(N),
    IsOdd = odd(N),
    if 
        N == 0 ->
            A;
        IsEven == true ->
            fastexpt(B*B, N div 2, A);
        IsOdd == true ->
            fastexpt(B, N-1, A*B)
    end.

even(X) when X >= 0 -> (X band 1) == 0.
odd(X) when X >= 0 -> not even(X).
double(X) -> X + X.
halve(X) -> X div 2.