double x = x *2
average ns = sum ns `div` length ns
second xs = head (tail xs)
swap (x,y) = (y,x)
pair x y = (x,y)
palindrome xs = reverse xs == xs
twice f x = f (f x)
f xs = take 3 (reverse xs)

--Defining functions 

funct x xs = take (x+1) xs ++ drop x xs
remove n xs = take n xs ++ drop (n+1) xs

halve xs = (take n xs, drop n xs)
  where n = length xs `div`2

e3 x = x*2
e4 (x,y) = x
e6 x y = x*y
e8 x y = (y,x)
e9 [x,y]=(x,True)
e10 (x,y)=[x,y]

--List comprehensions

sum100 = sum[x^2 | x <- [1..100]]
factors n = [x | x <- [1..n], n `mod` x == 0]

perfects n = [x | x <- [1..n], isPerfect x]
  where isPerfect num = sum(init(factors num)) == num

find k t = [v | (k',v) <- t, k==k']
{- busca k en una lista de tuples del tipo [(Número,Cosas)...] y
devuelve Cosas cuando k == Número
-}

positions1 x xs = [i | (x',i) <- zip xs [0..n], x ==x']
  where n = length xs -1 
--Devuelve la posición de un elemento en una lista

positions x xs = find x (zip xs [0..n])
  where n = length xs - 1

scalarproduct xs ys = sum [x*y |(x,y)<- xs `zip` ys]
--sin zip multiplica todos por todos

xs = 1:[x+1 | x <-xs]

riffle xs ys = concat [[x,y] | (x,y) <- xs `zip` ys]

divides x d = if x `mod` d == 0 then True else False

divisors x = [d | d <- [1..x], x `divides` d]

replicate1 0 _ = []
replicate1 n q = q : replicate (n-1) q

elem1 n [] = False
elem1 n xs = if n == head xs then True else elem1 n (tail xs)
