#########################################################
### Problem #1: 3 different ways to make 5 x 5 matrix.### 
#########################################################

### Method #1: 
method1<- matrix(1:25, 5, 5)
method1

method2_a <- 1:5
method2_b <- 6:10
method2_c <- 11:15
method2_d <- 16:20
method2_e <- 21:25

method2 <- as.matrix(cbind(method2_a,method2_b, method2_c, method2_d, method2_e))
colnames(method2) <- NULL
method2

method3 <- as.matrix(rbind(method2_a, method2_b,method2_c, method2_d, method2_e))
rownames(method3) <- NULL
method3

##############################################################################
### Problem 2: Find the sum of all numbers below 1000 that can be divisible ##
### by 3 or 5(Hint: Conditionals)
#############################################################################
a <- 1:1000
sum_div <- a[a%%3 ==0 | a%%5 == 0]
sum_div_total = sum(sum_div)
sum_div_total
### [1] 234168

#################################################################################
### Problem 3: Find the sum of the even valued terms of the Fibonacci sequence 
### that do not exceed 4,000,000.(Hint: refer to page 110 in our week 1 slides)
#################################################################################

###NOTE: Running this through 4,000,000 causes my computer to freeze, 
### so I'm running through 400.

fib <- numeric()
fib[1] <- fib[2] <- 1
for (i in 3:400){
  fib[i] <- fib[i-2] + fib[i-1]
}
fib_even <- fib[fib%%2 == 0]
fib_even_sum <- sum(fib_even)
fib_even_sum

############################################
### Problem 4: Prove magic square is true.##
############################################

my_mat <- matrix(c(8, 3, 4, 1, 5, 9, 6, 7, 2), ncol = 3)
my_mat

### Checking rows
apply(my_mat, 1, sum)
### [1] 15 15 15

### Checking columns
apply(my_mat, 2, sum)
### [1] 15 15 15

### Checking diagonal
(my_mat[1,1] + my_mat[2,2] + my_mat[3,3]) 
### [1] 15

### Checking counter diagonal
(my_mat[3,1] + my_mat[2,2] + my_mat[1,3]) 
### [1] 15

########################################
### Problem 5: Fix the following code:
########################################

x <-  1
if(x= 1){ cat("x is 1")
}else {
  cat("x is not 1")
}

### Fix: add second equal sign in x = 1 statement
x <-  1
if(x== 1){ cat("x is 1")
}else {
  cat("x is not 1")
}


#########################################################################
### Problem 6: Write function that calculates median absolute deviation:
#########################################################################

a <- rnorm(10)
### [1] -1.16144545  0.45966130 -2.06521499 -0.83999965 -0.28824412 -0.10920736  1.42384990  
### [8] 1.78795599  0.03400712 0.22620641

for(i in length(a)){
 # MAD=median(a[i]- median(a)|)
  MAD <- abs(median(a[i] - median(a)))
}

MAD
### [1] 0.2638065

####################################################################
### Problem 7: What is the largest prime number for 600,851,475,143.
####################################################################

### I cannot figure this out.

#########################################################################
### Problem 8: Find the largest palindrome created from 2 3-digit factors
#########################################################################
pal_function <- function(x){
  x <- as.character(x)
  forward <- unlist(strsplit(x, split = ""))
  backward <- rev(forward)
  palindrome <- all(forward == backward)
  return(palindrome)
}

a <- matrix(999:100, nrow = 1)
a <- t(a)%*%a
pal_test <- unique(sort(as.vector(x), decreasing = TRUE))
max_pal <- 000000
i <- 1
n <- length(pal_test)
while (i <= n) {
  if (pal_function(pal_test[i])) {
    result <- pal_test[i]
    print(result)
    break
  }
  i <- i + 1
  }

# [1] 906609

########################################################################
###Problem 9:
### Explain what vectorizing a function does and when it's appropriate.
########################################################################

### An un-vectorized function needs you to initialize the vectors and then
### create loops to run over each element of the vector.  A vectorized function will 
### perform the operation over every element of a vector all at once.

#############################################################################
### Write a vectorized function that will examine an input array of numbers 
### and return a logical array of whether each number is a palindrome.
#############################################################################

palindrome <- function(x){
  y <- strsplit(as.character(x), "")
  rev_y <- paste(rev(unlist(y)), collapse= "")
  x == rev_y
 }

palindrome(122221)
### [1] TRUE

palindrome(123456)
### [1] FALSE

palindrome ("pop")
### [1] TRUE

############################################################################
### Problem 10: come up with a question from the tips dataset, and show code
### and solution.
############################################################################

library(reshape2)
head(tips)
 
###Do people tip more for dinner on Sunday than Saturday?

dcast(tips,time~day, value.var = "tip", fun = mean, na.rm = TRUE)
### time      Fri      Sat      Sun     Thur
### 1 Dinner 2.940000 2.993103 3.255132 3.000000
### 2  Lunch 2.382857      NaN      NaN 2.767705

### Answer: on average, people tip approximatel $0.25 for dinner on Sunday
### than they do on Saturday.