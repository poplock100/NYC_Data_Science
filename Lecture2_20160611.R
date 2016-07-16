### Vectors
vector <- seq(2,10, by = 2)
### use "seq" if need to count by x number

### Vectors don't need to end at the end number:
vector <- seq(2,10, by=3)
vector
### [1] 2 5 8   So, didn't go all the way to 10
### seq(start, end, by = ), 1 is default for "by"


vector2 <- (1:10) + 2
vector2
### [1]  3  4  5  6  7  8  9 10 11 12
###so adds on 2 to each number

vector3 <- 1:(10+2)
vector3
### [1]  1  2  3  4  5  6  7  8  9 10 11 12
### so starts at one and then adds 2 to the end.

### a. Double:
### A double vector stores regular numbers
double <- c(1,2,4)
double
typeof(double)


### 2. Integer:
### Integer vectors store integers, number can be written 
### without a decimal component
int <- c(1L, 2L,4L)


### Characters:
### Stores text
text <- c("Hellow", "World")
text
typeof(text)

###4. Logicals
### Logical vectors store TRUEs and FALSEs (boolean data).
### Logicals good for comparison
logic<-1:3>=3:1
logic
#[1] FALSE  TRUE  TRUE

### Use rep() to create a vector replicating from a patter.
group1 <- rep(1:3, times = c(8,10,9))
###repeat 1 8 times, 2 10 times and 3 9 times)
group2 <- factor(group1)
class(group1)
class(group2)
###Make things a factor if you are using numbers as groups (i.e. groups 1,2,3)
###Basically, factor is a category or a label (i.e. 1 for male, 2 for female)


### Calculations by group
group <- rep(1:3, times=c(4,5,3))
score <- c(100, 92, 75, 82, NA, 90, 72, 98, 60, 78, 93, 67)
class <- data.frame(group,score)
group <- as.factor(group)



### Vector generation: different types
set.seed(0)
vec_logic <- c(TRUE, TRUE, TRUE, FALSE)
vec_char <- c("A", "B", "C", "D")
vec_num1 <- runif(5) # The Uniform Distribution
vec_num2 <-numeric(10) # 10 item 0 vector
vec_char2 = sample ("A", "B", size = 10, replace = TRUE)
vec_logic; vec_char2; vec_num2



set.seed(0)
vector <- rnorm(10)
vec_max <- max(vector)
vec_min <- min(vector)
vector_trimmed <- vector[vector < vec_max & vector > vec_min]
vec_mean <- mean(vector_trimmed)


##### Matrix
### Can take vector and turn into matrix, or just directly make matrix.
vector <- 1:12
# A direct method of creating a matrix uses the matrix function.
my_matrix <- matrix(vector, nrow = 3, ncol = 4, byrow = FALSE)
my_matrix
### [,1] [,2] [,3] [,4]
### [1,]    1    4    7   10
### [2,]    2    5    8   11
### [3,]    3    6    9   12

### Using cbind() or rbind()
set.seed(0)
vector1 <- vector2 <- vector3 <- rnorm(3)
my_matrix <- cbind(vector1, vector2, vector3)
my_matrix

### Matrix Degratation
### Can get subset of matrix
my_mat <- matrix(1:9,3,3)
my_mat
my_mat[1:2,]


############# Arrays
a <- array(1:8, dim = c(2,2,2))
a
### , , 1

### [,1] [,2]
### [1,]    1    3
### [2,]    2    4

### , , 2

### [,1] [,2]
### [1,]    5    7
### [2,]    6    8
a[,,1]
###[,1] [,2]
###[1,]    1    3
###[2,]    2    4

########################### Data Frames
city <- c("Seattle", "Chicago", "Boston", "Houston")
temp <- c(78, 74, 50, 104)
data <- data.frame(city, temp)

### To exctract "cit" column.  3 ways:
data[,1]
data[, "city"]
data$city
###Above are all the same

### Converting  variables to factors:
data <- data.frame(city, temp, stringsAsFactors = FALSE)
data$city <- factor(data$city)

### To find cities with higher than average temperature:
ave <- mean(data$temp)
data[data$temp > ave,]
ave

### Ways to look at and understand what is in your data
summary(data)
dim(data)
head(data)
tail(data)
str(data)


