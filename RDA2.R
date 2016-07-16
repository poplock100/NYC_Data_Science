###### RDA Week2 ########

# Atomic Object: Vectors --------------------------------------------------

# Again, each atomic vector stores its values as a one-dimensional vector, 
# and each atomic vector can only store one type of data. 

##############################
# Different types of vectors # 
##############################

# R recognizes basic types of atomic vectors:
# integer, numeric, character, logical, or complex type.

# 1.Double:
# A double vector stores regular numbers
double <- c(1, 2, 4)
double
typeof(double)

# 2.Integer:
# Integer vectors store integers, numbers that can be written without a decimal component
int <- c(1L, 2L, 4L)
int
typeof(int)

# Q: Check the environment tab and the results of typeof(), 
#    Why the types of int and double are different, while they seems contains same numbers?
{
  # A: Note that R wont save a number as an integer unless you include the L. Integer numbers
  #    without the L will be saved as doubles. 
  #    The only difference between 4 and 4L is how R saves the number in your computers memory. 
  #    Integers are defined more precisely in your computers memory than doubles (unless the integer is very large or small).
  #    Factors are always stored as integers.
}

# 3. Characters
# A character vector stores small pieces of text.
text <- c("Hello", "World")
text
typeof(text)

# 4. Logicals
# Logical vectors store TRUEs and FALSEs, Rs form of Boolean data.
# Logicals are very helpful for doing things like comparisons
logic<-1:3>=3:1
# Note:
{
  1:3
  3:1
  1:3>=3:1
}
logic
typeof(logic)

# Exercise
# Can you spot the difference between a character string and a number? Heres a test:
# Which of these are character strings and which are numbers? 1, "1", "one"
{
  # A: "1" and "one" are both character strings. Character strings can contain number char
  #   acters, but that doesnt make them numeric. Theyre just strings that happen to have
  #   numbers in them. You can tell strings from real numbers because strings come sur
  #   rounded by quotes. In fact, anything surrounded by quotes in R will be treated as a
  #   character stringno matter what appears between the quotes.
}

#####################
# Create sequences # 
####################


# 1. Use seq() to create a vector of sequential values.
vector1 = seq(2, 10, by=2) # matches 'end'
vector = seq(2, 10, by=3) # stays below 'end'

vector2 = 1:10 + 2
vector3 = 1:(10 + 2)

# Q: Give two ways to create a sequence of integer from 98 to 123
{
  # A: 1. 98:123
  #    2. seq(98,123)
}

# why we need to learn sequence? 
# Example:
# Use the seq() function and numerical integration to approximate the area 
# under the sine function from 0 to pi.
# https://mathman.biz/html/katysine.html
n = 100
w = pi/n
x = seq(from = 0, to = pi, length = n)
rect = sin(x) * w
sum(rect)

# 2. Use rep() to create a vector replicating from a pattern.
group1 = rep(1:3, times=c(8, 10, 9))
group2 = factor(group1) # make the number as a labor
class(group1)
class(group2)

# why we need to learn rep()? 
# Example:
# ???score??? is the student individual grades and 
# ???group??? is which groups the student is in. 
# The first element of the vector ???score??? corresponds to the first element of vector ???group??? (and so on).
### group: 1,1,1,1,2,2,2,2,2,3,3,3
### score: 100,92,75,82,NA,90,72,98,60,78,93,67
# As a teacher, you may want to put students' scores and group number together.
{# A:
  group <- rep(1:3,times=c(4,5,3))
  score <- c(100,92,75,82,NA,90,72,98,60,78,93,67)
  class <- data.frame(group,score)
  group<-as.factor(group)
  class(group)
  table(class)
  
  tapply(class$score,class$group,function(x) mean(x,na.rm = T))
}

# Vector Generation: What's the types of the vectors?
set.seed(0)
vec_logic = c(TRUE, TRUE, TRUE, FALSE)
vec_char = c('A', 'B', 'C', 'D') 
vec_num1 = runif(5) # The Uniform Distribution
vec_char2 = sample(1:20, size=10, replace=F)
vec_num2 = numeric(10) #10-item zero vector 
vec_logic; 
vec_char2; vec_num2

