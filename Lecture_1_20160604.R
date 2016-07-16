setwd("c:/Users/Ali/NycDataScience/Lecture_1")
5-
  1
a <- 1+1
b <- 2
c <- 3
plot(1:10, 2:11)

### install.packages("ggplot2")
library(ggplot2)

### Basic R

### Arithmetic
1+1*3

### Numerical and string vectors (atomic vector)
c(0,1,1,2,3,9)
c("Hello, World!", "I am an R user")
1:6

### Can't combine numeric and string into same vector:
"1"+1
### Error in "1" + 1 : non-numeric argument to binary operator
x<-c(1,"d",5)
print(x)
### This will convert the numerics to strings so that it is all the same class.
### 1. Each atomic vector stores its values as a one-dimensional vector,
###    and each atomic vector can ONLH store ONE type of data.
### 2. So, R coerces data types.

### Example:
c(TRUE,1,"A")
### [1] "TRUE" "1"    "A"

### But, if Logical and numerator:
c(TRUE,1)
### [1] 1 1
### So, converted TRUE to 1, because in R, TRUE means 1.
c(FALSE, 1)
### [1] 0 1


### Vector addition
c(1,2,3,4) + c(3,4,5,6)
###[1]  4  6  8 10

### 1+3 = 4, 2+4 = 6, etc.
### Adding numbers in 1st position together, then numbers in 2nd position together, etc.


c(1,2,3,4) + c(1,2)
### [1] 2 4 4 6

### 1+1 = 2, 2+2 = 4, 3+1 = 4, 4+2 = 6
### Adding first position to first (1+1) and second to second (2+2),
### But then repeating first position of second vector and adding to third (3+1) and
### second position to 4th (4+2)

c(1,2,3,4) + c(1,2,3)
### Warning message:
###  In c(1, 2, 3, 4) + c(1, 2, 3) :
###  longer object length is not a multiple of shorter object length

### 1st vector has 4, second has 3.  So, it's recycling 1st element of 2nd vector
### but it's letting you know that it wasn't 1:1, or it didn't recycle all the way through


### Teacher note:
### R's Vector Recycling:
### If you give R two vectors of unequal length, R will repeat the shorter one
### as long as the longer vector, and then do the math.
### This isn't a permanent change; the shorter vector will be its original length
### If the length of the shorter vector does not divide evenly into the longer one,
### R will return a warning message, but will still do the calculation.  
### This behavior is known as vector recycling.

c(1,2)/c(1,2,3)
### [1] 1.0000000 1.0000000 0.3333333
### Warning message:
###   In c(1, 2)/c(1, 2, 3) :
###   longer object length is not a multiple of shorter object length


### Comparison
c(1,2,3,4)>c(1,2,1,2)
### [1] FALSE FALSE  TRUE  TRUE

c(1,2,3,4) <= c(1,5)
### [1]  TRUE  TRUE FALSE  TRUE

### Better ways to write lines 86 and 89:
(1:4)>(1:2)
### [1] FALSE FALSE  TRUE  TRUE

(1:4) <= c(1,5)
### [1]  TRUE  TRUE FALSE  TRUE

(((10+2)*3)-6)/3
### 10 is x.
### Result will always be x.

### Same calculation with sequence 1:4.
x<- 30:90
y <- function(x){
   (((x+2)*3)-6)/3
}
y(x)

(((x+2)*3)-6)/3


### Index operator: []
x <- c(5:8)
x[2]
### [1] 6

x[1:3]
### [1] 5 6 7

x[2]; x[2:4]
### [1] 6
### [1] 6 7 8

x[c(1,2,4)]
### [1] 5 6 8

x[-4]
### [1] 5 6 7
### So, it doesn't show the 4th element

x[c(-4,2)]
### Error in x[c(-4, 2)] : only 0's may be mixed with negative subscripts

x[c(-4,-1)]
### [1] 6 7


x[x>6]
### [1] 7 8


###Mathematical Functions.
### Calculate the square root of the sequence 1:4

x <- c(1:4)
sqrt(x)
### [1] 1.000000 1.414214 1.732051 2.000000

### Data frames
city <- c("New York", "San Francisco", "Chicago", "Houston", "Los Angeles")
age  <- c(23, 43, 51, 32, 60)
sex  <- c("F", "M", "F", "F", "M")

people <- data.frame(city, age, sex)
people
### city age sex
### 1      New York  23   F
### 2 San Francisco  43   M
### 3       Chicago  51   F
### 4       Houston  32   F
### 5   Los Angeles  60   M