### Sorting data frames:
### Sort the whole data frame by temperature (from low to high).
order(data$temp) ### (this shows what the order is)
### To actually sort the data
data[order(data$temp), ]

### to sort descending, give top two hottest cities.
data[order(data$temp, data$temp, decreasing = TRUE), ] [1:2, ]
### Better way to write this:
order(data$temp, decreasing = TRUE)
data1 <- data1 <- data[order(data$temp, decreasing = TRUE),]
data1[1:2,]


### Mising and Null values
### Need to remove it to do functions.
temp = c(27, 29, 23, 14, NA)
mean(temp)
### [1] NA (got this because R included the NA)
### So, need to do this:
mean(temp, na.rm = TRUE)
### [1] 23.25
### So, need to use "na.rm"
length(temp)
###[1] 5

### NULL values
temp = c(27, 29, 23, 14, NULL)
mean(temp)
###[1] 23.25
### So R treats the observation as if it's not there; does not consider it to be 0.
length(temp)
### [1] 4

###Can also use Null to remove a column
data$temp <- NULL  ### (this would remove the entire column "temp" from the "data" dataframe)


########################### Applying functions to Data
### Apply causes calculations to go for each row.

iris

### Below code means for all rows and columns 1 - 4, give the sd/mean
sapply(iris[, 1:4], function(x) sd(x)/mean(x))
### Sepal.Length  Sepal.Width Petal.Length  Petal.Width 
### 0.1417113    0.1425642    0.4697441    0.6355511 
### code means "in data set iris, for columns 1 - 4, determine sd/mean for all rows
### NOTE: CALCULATION IS BY COLUMN!

### Calculate mean & sd separately and then divide
y <- sapply ((iris[, 1:4]), function(x) mean(x))
z <- sapply (iris[,1:4], function(x) sd(x))
sapply (iris[,1:4], function(x) sd(x)/mean(x))
z/y

#Since mean and sd are already functions, don't need to name them as functions
y1 <- sapply(iris[,1:4],mean)
z1 <- sapply(iris[,1:4],sd)
z1/y1


### Sapply also operates on lists:
mylist <- as.list(iris[,1:4])
sapply (mylist, mean)


###lapply()
### lapply() function is same as sapply, except it returns the values in list form.
lapply(mylist, mean)
 
### Example 2:
myfunc <- function(x){
  ret<- c(mean(x), sd(x))
  return(ret)
}

result <- lapply(mylist, myfunc)

### Can also make it a dataframe
result_dataframe <- t(data.frame(result))
result_dataframe


### APPLY
### Use this if want to do calculations by row instead of column

set.seed(1)
vec <- round(runif(12)*100)
mat <- matrix(vec, 3,4)

apply(mat,1, sum) ### The 1 means apply across rows (for column use 2)

### So, in apply, must have 1 or 2 to explain if rows or columns
### apply(data, row or column via 1 or 2, funtion)

### tapply()
### tapply() is for apply a function across different groups.
tapply(X = iris$Sepal.Length, INDEX=list(iris$Species), FUN = mean)
####NOTE WITH TAPPLY:
#### IF USING THE "x=", "INDEX=" and "FUN=", they must be in ALL CAPS!!!!!!!!!

### mean of group in our class dataframe
### All of the below will work
class2 <- data.frame(group,score)
tapply(X = class2$score, INDEX=list(class2$group), FUN = mean)

tapply(class2$score, list(class2$group),mean)

with(class2,tapply(score, group, mean))

with(class2,tapply(score,group, function(x)mean(x,na.rm=T)))



##########################Conditional
### If statements
#If this is true, do that:
if(this){
  that
}


### Is a number odd or even
num <- 4
if(num%%2!=0){
  cat(num,"is odd")
  } else {
  cat(num, "is even")
}


### For multiple conditions, use elseif

if(this){
  do A
} else if(that){
  do B
}else{
    C
  }
}
### ifelse also works; 
###formula:  ifelse(test,yes,no)
num <- 1:6
ifelse(num%%2==0, yes="even",no="odd")
### same as:
ifelse(num%%2==0,"even","odd")


###ifelse structure can also be nested to evaluate multiple conditions
set.seed(0)
age <- sample(0:100,20, replace = TRUE)
res <- ifelse(age>70,"old", ifelse(age<=30, "young","mid"))
age
res