# Example:
# Suppose we want to remove the maximum and minimum values 
# and then take the mean manually.
set.seed(0)
vector = rnorm(10)
vec_max = max(vector)
vec_min = min(vector)
vector_trimmed = vector[vector < vec_max & vector > vec_min]
vec_mean = mean(vector_trimmed)
vec_mean

# Matrices ----------------------------------------------------------------

#####################
#  Create Matrix   # 
####################

# 1. using matrix()
# create a vector first 
vector = 1:12
#A direct method of creating a matrix uses the matrix() function.
my_matrix = matrix(1:12, nrow = 3, ncol = 4, byrow = T) #Default.
my_matrix
# Q: What if we let byrow=T?
{
  # A: my_matrix1 = matrix(vector, nrow = 3, ncol = 4, byrow = T) 
  #    my_matrix1
}

# You may notice we used matrix() to make a vector into a matrix
# What's the relationship between matrics and vectors?
# This example is meant to illustrate the point that a matrix is simply an atomic vector with a dimension attribute.
vector = 1:12
dim(vector)
# Note:
{
  # Since my_vector is a vector, it doesn't have a `dim` attribute, 
  # since it doesnt have rows and columns (so it's just NULL), but we can find its length using the length() function.
}
dim(vector) = c(4, 3)
# Note:
{
  # It's okay if that last command seemed a little strange to you. 
  # It should! The dim() function allows you to get OR set the `dim` attribute for an R object. 
  # In this case, we assigned the value c(4,3) to the `dim` attribute of my_vector.
}
vector

# 2. Using cbind() or rbind()
# The function cbind() can be used to create a matrix by stacking column vectors.
set.seed(0)
vector1 = vector2 = vector3 = rnorm(3)
my_matrix = cbind(vector2, vector1, vector3)
vector1
my_matrix
# Q: What do you think cbind() and rbind () mean?
{
  # A: cbind() means Combine R Objects by Columns
  #    rbind() means Combine R Objects by Rows
}

# Matrix Degradation
# Extract a subset of a matrix
my_mat = matrix(1:9,3,3)
my_mat
my_mat[1:2, ]
# Note:
{
  # Just like in math class,
  # when dealing with a 2-dimensional object (think rectangular table), 
  # the first number is the number of rows and the second is the number of columns.
}

# Arrays -------------------------------------------------------------------
# An array is a multidimensional vector. 

a = array(1:8, dim = c(2,2,3,2))
a
a[,,1]

# Data Frames -------------------------------------------------------------

# Creating a data frame of temperatures in different cities:
city = c('Seattle', 'Chicago', 'Boston', 'Houston')
temp = c(78, 74, 50, 104)
data = data.frame(city, temp)

# What if we only want to use one of the columns, for example city?
# Here are three different ways we can extract the city column:
data[ ,1]
data[ ,'city']
data$city

# Converting variables to factors:
data = data.frame(city, temp, stringsAsFactors = F)
data$city = factor(data$city)
# Note:
{# Why we need factors?
  # http://www.stat.berkeley.edu/~s133/factors.html
}

# To find the cities with higher than average temperature:
ave = mean(data$temp)
data[data$temp > ave, 1]

# The following functions are useful to understand the data structure you're working with.
data = data.frame(city, temp)

# 1. summary()
summary(data)
# 2. dim()
dim(data)
# 3. head()
head(data)
# 4. str()
str(data)

# Sorting data frames:
# Sort the whole data frame by temperature (from low to high).
order(data$temp)
data[order(data$temp), 1]

# Q:How to get the top 2 hottest cities?
{
  data[order(data$temp, decreasing=TRUE), ][1:2, ]
  order(data$temp, decreasing=TRUE)
  data1<-data[order(data$temp, decreasing=TRUE), ]  
  data1[1:2,]
}
# Q: How do you interpret the code above?
{
  # A: order(data$temp, decreasing=TRUE) ordered the observation by temp 
  #    data[] reorder the data frame by the result of order(data$temp, decreasing=TRUE)
  #    [1:2,] select first 2 rows and all the columns
}

# Missing and Null Values -------------------------------------------------
# When doing data analysis, you will often encounter data loss situations.
# 1. NA
# Missing data in R is generally expressed as NA.
temp = c(27, 29, 23, 14, NA)
mean(temp)
mean(temp, na.rm=TRUE)
# Q: What does na.rm mean?
{
  # A: a logical value indicating whether NA values should be stripped before the computation proceeds.
}

