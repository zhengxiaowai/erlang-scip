-module(prime).
-export([test/0, direct_prime/1, fermat_prime/2]).

test() ->
  false = direct_prime(6),
  true = direct_prime(7),
  false = fermat_prime(6, 3),
  true = fermat_prime(7, 3),

  test_worked.


% 直接检测法，O(√ n)
direct_prime(N) ->
  N == find_divisor(N, 2).


% 费马小定理检测素数
fermat_prime(N, Times) ->
  if
    Times == 0 -> true;
    true ->
      case fermat_test(N) of
        true -> fermat_prime(N, Times-1);
        false -> false
      end
  end.

% 如果 n 不是素数，必然有一个小于或等于 √ n 的因子
find_divisor(N, T) ->
  if 
    T*T > N ->
      N;
    N rem T == 0 ->
      T;
    true ->
      find_divisor(N, T+1)
  end.

expmod(Base, Exp, M) ->
  IsEven = even(Exp),
  if 
    Exp == 0 -> 
      1;
    IsEven == true -> 
      square(expmod(Base, Exp div 2, M)) rem M;
    IsEven == false ->
       (Base * expmod(Base, Exp - 1, M)) rem M
  end.

fermat_test(N) when N > 1 ->
  Random = rand:uniform(N-1),
  IsPass = (expmod(Random, N, N) == Random),
  case IsPass of
    true -> true;
    false -> false
  end.


% helper functions
even(X) when X >= 0 -> (X band 1) == 0.
square(X) -> X*X.