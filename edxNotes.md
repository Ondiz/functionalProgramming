# Functional programming

## Introduction

* High level of abstraction
* Based on lambda calculus
* Language of choice: Haskell
* Functional programming -> expressions > statements.

Example:

```haskell
--Add the first ten numbers together
sum[1..10]
```

* Install `Hugs`, Haskell interpreter (`ghci` is another interpreter)

## First steps

* Start `hugs` in terminal

Examples:

```haskell
> head[1,2,3,4] --take first element
1
> tail[1,2,3,4] --remove first element
[2,3,4]
> [1,2,3,4] !! 2 --element #2
3
> take 3 [1,2,3,4] -- generalization of head
[1,2,3]
> drop 3 [1,2,3,4,5] --generalization of tail
[4,5]
> [1,2,3]++[4,5] --append
[1,2,3,4,5]
```
* First element in list has index 0
* List different to array -> indexing bad idea, not in constant time
  but in linear

**Function application**: function application is denoted by
  space. Higher priority
  
```haskell
f a b + c*d --f(a,b) + c d from math
f a + b --f(a) + b from math 
```
* Haskell file (script) --> `.hs`
* Define function in script, then open Hugs with script as argument so
  that functions are available. If script is changed use
  `:reload`. Also possible to load using `:load` *script*
* *Infix operator*: `x `f` y --> f x y`  
* *Naming*:
  * function and parameter name must begin with lowercase
  * can use quotes (*prime*)
  * type has to start with uppercase
  * convention --> `s` at the end means list, `ss` list of lists
* Indentation like Python, implicit grouping
* Useful commands --> `:load` *script*, `:reload`, `:edit` *script*, `:type`
  *expression*,`:?` 
* Comments: one line `--comment`, nested:

```haskell
{-
very long
comment goes
here
-}
```

## Types and classes

* **Type**: name for a collection of related values. Example `Bool`
* Applying a function to a wrong type makes a *type error*
* `e :: t` --> `e` has type `t`
* *Type inference*: compiler calculates type of expression prior to
  execution. Haskell programs are *type safe*, type error never
  happens in run time
* `:type <exp>` to calculate type of expression

| Type        | Explanation   | 
|:----------: |:-------------:|
| `Bool` | Logical value: `True` or `False`|
| `Char` | Single character, enclosed in sigle quotes: `'a'` |
| `String` | String of characters, double quotes: `"abc"`|
| `Int` | Fixed precision integer |
| `Integer` | Arbitrary precision integer, doesn't overflow |
| `Float` | Single precision floating point number |

Table: Different types in Haskell


* **List**: sequence of values with same type. Can be infinite. Examples:

```haskell
[False, True, False]::[Bool] -- list of elements type Bool
['a', 'b']:: [Char] -- list of elements type char
```

* **Tuple**: sequence of values of different type. Number of elements
  is called *arity*. Finite number of elements because type of all
  have to be calculated.  Example:

```haskell
(False, 'a') :: (Bool, Char) -- length appears in type
```

* **Function**: mapping from values of a type to values of another
type. Examples:

```haskell
not :: Bool -> Bool
isDigit :: Char -> Bool

function :: t1 -> t2 -- from domain to range in general

```

* *Curried function*: functions that return arguments one at a time
  (functions can return functions):
  `a -> (a -> a)` equivalent to `a -> a -> a`, arrow associates to the
  right. Any function that returns more than one values can be
  curried. Useful for *partially applying functions*. **Most**
  functions applied in curried form, if tuples are not explicitly declared.

* *Polymorphic function*: functions not defined for a particular
type. Example:

```haskell
length :: [a] -> Int 
```

* Price for polymorphism: type variables start with lowercase and types
with uppercase

* *Overloaded function*: functions with same name but different
  types. In Haskell overloading means that there is a restriction in
  the type class. Example:

```haskell
sum :: Num [a] => [a] -> Int -- only numeric values allowed
```

## Defining functions

### Conditional expressions

Example:

```haskell
abs :: Int -> Int
abs n = if n >=0 then n else -n
```

* Can be nested
* Conditional expressions **must** have an `else` branch