# 2. NULL
# A missing value means that the data exists but we don't know the value. 
# This is different from the value NULL.
temp = c(27, 29, 23, 14, NULL)
mean(temp)
length(temp)

# NULL can sometimes be used to facilitate the REMOVAL of an element of a complex object, 
# such as deleting an element from the previously defined people.list object.
data$temp=NULL
people.list$tabular.data = NULL

data1
data$temp=NA

# Applying Functions to Data ----------------------------------------------


# "Apply" functions keep you from having to write loops to 
# perform some operation on every row or every column of a matrix or data frame, 
# or on every element in a list.

# Some resources:
{
  # https://nsaunders.wordpress.com/2010/08/20/a-brief-introduction-to-apply-in-r/
  # https://www.datacamp.com/community/tutorials/r-tutorial-apply-family
  # http://www.r-bloggers.com/apply-lapply-rapply-sapply-functions-in-r/
}
iris
View(iris)
# suppose we want to know the mean and standard deviance of 
# sepal.Length Sepal.Width Petal.Length Petal.Width for different irises. 
# 1. sapply() 
#    The sapply() function can take a data frame as an input (or selected samples from a data frame),
#    and apply a function as specified in the second argument.
sapply(iris[,1:4], function(x) sd(x)/mean(x)) # by column

mea<-sapply(iris[,1:4],function(x) mean(x))
sd2<-sapply(iris[,1:4],function(x) sd(x))
sd2/mean

mean1<-sapply(iris[,1:4],mean)
sd1<-sapply(iris[,1:4],sd)
sd1/mean1

# sapply can also operate on lists:
mylist = as.list(iris[ ,1:4])
class(sapply(mylist, mean))

# 2.lapply()
#    The lapply() function is similar to sapply 
#    but it returns the values in list form.

class(lapply(mylist, mean))

# Sometimes we want to convert the results of lapply to a more convenient format.

myfunc = function(x) {
  ret = c(mean(x), sd(x))
  return(ret)
}
result = lapply(mylist, myfunc)
result

# Then, we can convert the result list to a matrix as follows:
result.matrix = t(as.data.frame(result))
colnames(result.matrix) = c("mean", "sd")
result.matrix

# 3. apply()
#    apply() allows for convenient manipulation of matrices.
#    and it offers one more option: Applying across rows or columns?

set.seed(1)
vec = round(runif(12) * 100)
mat = matrix(vec, 3, 4)
apply(mat, 1, sum) #Applying across the rows.
sum(mat[1,])

apply(mat, 2, function(x) max(x)-min(x)) #Applying across the columns.

# 4. tapply()
#    tapply() is useful when you want to apply a function to different subgroups.
tapply(X = iris$Sepal.Length, INDEX=list(iris$Species), FUN=mean)
# Another way to simplify
with(iris, tapply(X = c("Sepal.Length","Sepal.Width"), INDEX=list(Species), FUN=mean))

# There are other ways to do the same operation. aggregate is one such option.
with(iris, aggregate(Sepal.Length, by = list(Species), mean))

# Conditionals------------------------------------------------------
# Typically, R code execution is performed sequentially by rows of text,
# but in order to perform more complex tasks we can execute code conditionally:

# Here is the problem: How to test if a number is odd or even?
# 1. if()
num = 5
if (num %% 2 != 0) {
  cat(num, 'is odd')
}

# Q :If this is true, do that. In R, you would say:
{
  # A:
  if (this) {
    that
  }
}

# A simple if is sufficient if we only need to check one logical;
# however, if our control flow is a more complex tree, 
# we must incorporate else statements for multiple branches.

num = 7
if (num %% 2 != 0) {
  cat(num, 'is odd')
} else {
  cat(num, 'is even')
}
# Q:If this is true, do plan A; else do plan B. In R, you would say:
{
  # A:
  if (this) {
    Plan A
  } else {
    Plan B
  }
}

# For MORE THAN TWO conditional branches, multiple if-else statements are necessary.

if (num %% 2 != 0) {
  cat(num, 'is odd')
} else if (num == 0) {
  cat(num, 'is even, although many people do not realize it.')
} else {
  cat(num, 'is even')
}