###If vectors are not same length:
age1 <- c(23, 43)
people1 <- data.frame(sex, city, age1)
people1

### Error in data.frame(city, age1) : 
###  arguments imply differing number of rows: 5, 2

### Using the $ symbol to extract a column
people$age; people$sex
### [1] 23 43 51 32 60
### [1] F M F F M
### Levels: F M

people$age > 30 #Conditioned samples extracted from column
### [1] FALSE  TRUE  TRUE  TRUE  TRUE

people$city[people$age > 30] # Conditioning across variables
### [1] San Francisco Chicago       Houston       Los Angeles  
### Levels: Chicago Houston Los Angeles New York San Francisco

people[people$age>30] # For dataframe, ALWAYS need to tell it rows & columns
### No, here so not asking for columns and then get this error:
### Error in `[.data.frame`(people, people$age > 30) : 
###  undefined columns selected

people[people$age>30, ]
###  city age sex
###  2 San Francisco  43   M
###  3       Chicago  51   F
###  4       Houston  32   F
###  5   Los Angeles  60   M

### Data frames store data as a sequence of columns.
### Each column can be a different dtata type.
### Every column in a data frame must be the SAME LENGTH.

people[people$age>30,-1]
### age sex
### 2  43   M
### 3  51   F
### 4  32   F
### 5  60   M

inspections <- read.csv("data/BrooklynInspectionResults.csv", header = TRUE)
inspections[c(66, 70, 71, 72), -2] ### This says: return rows 66,70,71,72, and remove 2nd column.
###NOTE: in environment there is still full dataset  We just printed out the above.

class(inspections)
### [1] "data.frame"

class(inspections$VIOLATION.CODE)
### [1] "factor"

### Extract the restaurants surveyed.
restaurants <- inspections$DBA

class(restaurants)
### [1] "factor"
### restaurants is a factor, not a data frame.

###Count the number of unique restaurants in the data set
restaurant_set <- unique(restaurants)
length(restaurant_set)
### [1] 4651

###Another way to count unique restaurants; this way doesn't create a new vector
length(unique(restaurants))
### [1] 4651

class(restaurant_set)
### [1] "factor"
### So, restaurant set is a vector, not a data frame.
dim(restaurants)
### NULL (can't give number of rows and number of columns)
dim(inspections)
### [1] 32221     6 (32,221 rows, 6 columns)

### Limit the data to only those entries with critical violations
inspections <- inspections[inspections$CRITICAL.FLAG == "Critical", ]
### Means, "reduce inspections to keep only rows where CRITICAL.FLAG = "Critical", and all columns.
### So now, inspections has 17,344 rows instead of 32,221

### To install data frames from other languages (SPSS, STATA)
library(foreign)
read.foreign...


### Exporting R Data to a Local File
write.table(people, file = "write/people.csv", sep=",")
### Same thing as:
write.csv(people, file = "write/people2.csv")
### If usging "write.csv", don't need to say what the separator is.
### Also, using "write.csv" lines columns up properly when opening in Excel, where 
### using "write.table" shifts headers over to the left (adds row number with regular header, 
### so header for now second column is in 1st one over the row number).


###Lists

### Lists are most felxible because can have elements of DIFFERENT types and DIFFERENT lengths.
### Kind of like a closet.

### people.list <- list(AgeOfIndividual = age, Location = city, Gender = sex)
### people.list

### $AgeOfIndividual
### [1] 23 43 51 32 60

### $Location
### [1] "New York"      "San Francisco" "Chicago"       "Houston"       "Los Angeles"  

### $Gender
### [1] "F" "M" "F" "F" "M"


# Note: 
### Lists are like atomic vectors because they group data into a one-dimensional set.
### However, lists do not group together individual values;
### Lists group together R objects, such as atomic vectors, data frames, and other lists.

### Putting dataframe people into this list.
people.list$tabular.data <- people
people.list

### $AgeOfIndividual
### [1] 23 43 51 32 60

### $Location
### [1] "New York"      "San Francisco" "Chicago"       "Houston"       "Los Angeles"  

### $Gender
### [1] "F" "M" "F" "F" "M"
### $tabular.data
### city age sex
### 1      New York  23   F
### 2 San Francisco  43   M
### 3       Chicago  51   F
### 4       Houston  32   F
### 5   Los Angeles  60   M

