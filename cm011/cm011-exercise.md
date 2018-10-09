cm011 Exercises: R as a programming language
================

Part I
======

Types and Modes and Classes, Oh My!
-----------------------------------

R objects have a *type*, a *mode*, and a *class*. This can be confusing:

``` r
a <- 3
print(typeof(a))
```

    ## [1] "double"

``` r
print(mode(a))
```

    ## [1] "numeric"

``` r
print(class(a))
```

    ## [1] "numeric"

``` r
print(typeof(iris))
```

    ## [1] "list"

``` r
print(mode(iris))
```

    ## [1] "list"

``` r
print(class(iris))
```

    ## [1] "data.frame"

``` r
print(typeof(sum))
```

    ## [1] "builtin"

``` r
print(mode(sum))
```

    ## [1] "function"

``` r
print(class(sum))
```

    ## [1] "function"

Usually, there's no need to fuss about these differences: just use the `is.*()` family of functions. Give it a try:

``` r
is.numeric(a)
```

    ## [1] TRUE

``` r
is.data.frame(iris)
```

    ## [1] TRUE

We can also coerce objects to take on a different form, typically using the `as.*()` family of functions. We can't always coerce! You'll get a sense of this over time, but try:

-   Coercing a number to a character.
-   Coercing a character to a number.
-   Coercing a number to a data.frame. `letters` to a data.frame.

``` r
as.character(100) ## output is a string with content 100
```

    ## [1] "100"

``` r
as.numeric("100")*2   ## output is a number  (transform a string to a number)
```

    ## [1] 200

``` r
as.data.frame(letters)
```

    ##    letters
    ## 1        a
    ## 2        b
    ## 3        c
    ## 4        d
    ## 5        e
    ## 6        f
    ## 7        g
    ## 8        h
    ## 9        i
    ## 10       j
    ## 11       k
    ## 12       l
    ## 13       m
    ## 14       n
    ## 15       o
    ## 16       p
    ## 17       q
    ## 18       r
    ## 19       s
    ## 20       t
    ## 21       u
    ## 22       v
    ## 23       w
    ## 24       x
    ## 25       y
    ## 26       z

There is also a slight difference between coercion and conversion, but this is usually not important.

Vectors
-------

Vectors store multiple entries of a data type. You'll discover that they show up just about everywhere in R, so they're fundamental and extremely important.

### Vector Construction and Basic Subsetting

We've seen vectors as columns of data frames:

``` r
mtcars$hp     ## all the horsepower of the car in the hp column
```

    ##  [1] 110 110  93 110 175 105 245  62  95 123 123 180 180 180 205 215 230
    ## [18]  66  52  65  97 150 150 245 175  66  91 113 264 175 335 109

Use the `c()` function to make a vector consisting of the course code (`"STAT"` and `545`). Notice the coercion. Vectors must be homogeneous.

``` r
(course <- c("STAT",545)) ## IT CAN ONLY HOLD ONE TYPE OF INFORMATION, so in this case the 545 is becaome a character (string) now.
```

    ## [1] "STAT" "545"

Subset the first entry. Remove the first entry. Note the base-1 system.

``` r
course[1]   ## it starts from 1 not 0 in r.
```

    ## [1] "STAT"

``` r
course[-1]    ## means return the vector with the entry 1 removed
```

    ## [1] "545"

``` r
course
```

    ## [1] "STAT" "545"

``` r
sort(course)[1]   ## since after sort the entry 545 is the first entry
```

    ## [1] "545"

Use `<-` to change the second entry to "545A". Using the same approach, add a third entry, "S01".

``` r
course[2] <- "545A"
course[3] <- "501"
course
```

    ## [1] "STAT" "545A" "501"

Subset the first and third entry. Order matters! Subset the third and first entry.

``` r
course[c(3,1)]  ## thrid entry followed by the first entry and the output is still a vector
```

    ## [1] "501"  "STAT"

Explore integer sequences, especially negatives and directions. Especially `1:0` that might show up in loops!

``` r
3:10
```

    ## [1]  3  4  5  6  7  8  9 10

``` r
10:-5
```

    ##  [1] 10  9  8  7  6  5  4  3  2  1  0 -1 -2 -3 -4 -5

``` r
1:0
```

    ## [1] 1 0

``` r
# vector of length 0:
seq_len(0)
```

    ## integer(0)

``` r
seq_len(10) # make a vector staring from 1 and up to 10 
```

    ##  [1]  1  2  3  4  5  6  7  8  9 10

Singletons are also vectors. Check using `is.vector`.

``` r
is.vector(6) # a single entry is also a vector
```

    ## [1] TRUE

``` r
a[1][1]
```

    ## [1] 3

``` r
v1 <- "hi"
v2 <- "you"
length(v1)
```

    ## [1] 1