# Q: If this is true, do plan A; else if that is true, do plan c; otherwise do plan C. 
#    In R, you would say:
{
  # A:
  if (this) {
    Plan A
  } else if (that) {
    Plan B
  } else {
    Plan C
  }
}

# Multiple Conditionals ---------------------------------------------------
# If we want to run a conditional on a VECTOR, 
# we can use the function ifelse().
num = 1:6
check_result<-ifelse(num %% 2 == 0, 'even', 'odd')

# Q: If this is true, do plan A; else do plan B. In R, you would say:
{
  # A:  ifelse(this,Plan A,Plan B)
}

# This ifelse structure can also be nested to evaluate multiple conditions:
set.seed(0)
age = sample(0:100, 20, replace=TRUE)
res = ifelse(age > 70, 'old', ifelse(age <= 30, 'young', 'mid'))
res

# Q: If this is true, do plan A; else if that is true, do plan c; otherwise do plan C. 
#    In R, you would say:
{
  # A: ifelse(this,Plan A,ifelse(that,Plan B,Plan C))
}

# If you have many conditions, you might want to consider the switch() function. 
# We choose one observation 
age[1]
# Bulid rules: 0-30 young 30-70 middle 70-100 old 
age_group = cut(age, breaks=c(0,30,70,100), labels=FALSE) #Returns integers.
age_group # cut the whole vector and put them into different categories
# Now, using switch to find which category the first observation should belong to
switch(age_group[2], 'young', 'middle', 'old')

# When the first parameter to switch is a string and not an integer, 
# the function returns the value assigned to the matched string in the arguments that follow. 
# For example, the following is the inverse of what we just did by assigning categories to ages.
age_type = 'middle'
switch(age_type,
       young = age[age <= 30],
       middle = age[age <= 70 & age > 30]  ,
       old = age[age > 70]
)

# Q: What's going on here?
{
  # A: We selected different observations and put them into different vectors
  # Then when we want specific age_type, it will return the observations in that category.
}

# A Practical Case 
campaign_data = read.csv('data/campaign_contributions.csv', header=TRUE)
campaign_data = campaign_data[campaign_data$AMNT > 0, ] # Amount > 0

summary(campaign_data$AMNT)
str(campaign_data$CANDID)

# Example:
# We'll base our categories on the overall quantiles and 
# then write a simple switch statement to tell us 
# the percentage of a candidate's contributions that fit into a specified category.

id = "BB"  #Bloomberg.
size = "silver"
data = campaign_data[campaign_data$CANDID == id, ]
switch(size,
       "bronze" = nrow(data[data$AMNT <= 50, ])/nrow(data),
       "silver" = nrow(data[data$AMNT <= 250 & data$AMNT > 50, ])/nrow(data),
       "gold" = nrow(data[data$AMNT <= 500 & data$AMNT > 250, ])/nrow(data),
       "platinum" = nrow(data[data$AMNT > 500, ])/nrow(data)
)

# Loops -------------------------------------------------------------------
# Loops can be used to repeatedly run a piece of code.
sign_data = read.csv('data/TimesSquareSignage.csv', header=TRUE)
obs = nrow(sign_data)
var = ncol(sign_data)
# In this case, we will use loops to help us to 
# check missing values and report their positions.
# 1. for loop
for (i in 1:obs) {
  if (is.na(sign_data$Width[i])) {
    cat('WARNING: Missing width for sign no.', i, '\n')
  }
}

# Q :Do this for every value of that. In R, you would say:
{
  # A:
  for (value in that) {
    this
  }
}

# 2. while loop
# A while loop reruns a chunk while a certain condition remains TRUE. 
i = 1
while (i <= obs) {
  if (is.na(sign_data$Width[i])) {
    cat('WARNING: Missing width for sign no.', i, '\n')
  }
  i = i + 1
}

# Q :Do this while that remains TRUE. In R, you would say:
{
  # A:
  while (that) {
    this
  }
}

# for loop vs. while loop

# Note:
{
  # The advantage of the while loop vs. the for loop is that in some situations 
  # the number of times you want to run the loop is conditional on some other value.
}

