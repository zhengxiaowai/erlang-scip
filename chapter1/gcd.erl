-module(gcd).
-export([test/0, gcd/2]).

test() ->
  2 = gcd(206, 40),
  test_worked.

% 最大公约数(GCD)
gcd(A, B) ->
  if 
    B == 0 -> 
      A;
    B /=0 -> 
      gcd(B, A rem B)
  end.