###If lots of conditions, use switch function
age_group <- cut(age,breaks = c(0,30,70,100), labels = FALSE) # Returns integers
age_group ### cut the whole vector and put into categories
#Now, use switch to find out which group first obs is in
switch(age_group[1], "young", "middle","old")
### [1] "old"
###NOTE: THIS ONLY WORKS FOR INTEGERS
### When the first parameter to switch is a string and not an integer,
### the function returns the value assigned to the matched string in th...
age_type <- "middle"
switch(age_type,
       young <- age[age<=30],
       middle <- age[age <=70 & age > 30],
       old <- age[age>70]
       )

campaign_data <- read.csv ("data/cm=ampaign_contributions.csv", header= TRUE)



###################Loops
### repeatedly run a piece of code.


###Example: using a looop to find missing values in "width" column and saying which row number is missing.
###For loop
sign_dta <- read.csv("Data/TimesSquareSignage.csv", header = TRUE)
obs <- nrow(sign_data)
for (i in 1:obs){
  if(is.na(sign_data$Width[i])){
    cat("wARNING: Missing width for sign no.",i,"\n")
  }
}

###While loop
i = 1
while(i <=obs){
  if(is.na(sign_data$Width[i])){
    cat("wARNING: Missing width for sign no.",i,"\n")
  }
  i=i+1
}

###Maybe want to change output midway:
i = 1
nas(which(is.na(sigh_data$Width)))
while (i<6) {
  if(is.na(sign_data$Width[i])){
    cat("wARNING: Missing width for sign no.",i,"\n")
  } 
  if i>=5 {
    cat("more than 5 missing values")
    break
  })
###################################Functions
### Calculate the area of a circle with radius r = 4,6,8

r<-seq(4,8,by=2)
r^2*pi


### What if have a lot of numbers we need to calculate area of circle on?
###Make function
calc_area = function(r){
  area <- pi*r^2
  return(area)
}

calc_area(4)

#############Recursion
###Technique where function calls itself.

Fac1 = function (n) {
  if  (n == 0)
    return
  (1)
  return (n * Fac1(n1))
}
Fac1(10)

which_generation <- function(birth_year){
if (birth_year > 2000) {
    category = 'Gen Z'
  }  else if (birth_year > 1985) {
    category = 'Gen Y'
  }
  else if (birth_year > 1965) {
    category = 'Gen X'
  }
  else {
    category = 'Baby Boomer' 
  }
return(category)
}

years = c(1950,1973,1990, 2005)
which_generation(years)

### Above won't work because years has too many values.  Need to do VECTORIZE:
which_generation = Vectorize(which_generation)
which_generation(years)


### You can create your own binary operators with the same function procedure. For
### example, we can define a set operator to find the intersection of two sets:
a <- c('NPR','New York Times','MSNBC')
b <- c('Wall Street Journal','NPR','Fox News')
'%int%'=function(x, y) {
  intersect(x,y)
}
a%int%b

c = c('Salon','The Onion','NPR')
a %int% b %int% c
### [1] "NPR"
news_list = list(a, b, c)
Reduce('%int%', news_list)
### [1] "NPR"


####################TRANSFORMATION
data_sub <- iris[iris$Species== "setosa", 3:5]
data_sub2 <- with(iris, iris[Species=="setosa", 3:5])
head(data_sub,1)

###How to dd one column(Sepal.Length) to the original dataset
###1. Using transform()
iris_tr <- transform(iris, v1 = log(Sepal.Length))
head(iris_tr,1)
###  Sepal.Length Sepal.Width Petal.Length Petal.Width Species       v1
### 1          5.1         3.5          1.4         0.2  setosa 1.629241


###2. Using $ directly
iris_tr1 <- iris
iris_tr1$v1 = log(iris$Sepal.Length)


### Create categorical variable based on new variable v1
groupvec <- quantile(iris_tr$v1, c(0,.25,.50,.75,1))
labels <- c("A", "B", "C", "D")
iris_tr$v2 <- cut(iris_tr$v1, breaks = groupvec, labes= labes, index.lowest = TRUE)
groupvec


###Set levels of a Factor
vec = rep(c(0,1), c(4,6))
### Repeat 0 four times and 1 six times
vec

###Converting to factor and creating labels/levels all at once
vec_fac <- factor(vec, labels=c("male","female"))
vec_fac