# For example, maybe we only want to print out the first few warnings.
i = 1
nas = which(is.na(sign_data$Width))
while (i < 6) {
  cat('WARNING: Missing width for sign no.', nas[i], '\n')
  i = i + 1
  if (i > 5) {
    cat('WARNING: Turned up more than 5 missing values')
  }
}

# 3. repeat loop

i = 1
j = 1
repeat {
  if (is.na(sign_data$Width[i])) {
    cat('WARNING: Missing width for sign no.', i, '\n')
    j = j + 1
  }
  if (j > 5) {
    cat('WARNING: Encountered more than 5 missing values')
    break
  }
  i = i + 1
  if (i > nrow(sign_data)) {
    break
  }
}
# Q: How to stop a repeat loop?
{
  # A: They will repeat a chunk of code until you tell them to stop (by hitting Escape) 
  #    or until they encounter the command break, which will stop the loop.
}

# Loop Efficiency ---------------------------------------------------------
findprime = function(x) {
  if (x %in% c(2, 3, 5, 7)) return(TRUE)
  if (x %% 2 == 0 | x == 1) return(FALSE)
  xsqrt = round(sqrt(x))
  xseq = seq(from = 3, to = xsqrt, by = 2)
  if (all(x %% xseq != 0)) return(TRUE)
  else return(FALSE)
}

# We now compare the speeds of three methods using the system.time function:
# 1. for loop + empty vector 
system.time({
  x1 = c()
  for (i in 1:1e4) {
    y = findprime(i)
    x1[i] = y
  }
})

# 2. for loop + empty vector (limited size)
system.time({
  x2 = logical(1e4)
  for (i in 1:1e4) {
    y = findprime(i)
    x2[i] = y
  }
})

# 3. apply function
system.time({
  sapply(1:1e4, findprime)
})

# When to Use (Explicit) Loops

i = 2
x = 1:2
while (x[i] < 1e3) {
  x [i+1] = x[i-1] + x[i]
  i = i + 1
}
x = x[-i]
print(x)

# Functions ---------------------------------------------------------------
# 1.
# Q: To calculate the area of a circle with radius r=4,6,8
{
  r<-seq(4,8,by=2) 
  r^2*pi 
  
  # You can type in area=pi*r^2 everytime you got a new r.
  # Or you can create a function to calculate the area of a circle with radius r:
  calc_area = function(r) {
    area = pi*r^2
    return(area)
  }
  calc_area(4)
  calc_area(6)
  calc_area(8)
}

# Another example:
# Here we have a custom function to convert degrees to radians.
DegreesToRadians = function(d) {
  valueInRadians = d * pi / 180
  return(valueInRadians)
}
DegreesToRadians(145)

# 2.Multiple parameters
# For more complicated functions we can introduce multiple parameters. 
# For example, the following function calculates the volume of a cone based on two input arguments: 
# its radius and its height.

ConeVolume = function(r, h) {
  volume = pi * r^2 * (h / 3)
  return(volume)
}
ConeVolume(2, 5)

# 3. Specify default parameters
# R functions also allow you to specify default parameters
SDcalc = function(x, type='sample') {
  n = length(x)
  mu = mean(x)
  if (type == 'sample') {
    stdev = sqrt(sum((x-mu)^2)/(n-1))
  }
  if (type == 'population') {
    stdev = sqrt(sum((x-mu)^2)/(n))
  }
  return(stdev)
}
SDcalc(1:10)
SDcalc(1:10, type='population')

# 4. Checking input manually
# There is no built-in safety for function arguments. 
# You must do the checking manually
SDcalc = function(x, type = 'sample') {
  stopifnot(is.numeric(x), length(x) > 0,
            type %in% c('sample', 'population')) # Check the input manually
  x = x[!is.na(x)]
  n = length(x)
  mu = mean(x)
  if (type == 'sample') {
    stdev = sqrt(sum((x-mu)^2)/(n-1))
  }
  if (type == 'population') {
    stdev = sqrt(sum((x-mu)^2)/(n))
  }
  return(stdev)
}

# 5. Handle other situations
# What if our input has NAs, or we need to transform it in some way prior to calculating the standard deviation?
# There is a special parameter '...', which gives us access to embedded function parameters.
SDcalc = function(x, type = 'sample', ...) {
  stopifnot(is.numeric(x), length(x) > 0,
            type %in% c('sample', 'population'))
  n = length(x)
  mu = mean(x, ...)
  if (type == 'sample') {
    stdev = sqrt(sum((x-mu)^2, ...)/(n-1))
  }
  if (type == 'population') {
    stdev = sqrt(sum((x-mu)^2, ...)/(n))
  }
  return(stdev)
}

