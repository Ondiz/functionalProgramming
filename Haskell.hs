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