``` r
paste(v1,v2)
```

    ## [1] "hi you"

``` r
# string is a single object indicate with the quotation mark (string=character) , and vector is a sequence of objects.
```

### Vectorization and Recycling

A key aspect of R is its vectorization. Let's work with the vector following vector:

``` r
(a <- 7:-2)
```

    ##  [1]  7  6  5  4  3  2  1  0 -1 -2

``` r
(n <- length(a))
```

    ## [1] 10

Square each component:

``` r
a^2  ## vector operation  (vectorization)
```

    ##  [1] 49 36 25 16  9  4  1  0  1  4

Multiply each component by 1 through its length:

``` r
a * 1:10  # 7*1  6*2  5*3....
```

    ##  [1]   7  12  15  16  15  12   7   0  -9 -20

``` r
# multiple RHS vector and LHS vector (component wise operation)
```

It's important to know that R will silently recycle! Unless the length of one vector is not divisible by the other. Let's see:

``` r
a* 1:3  # it takes the shorter vector automatically repeat it until it match the length of the longer vector.
```

    ## Warning in a * 1:3: ³¤µÄ¶ÔÏó³¤¶È²»ÊÇ¶ÌµÄ¶ÔÏó³¤¶ÈµÄÕû±¶Êý

    ##  [1]  7 12 15  4  6  6  1  0 -3 -2

``` r
a*1:2
```

    ##  [1]  7 12  5  8  3  4  1  0 -1 -4

This is true of comparison operators, too. Make a vector of logicals using a comparison operator.

``` r
a>0
```

    ##  [1]  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE FALSE FALSE FALSE

Now try a boolean operator. Note that && and || are NOT vectorized!

``` r
a > 0 & a < 5
```

    ##  [1] FALSE FALSE FALSE  TRUE  TRUE  TRUE  TRUE FALSE FALSE FALSE

``` r
a > 0 && a < 5   ## this is not vector-wise to compare it 
```

    ## [1] FALSE

``` r
any(a>0 & a<5)  ## any a satisfy this condition?
```

    ## [1] TRUE

``` r
all(a>0 & a<5)  ## all a stisfy this condition?
```

    ## [1] FALSE

Recycling works with assignment, too. Replace the entire vector a with 1:2 repeated:

``` r
a[1:n] <- 1:2   ## create a new vector of length 10 and repeat with 1 and 2.
a
```

    ##  [1] 1 2 1 2 1 2 1 2 1 2

### Special Subsetting

We can subset vectors by names and logicals, too.

Recall the course vector:

``` r
course <- c("STAT", "545A", "S01")
```

Let's give the components some names ("subject", "code", and "section") using three methods:

1.  Using the setNames function.

-   Notice that the vector does not change!!

``` r
setNames(course, c("subject","code","section")) ## set the name for the vector
```

    ## subject    code section 
    ##  "STAT"  "545A"   "S01"

``` r
course  ## function in R dont change subject so the course is not changed by the above function.
```

    ## [1] "STAT" "545A" "S01"

1.  Using the names function with `<-`. Also, just explore the names function.

``` r
names(course) <- c("subject","code","section") ## this will change the course
course
```

    ## subject    code section 
    ##  "STAT"  "545A"   "S01"

``` r
names(course)
```

    ## [1] "subject" "code"    "section"

1.  Re-constructing the vector, specifying names within `c()`.

``` r
course <- c(subject = "STAT", code = "545A", section ="S01")
course
```

    ## subject    code section 
    ##  "STAT"  "545A"   "S01"

``` r
# this will overwrite the course subject.
```

Subset the entry labelled "section" and "subject".

``` r
course["section"]  # this is the way to subsetting by name instead of index
```

    ## section 
    ##   "S01"

``` r
course[["section"]] # this will only returning that entry without the name.
```

    ## [1] "S01"

``` r
course[c("section","code")]
```

    ## section    code 
    ##   "S01"  "545A"

``` r
foo <- c(a=5 ,b=5, a=7)

foo[["a"]]  ## only return the first a not the second a.
```

    ## [1] 5

Amazingly, we can also subset by a vector of logicals (which will be recycled!). Let's work with our integer sequence vector again:

``` r
(a <- 7:-2)
```

    ##  [1]  7  6  5  4  3  2  1  0 -1 -2

``` r
(n <- length(a))
```

    ## [1] 10

``` r
a[a>0 & a!=4]  ## if there is a true (a>0) it will return the entry. if there is a false, the correponding entry will not be returned. 
```

    ## [1] 7 6 5 3 2 1

Lists
-----

Unlike vectors, which are atomic/homogeneous, a list in R is heterogeneous.

Try storing the course code (`"STAT"` and `545`) again, but this time in a list. Use the `list()` function.