test=c("A","m")
test = c(1:10, NA)
SDcalc(test, type='sample')
SDcalc(test,type="Amy")
SDcalc(test, type='sample', na.rm=TRUE)

# Recursion ---------------------------------------------------------------
# Recursion is a technique by which a function calls itself. 
# An intuitive way to define a function that calculates a factorial is the following:

Fac1 = function(n) {
  if (n == 0) return(1)
  return(n * Fac1(n-1))
}
Fac1(10)

#Compare the recursive definition with this one:
Fac2 = function(n) {
  if (n == 0) {
    return(1)
  } else {
    res = n
    while (n > 1) {
      res = res * (n - 1)
      n = n - 1
    }
  }
  return(res)
}
Fac2(10)

# Function Input ----------------------------------------------------------
# Let's first write a function which divides people into generations by birth year.
which_generation = function(birth_year) {
  if (birth_year > 2000) {
    category = 'Gen Z'
  } else if (birth_year > 1985) {
    category = 'Gen Y'
  } else if (birth_year > 1965) {
    category = 'Gen X'
  } else {
    category = 'Baby Boomer'
  }
  return(category)
}

#First test on a single birth year
which_generation(1989)

#Now with a set of birth years
years = c(1950, 1973, 1990, 2005)
which_generation(years)

# Note: The type of object input to a function matters. 
#       In this case we want to handle vector input. 
#       Some functions can be vectorized to accomplish this.
which_generation = Vectorize(which_generation)
which_generation(years)

# Functions: Creating Custom Operators ------------------------------------
# You can create your own binary operators with the same function procedure.

# We can define a set operator to find the intersection of two sets:
a <- c('NPR', 'New York Times', 'MSNBC')
b <- c('Wall Street Journal', 'NPR', 'Fox News')

'%int%' = function(x, y) {
  intersect(x, y)
}
a %int% b

# Binary operators only accept two arguments. 
# You can either chain them together or use Reduce():
c = c('Salon', 'The Onion', 'NPR')
a %int% b %int% c %int% d

d= c('Sa', 'Theon', 'NPR')
news_list = list(a, b,c,d)
Reduce('%int%', news_list)

<-  "alt(option)"+ "-"

# Data Transformation Overview --------------------------------------------
iris
# Q:How can we get "Petal.Length" and "Petal.Width" of iris setosas
# Three different ways to do the exact same thing!
data_sub = iris[iris$Species=='setosa', 3:5]
data_sub1 = subset(iris, Species=='setosa', 3:5)
data_sub2 = with(iris, iris[Species=='setosa', 3:5])

head(data_sub, 1); head(data_sub1, 1); head(data_sub2, 1)

# Q: How to add one column log(Sepal.Length) to the original dataset
# 1. Using transform()
iris_tr = transform(iris, v1=log(Sepal.Length))
head(iris_tr, 1)

# 2. Using $ directly
iris_tr1 = iris
iris_tr1$v1 = log(iris$Sepal.Length)
head(iris_tr1, 1)

# Q: Can we create a categorical variable based on the new variable V1
groupvec = quantile(iris_tr$v1, c(0, 0.25, 0.50, 0.75, 1.0))
labels = c('A', 'B', 'C', 'D')
iris_tr$v2 = cut(iris_tr$v1, breaks=groupvec, labels=labels, include.lowest=TRUE)

groupvec
iris_tr[c(1,6), ]

# Q: What does iris_tr[c(1,6), ] mean?
{
  # A: We only choose to see row 1 and 6 with all the columns 
}

# Set Levels of a Factor
vec = rep(c(0,1), c(4,6))
vec
# Converting to a factor and creating the labels/levels all at once.
vec_fac
vec_fac = factor(vec, labels=c('male','female'))

# We can also assign labels later.
# First converting to a factor.
vec1 = factor(rep(c(0,1,3), c(4,6,2)))
vec1
# Then creating the labels/levels.
levels(vec1) = c("male", "female", "male")
vec1