### So, sort of a way to put a bunch of info to set aside.



### Extracting part of list.
people.list$Location
### [1] "New York"      "San Francisco" "Chicago"       "Houston"       "Los Angeles"  


### Can use a double index operatior to extract elements of a list.
### Example: to extract the last data element, you could do the following:
### Because only one dimension

people.list[[length(people.list)]]
### city age sex
### 1      New York  23   F
### 2 San Francisco  43   M
### 3       Chicago  51   F
### 4       Houston  32   F
### 5   Los Angeles  60   M

people.list[[length(people.list)-1]]
### [1] "F" "M" "F" "F" "M"

### Above two use length() to measure list.
### Use [[]] because list is closet, element is box.  So,
### first []opens list (i.e. people.list), and second [] opens box (i.e. tabular data)

### city age sex
### 2 San Francisco  43   M
### 3       Chicago  51   F
### 4       Houston  32   F
### 5   Los Angeles  60   M

people.list[[length(people.list)]][age>30, ]
### This says, "in people.list, give me the last element (length(people.list), but only when age > 30".
### So if have conditional parameter, need to have it after list, not within.

### If using element name, use "$.  
### If using position name, use "[[]]":
people.list$Location
### [1] "New York"      "San Francisco" "Chicago"       "Houston"       "Los Angeles"  

people.list[[2]]
### [1] "New York"      "San Francisco" "Chicago"       "Houston"       "Los Angeles"

### Can extract data frame, etc from lists:

people2 <- data.frame(people.list[[length(people.list)]])
people2

### city age sex
### 1      New York  23   F
### 2 San Francisco  43   M
### 3       Chicago  51   F
### 4       Houston  32   F
### 5   Los Angeles  60   M

class(people2)
### [1] "data.frame"



### Exercise: create list with personal info, name, gender and age in separate elements:
personal.info <- list(name = "Alison", age = 47, gender = "F")
personal.info
### $name
### [1] "Alison"

### $age
### [1] 47

### $gender
### [1] "F"

### For any one object, we can use the class() function to print its class(es).
class(people)
### [1] "data.frame

### Can use attributes() function to print its properties.
attributes(people)
### $names
### [1] "city" "age"  "sex" 

### $row.names
### [1] 1 2 3 4 5

### $class
### [1] "data.frame"

### str() can be used to understand an object's class, attributes and sample data.
str(people)
### 'data.frame':	5 obs. of  3 variables:
###   $ city: Factor w/ 5 levels "Chicago","Houston",..: 4 5 1 2 3
### $ age : num  23 43 51 32 60
### $ sex : Factor w/ 2 levels "F","M": 1 2 1 1 2



### Exercise: find into on people.list
class(people.list)
### [1] "list"
names(people.list)
### [1] "AgeOfIndividual" "Location"        "Gender"          "tabular.data"   
attributes(people.list)
### $names
### [1] "AgeOfIndividual" "Location"        "Gender"          "tabular.data"   

str(people.list)
### List of 4
### $ AgeOfIndividual: num [1:5] 23 43 51 32 60
### $ Location       : chr [1:5] "New York" "San Francisco" "Chicago" "Houston" ...
### $ Gender         : chr [1:5] "F" "M" "F" "F" ...
### $ tabular.data   :'data.frame':	5 obs. of  3 variables:
###   ..$ city: Factor w/ 5 levels "Chicago","Houston",..: 4 5 1 2 3
### ..$ age : num [1:5] 23 43 51 32 60
### ..$ sex : Factor w/ 2 levels "F","M": 1 2 1 1 2

####### MODELS

#A sample model y is a function of variables x1 to xn
### y ~ x1 + x2 + x3 + ... + xn
### For example, we can plot the relationship between distance and speed in the cars
### data set with the following function:
  #install.packages("lattice")
  library(lattice)
xyplot(dist ~ speed, data=cars)

### Can also run regression and save it in a variable:
model <- lm(dist ~ speed, data = cars)
model

### Call:
###   lm(formula = dist ~ speed, data = cars)

### Coefficients:
###   (Intercept)        speed  
### -17.579        3.932   lm(formula = dist ~ speed, data = cars)

### So, if we put it into a variable, it turns it into a list.  If we call the variable 
### it will give the info, but won't run the plot.
### But, class will be "lm".
class(model)
### [1] "lm"

summary(model)

xyplot(dist ~ speed, data = cars, type = c("p", "r"))
### Here, p = points, r = regression