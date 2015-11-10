double x = x *2
average ns = sum ns `div` length ns
second xs = head (tail xs)
swap (x,y) = (y,x)
pair x y = (x,y)
palindrome xs = reverse xs == xs
twice f x = f (f x)
f xs = take 3 (reverse xs)