# Lables are not necessary
vec2 = factor(rep(c('b','a'), c(4,6)))
vec2
levels(vec2)

relevel(vec2, ref='b') #Changing the reference level.

# Data Reshape ------------------------------------------------------------
# Create Wide Dataset
data = iris[, 1:4] #A wide dataset; columns are variables, rows are observations.
head(data, 5)

dim(data)
dim(data_l)
dim(data_w)
# 1. Use the stack() function to reshape to long form; 
#    Use unstack() for wide form. 
data_l = stack(data) #A long dataset; treats all elements as pieces of data.
data_w = unstack(data_l) #A wide dataset; columns are variables, rows are obs.
data_l
str(data_l)
data_w
str(data_w)

# Example: 
# Let's take the last two columns of iris and reshape them to wide form.

subdata = iris[ ,4:5] #This subset of the overall data is in long form.
subdata[c(1,51, 101), ]

subdata_w = unstack(subdata) #Each factor becomes a column in the wide form.
head(subdata_w, 1)

# 2. Use reshape2 package
# Use dcast() to cast long format to wide format
# Q: Try to compare the average of petal.width between different species. 
#install.packages("reshape2")
library(reshape2)                  #Cast long format to wide format.
dcast(data=subdata,             #Specifying the data to manipulate.
      formula=Species ~ "mean_Petal.Width",      #Species should be the main column; nothing else.
      value.var='Petal.Width',  #Values to fill in should come from Petal.Width.
      fun=mean)                    #Aggregate the values by the mean.

# Q: what if we don't specify value.var='Petal.Width'?
{
  # A:
  dcast(data=subdata,            
        formula=Species ~ .,  
        fun=mean)  
  #      Species  .
  # 1     setosa NA
  # 2 versicolor NA
  # 3  virginica NA
}

# Use melt() to cast wide format to long format
iris
iris_long = melt(data=iris,         #Melt wide format to long format.
                 id.vars =c('Species',"Petal.Width"))           #The main identification variable is Species.
iris_long # set 'Species'as the main column

# To see the result by selecting 5 rows randomly
set.seed(5)
i = sample(nrow(iris_long), 5)
iris_long[i, ]

# Exercise:
# Now we have iris_long as a long format data, how to change it back to wide format
{# A:
  dcast(data=iris_long,                 
        formula=Species ~ variable,  
        value.var = 'value',
        fun=mean)            
}
# Compare with this code below:
dcast(data=iris_long,                 
      formula=Species ~ variable,  
      value.var = 'value',
      fun=length)     
# What's the default value of fun?
{
  # A:the default value of fun is length
} 

# In-class exercise

# For example:
# Is there a gender difference in the tipping habits?

# 1. Compare the average of tips between different genders
dcast(tips, sex ~ ., value.var='tip', fun=mean)
#Manipulate the tips data; sex is the main column; don???t keep anything else; fill in
#values based on the tip column; aggregate the results by the mean. 

# 2. Put the sizes of groups into consideration 
dcast(tips, sex ~ size, value.var='tip', fun=mean) 

# 3. Compare the average of bills between different genders
dcast(tips, sex ~ . , value.var='total_bill', fun=mean)  

# Open question: How can we compare between gender groups by calculating tip/total_tip?
tips2<-tips

tips2$ratio<-tips2$tip/tips2$total_bill
dcast(tips2,sex~time,value.var = "ratio",fun=mean)
dcast(tips, time ~ . , value.var='total_bill', fun=mean)  

# Split and Combine Data --------------------------------------------------
# 1. Merge
# Create 2 tables
datax = data.frame(id=c(1,2,3), gender=c('M', 'F', 'M'))
datay = data.frame(id=c(3,1,2), name=c('tom','john','mary'))
# One contains people's names
datay
# One contains their genders
datax

# Merging two data frames by common columns or row names (similar to JOIN in SQL):
merge(datax, datay, by='id')

# 2. Split
# Split the iris data by species 
iris_split = split(iris, iris$Species)
class(iris_split)
attributes(iris_split)
str(iris_split)
# Unsplit reverses the split operation:
iris_unsplit = unsplit(iris_split, iris$Species)
class(iris_unsplit)
iris_unsplit[c(1,51, 101), ]