``` r
(course <-  list("STAT",545))   ## It didnt change 545 into character.
```

    ## [[1]]
    ## [1] "STAT"
    ## 
    ## [[2]]
    ## [1] 545

``` r
# it create 2 vector and each of them has a length of 1. 
```

Lists can hold pretty much anything, and can also be named. Let's use the following list:

``` r
(my_list <- list(year=2018, instructor=c("Vincenzo", "Coia"), fav_fun=typeof))
```

    ## $year
    ## [1] 2018
    ## 
    ## $instructor
    ## [1] "Vincenzo" "Coia"    
    ## 
    ## $fav_fun
    ## function (x) 
    ## .Internal(typeof(x))
    ## <bytecode: 0x0000000016df2f40>
    ## <environment: namespace:base>

``` r
# three entries
```

Subsetting a list works similarly to vectors. Try subsetting the first element of `my_list`; try subsettig the first *component* of the list. Notice the difference!

``` r
my_list[1]
```

    ## $year
    ## [1] 2018

``` r
my_list[[1]]  ## just give me the content of the first entry
```

    ## [1] 2018

``` r
my_list[2]
```

    ## $instructor
    ## [1] "Vincenzo" "Coia"

``` r
my_list[[2]]
```

    ## [1] "Vincenzo" "Coia"

Try also subsetting by name:

``` r
my_list["year"]
```

    ## $year
    ## [1] 2018

``` r
my_list[["year"]]
```

    ## [1] 2018

``` r
my_list$year
```

    ## [1] 2018

Smells a little like `data.frame`s. It turns out a `data.frame` is a special type of list:

``` r
(small_df <- tibble::tibble(x=1:5, y=letters[1:5]))
```

    ## # A tibble: 5 x 2
    ##       x y    
    ##   <int> <chr>
    ## 1     1 a    
    ## 2     2 b    
    ## 3     3 c    
    ## 4     4 d    
    ## 5     5 e

``` r
is.list(small_df)  
```

    ## [1] TRUE

``` r
as.list(small_df)  ## return the column of the dataframe
```

    ## $x
    ## [1] 1 2 3 4 5
    ## 
    ## $y
    ## [1] "a" "b" "c" "d" "e"

``` r
# in dataframe, each column can have its unique type such as character or numeric. (since vector must contain the same data type)
#mateix:
diag(5) # every element need to be the same data type
```

    ##      [,1] [,2] [,3] [,4] [,5]
    ## [1,]    1    0    0    0    0
    ## [2,]    0    1    0    0    0
    ## [3,]    0    0    1    0    0
    ## [4,]    0    0    0    1    0
    ## [5,]    0    0    0    0    1

Note that there's a difference between a list of one object, and that object itself! This is different from vectors.

``` r
identical(list(4), 4)
```

    ## [1] FALSE

``` r
identical(c(4), 4)
```

    ## [1] TRUE

Part II
=======

Global Environment
------------------

When you assign variables in R, the variable name and contents are stored in an R environment called a global environment.

See what's in the Global Environment by:

-   Executing `ls()`.
-   Looking in RStudio, in the "Environments" pane.

Making an assignment "binds" an object to a name within an environment. For example, writing `a <- 5` assigns the object `5` to the name `a` in the global environment.

The act of "searching for the right object to return" is called scoping.

By the way: the global environment is an object, too! It's the output of `globalenv()`, and is also stored in the variable `.GlobalEnv`:

``` r
globalenv()
```

    ## <environment: R_GlobalEnv>

``` r
.GlobalEnv
```

    ## <environment: R_GlobalEnv>

The Search Path
---------------

How does R know what `iris` is, yet `iris` does not appear in the global environment? What about functions like `length`, `sum`, and `print` (which are all objects, too)?

Let's explore.

1.  Each package has its own environment.
    -   Install and load the `pryr` package, and use `ls()` to list its bindings (its name is "package:pryr").
2.  There's a difference between an *environment* and its *name*. Get the environment with name "package:pryr" using the `as.environment()` function.

3.  Each environment has a parent. Use `parent.env()` to find the parent of the global environment.

4.  There are packages that come pre-loaded with R, and they're loaded in a sequence called the search path. Use `search()` to identify that path; then see it in RStudio.

First scoping rule: R looks to the parent environment if it can't find an object where it is.

1.  Use `pryr::where()` to determine where the first binding to the name `iris` is located.

2.  Override `iris` with, say, a numeric. Now `where()` is it? Can you extract the original?

3.  Override `sum` with, say, a numeric. `where()` is `sum` now? Can you still use the original `sum()` function?

Special scoping rule for functions! R knows whether or not to look for a function.

1.  Look at the source code of the `pryr:where()` function. It contains a line that creates a binding for "env". Why, then, is `env` nowhere to be found? Answer: execution environments.

``` r
 # pryr::where
```