### Can also do it separately
vec1 <-factor(rep(c(0,1,3), c(4,6,2)))
levels(vec1) = c("male", "female","male")
vec1


###Reshape
data <- iris[, 1:4]
#A wide dataset; columns are variables, rows are observations.
head(data,5)
     
data_l <- stack(data)
nrow(data_l)
###[1] 600
data_w <- unstack(data_l)
nrow(data_w)
### [1] 150

####RESHAPE2 package
###melts( takes wide and "melts" it to long)
###cast(takes long and "casts" it into wide)
### - dcast() reshapes a molten data into a data frame
### ● acast() reshape a molten data into a vector/matrix/array
library(reshape2)
dcast(data= subdata, ### Cast long format to wide.
      formula = Species~., ###Specifying data to manipulate.
      value.var="Petal.Width", ### Species should be main column, nothing else
      fun = mean) ### Aggregate the values by mean

### Can assign values within dcast
dcast(data= subdata, ### Cast long format to wide.
      formula = Species~"Col name here", ###Specifying data to manipulate.
      value.var="Petal.Width", ### Species should be main column, nothing else
      fun = mean) ### Aggregate the values by mean


###Use melt() to cast wide format to long format
iris
iris_long <- melt(data=iris,  ###melt wide to long
                  id.vars = c("Species", "Petal.Width"))
iris_long

### To switch iris_long to wide, use dcast()
dcast(data=iris_long,
formula=Species~variable,
value.var = "value")
###default function is length(), so better to specify it.
dcast(data=iris_long,
      formula=Species~variable,
      value.var = "value",
      fun= mean)


### Using built in tips dataset, is there  a gender difference in tipping habits?
View(tips)
head(tips)

tapply(X=tips$tip, INDEX= tips$sex, FUN = mean)
tapply(tips$tip,tips$sex, mean)

###Is there a gender difference in tip amount by meal?
dcast(tips, sex~time,value.var="tip", fun = mean)
### sex   Dinner    Lunch
### 1 Female 3.002115 2.582857
### 2   Male 3.144839 2.882121

###Add column of ration tip/bill.
tips_2<- tips
tips_2$ratio <- tips_2$tip/tips_2$total_bill

### Gender by ratio of tip/total_tip
dcast(tips_2,sex~., value.var = "ratio", mean)
dcast(tips_2,sex~"ratio", value.var = "ratio", mean)
###What about gender and time?
dcast(tips_2,sex~time, value.var = "ratio", mean)
###smoker and time?
dcast(tips_2, time~smoker, value.var="ratio", mean)



###############Combining data frames
merge(data1, data2, by = commonfield)


######Split
iris_split <- split(iris, iris$Species)
class(iris_split)
####NOTE: WHEN USING SPLIT, RESULT IS A LIST.
iris_unsplit <- unsplit(iris_split, iris$Species)
class(iris_unsplit)


###See total, using function
tips_by_sex = split(tips, tips$sex)

ratio_fun = function(x){
  sum(x$tip)/sum(x$total_bill)
}
### Then use lapply() to calculat the ratio
lapply(tips_by_sex, ratio_fun)


###Split the elements of a character vector
fruit <- "apple, banana, roage, grape"
nchar(fruit)





###Exercise:
### Suppose we have a charactor vector as follow:
Names <- "Amy Joseph Christopher"
### Write code to obtain the following output:
### "Amy@gmail.com; Joseph@gmail.com; Christopher@gmail.com"

Names <- "Amy Joseph Christopher"
name<- unlist(strsplit(Names, split = " "))
### this splits "Names" into each part separated by " "
item<-paste(name,"gmail.com", sep="@", collapse = ";")
### this makes "item" one long charachter of name@gmail.com; 

###Substrings of character vectors
substr(fruit,1,5)
substr(fruit,9,21)

###Replacement
gsub("apple", "strawberry", fruit)
gsub("roage", "orange", fruit)


###Pattern Matching
split.string.list = strsplit(fruit, split=' ')
fruitvec<- unlist(split.string.list)
grep("grape", fruitvec)
### [1] 4
###Finds which place int he vector the tiem in the "" is.
grep("a", fruitvec)
### [1] 1 2 3 4
grep("an", fruitvec)
### [1] 2