# To answer the open question in the previous section
library(reshape2) #Not using the reshape2 functions, just want the tips dataset.
tips
tips_by_sex = split(tips, tips$sex)
head(tips_by_sex[[1]], 2)

ratio_fun = function(x) {
  sum(x$tip) / sum(x$total_bill)
}

# use lapply() to calculate the ratio
result = lapply(tips_by_sex, ratio_fun)
result

# Character Manipulation --------------------------------------------------
# Count the number of characters
fruit = 'apple,orange,grape,banana'
nchar(fruit)

# Split the elements of a character vector
split.string.list = strsplit(fruit, split=',')
split.string.list
class(split.string.list)
fruitvec = unlist(split.string.list)
class(fruitvec)

# Concatenate strings
paste(fruitvec, collapse = ' ')
paste(fruitvec, collapse=',')
paste(fruitvec, 1:4)
paste(fruitvec, 'extra', sep = '.')

# Exercise:
# Create a formula using paste()
n = 1:20
xvar = paste('x', n, sep = '')
right = paste(xvar, collapse = ' + ')
left = 'y ~'
my_formula = paste(left, right)
my_formula

# Substrings of a character vector
substr(fruit, 1, 5)
substr(fruit, 1, 7)
substr(fruit, 9, 21)
fruit
# Replacement
gsub('apple', 'strawberry', fruit)
gsub('a', '?', fruit)
gsub('an', 'HA', fruit)
fruit
# Pattern Matching
fruitvec
grep('grape', fruitvec)
grep('a', fruitvec)
grep('an', fruitvec)

# Case Study: Exploring CRAN ----------------------------------------------

# We want to explore the information provided in packages on CRAN.
# The goal is to get a dataframe where one column contains the package name and 
# another the author name.

#get packages table
#install.packages("XML")
library(XML)
web = 'http://cran.r-project.org/web/packages/available_packages_by_name.html'
packages = readHTMLTable(web, stringsAsFactors = FALSE)
str(packages)
# Open the first element 
packages_data=packages[[1]]
pnames = packages_data[ ,1]
length(pnames)

# We only check several packages
pnames = pnames[2:11]

# Create index pages of these packages
b = 'http://cran.r-project.org/web/packages/'
a = '/index.html'
urls = paste0(b, pnames, a)

# Read data from one or more HTML tables
# Check one url to see what information has been contained 
table = readHTMLTable(urls[1], stringsAsFactors=FALSE, header=FALSE)
class(table)
str(table)
info = table[[1]]
info
paste0(info$V1, info$V2)

# Now, we can paset informations together use lapply
tables = lapply(urls, readHTMLTable, stringsAsFactors=FALSE, header=FALSE)
infos = lapply(tables, function(x) x[[1]])
infovec = lapply(infos, function(x) paste0(x$V1, x$V2))

#Extract author names from infovec using grep and lapply. Finally, combine anamevec with pnames.
aname = lapply(infovec, function(x) x[grep('Author:', x)])
anamevec = lapply(aname, function(x) substr(x, 8, nchar(x)))
anamevec = unlist(anamevec)
name.df = data.frame(pnames, anamevec)

# Trick Time --------------------------------------------------------------
# Trick 1:
{
  # Before concluding this lesson, I'd like to show you a couple of time-saving tricks.
  # Earlier in the lesson, you assigned the list(a, b, c) to news_list. 
  # Let's pretend that you made a mistake and that you meant to enter list(a,b). 
  # You could either re-type the expression, or...
  # In many programming environments, the up arrow will cycle through previous commands. 
  # Try hitting the UP ARROW on your keyboard until you get to this command news_list = list(a, b, c), then delete c and hit Enter. 
  # If the up arrow doesn't work for you, just type the corrected command.
}

# Trick 2:
{
  # Let's pretend you'd like to calculate the square root of z, 
  # but you can't seem to remember what function you should use. You could try google it or 
  
  # Guess it!
  
  # You can type the first two letters, lets see, square root may start with sq  , 
  # type in sq" then hit the Tab key (possibly more than once). 
  # Most programming environments will provide a list of variables and commands that you've created that begin with 'sq'. 
  # This is called auto-completion and can be quite handy when you have many variables in your workspace. Give it a try.
  # (If auto-completion doesn't work for you, just type sqrt(z) and press Enter.)
}