### Guarded equation:

* Sequence of logical expressions
* Alternative to conditional (Haskell people
  prefer this)

```haskell
abs n | n >= 0    = n -- |= such that
      | otherwise = -n
```

* Can be used to make definitions involving multiple conditions

### Pattern matching

```haskell
(&&) :: Bool -> Bool -> Bool
True && True = True
_    && _    = False --anything but True&&True 
```

More efficient way using wildcard + lazy evaluation:

```haskell
(&&) :: Bool -> Bool -> Bool
True  && b = b -- True && something --> something
False && _ = False -- always False
```
* Order is important
* Patterns may not repeat variables: all the variables inside the
  pattern have to be different

* *Lists in pattern matching*: use *cons* definition (`:`)[^list]. Only
  matches not empty list. These pattern must be parethesized because
  function application has higher priority.

```haskell
head :: [a ] → a
head (x : ) = x
```

[^list]: Lists are constructed one element at a time from the empty
  list using *cons operator* `[1,2,3] = 1:(2:(3:[]))= 1:2:3:[]` 

### Lambda expressions

Functions can be constructed without naming using *lambda
expressions*:

```haskell
\x -> x + x --\x = \lambda x (from lambda calculus) 
```

* Useful for currying:

```haskell
add x y = x + y
add = \x -> (\y -> x+y)
```

* For returning functions as results

* For avoiding naming functions only used once:

```haskell
odds n = map f [0..n-1]
         where
		  f x = x*2 +1

odds n = map (\x -> x*2 + 1)[0..n-1] --pass lambda as parameter to map
``` 

### Sections

Operator written between two arguments can be used in curried way
using parenthesis:

```haskell
--Examples:
(1+) --sucessor
(1/) --reciprocate
(*2) --double
(/2) --half
```

For avoiding naming. 

## List comprehensions

* Code that manipulates collections
* Favorite collection for mathematicians: **sets**. Problems with
  sets:
  * No duplication
  * Deal with equality
* Haskell has tricks to deal with sets as lists

* Set comprehensions in Math: $\lbrace x^2 | x \in \lbrace 1,...,5\rbrace\rbrace$
* List comprehension in Haskell: `[x^2 | x <- [1..5]]`
* `x <- [1..5]` is called *generator*
* Comprehensions can have multiple generators (similar to nested loop,
  x is the outer loop and y is the inner):

```haskell
> [(x,y) | x <- [1,2,3], y <- [4,5]]
> [(1,4),(1,5),(2,4),(2,5),(3,4),(3,5)]
> [(x,y) | y <- [4,5],  x <- [1,2,3]]
> [(1,4),(2,4),(3,4),(1,5),(2,5),(3,5)]
```

* Generators can depend on each other, as in loops: 

```haskell
> [(x,y) | x <- [1,2,3], y <- [x..3]]
> [(1,1),(1,2),(1,3),(2,2),(2,3),(3,3)]
```

* Very concise code
* Filters (*guards*): `[x | x <- [1..10], even x]`

### The zip function

* Combines two list to a list of pairs
* Useful when programming with list comprehensions.

```haskell
zip :: [a] -> [b]-> [(a,b)]
```

### String comprehension

* Strings = character list `[Char]`
* Everything that can be done in lists will work with strings

## Recursive functions

* *Tail call elimination*

```haskell
factorial 1 = 0
factorial n = n * factorial (n-1)
```

* Some functions are simpler to define using recursions
* *Induction* can be used to prove porperties of recursive functions
* Recursion can be used also in lists:

```haskell
product :: [Int] -> Int
product [] = 1
product (n:ns) = n * product ns
```

Note: `:` appends element to list, `++` concatenates lists

* *Quicksort*: algorithm for sorting integers. Two rules:
  * The empty list is already sorted
  * Bolzano in the rest

```haskell
qsort :: [Int] -> Int
qsort [] = []
qsort (x:xs)=
  qsort smaller ++ [x] ++ qsort larger
  where
    smaller = [a | a <- xs, a <= x]
	larger  = [b | b <- xs, b > x]
```

