
# Introduction to RStudio #-------------------------------------------------
setwd("~/Documents/NycDataScience/RDA_lecture_code")

# Q: How to get or set Working Directory? 
{
  # A: getwd()
  #    setwd()
}
# Q: How to get help with these two function?
{
  # A: help(getwd)
  #    ?setwd
}
#-------------------------------------------------------------------------------------------#
1+1
# Note: You will notice that [1] appears next to the result.
#       R is just letting you know that the line begins with the first value in your result


# Q: What if a command returns more than one value? (Hint: Try to create a sequence)
{ 
  100:130 
  # A: Notice that new bracketed numbers appear at the start of the second and third lines of output. 
  # These numbers just mean that the second line begins with the No.n value in the result
  # These numbers just help you count, so  You can mostly ignore the numbers that appear in brackets
}

{
  # Note: The colon operator (:) returns every integer between two integers. 
  #       It is an easy way to create a sequence of numbers.
  # Q: Try to create a sequence of integers from 4 to 29
  {
    # A: 
    4:29
  }
}

#-------------------------------------------------------------------------------------------#
# Try this command 
5-
  1

# Note: If you type an incomplete command and press Enter, R will display a + prompt, which
#       means it is waiting for you to type the rest of your command. Either finish the command
#       or hit Escape to start over
#-------------------------------------------------------------------------------------------#

a=1+1
b=2
c=3
# Q: What happened here?
{
  # A: 1. You created 3 objects a,b,c and assigned values to them. (We will talk more about it later)
  #    2. Go check you environment panel of Rstudio.  
  # Q: What happened to the environment panel?
  {
    # A: This paneL will show you all of the objects youve created since opening RStudio.
  }
}
# Note: You'll notice that R did not print the result of 1+1 this time. 
#       When you use the assignment operator, R assumes that you don't want to see the result immediately,
#        but rather that you intend to use the result for something else later on.

# Q: What if we want to see the result of 1+1?
{
  # A: We use print
  print(a)
}
#-------------------------------------------------------------------------------------------#
# Q: How can we install the package "ggplot2"?
{
  # A: 1. Using install.packages(ggplot2)
  #    2. Using Packages tab in Rstudio
}
# Q: How we run particular package in R, like "ggplot2"?
{
  # A: 1. library(ggplot2) 
  #    2. require(ggplot2)
}

#-------------------------------------------------------------------------------------------#
# Q: Do you know why we need to write a script instead of typing the code to the console directly?
{
  # A: Think about it: what if you want to run the code above after the class? 
  #    You could go back and retype each line of code.
  #    but it would be so much easier if you had a draft of the code to start from. You
  #    can create a draft of your code as you go by using an R script. An R script is just a plain
  #    text file that you save R code in. 
}
# Q: What does a hashtag (#) mean in R?
{
  # A: R treats the hashtag character, #, in a special way; R will not run anything that follows
  #    a hashtag on a line. This makes hashtags very useful for adding comments and annotations to your code. 
  #    Humans will be able to read the comments, but your computer will pass over them. 
  #    The hashtag is known as the commenting symbol in R
}

# Objects #-------------------------------------------------

#basic arithmetic
1 + 1 * 3 

#numerical and string vectors (atomic vector)
c(0, 1, 1, 2, 3, 9)
c("Hello, World!", "I am an R user")
1:6
# Q: 1.Try to create a vector contains both some strings and numbers
#    2.Print out the result and what happened?
#    3. Why?
{
  # A: 
  a<-c("A",0)
  print(a)
  #   1. Each atomic vector stores its values as a one-dimensional vector, 
  #      and each atomic vector can ONLY store ONE type of data
  #   2. So R coerces data types.
  
  # Note: R's Coercion Rules: 
  # Try following code:
  a<-c("A",0,TRUE);a
  b<-c(0,TRUE);b
  {
    #     1. If a character string is present in an atomic vector, 
    #        R will convert everything else in the vector to character strings.
    #     2. If a vector only contains Coercion logicals and numbers, 
    #        R will convert the logicals to numbers; every TRUE becomes a 1,
    #        and every FALSE becomes a 0,
  } }

#vector addition
c(1, 2, 3, 4) + c(3, 4, 5, 6)
c(1, 2, 3, 4) + c(1, 2)
c(1, 2, 3, 4) + c(1,2,3)


# Note:
# R's Vector Recycling:
# If you give R two vectors of unequal lengths, R will repeat the shorter vector until it is
# as long as the longer vector, and then do the math. 
# This isnt a permanent changethe shorter vector will be its original size after R does the math. 
# If the length of the short vector does not divide evenly into the length of the long vector,
# R will return a warning message. This behavior is known as vector recycling

# Q: Can you improve this part of code based on we learned before?
{
  # A:
  1:4+3:6
  1:4+1:2
  1:4+1:3
}

# Comparison
c(1,2,3,4)>c(1,2,1,2)
c(1,2,3,4)<=c(1,5)

# Q: How to create same result of c(1,2,3,4)>c(1,2,1,2)
#    using R's Vector Recycling?
{
  # A:
  1:4>1:2
}

# Exercise:
# Let's do some basic If you execute everything correctly, 
# you should end up with the same number that you started with:
# 1. Choose any number and add 2 to it.
# 2. Multiply the result by 3.
# 3. Subtract 6 from the answer.
# 4. Divide what you get by 3

# Try to do the same calculation to 
# A sequence of number 1,2,3,4
{
  # 
  ((1:4+2)*3-6)/3
  # Better way to simplify it:
  x<-1:4
  ((x+2)*3-6)/3
  # Here we use variable to make it simpler, 
  # and we can run the code repeatly by changing the value of x 
}

# Variables #-------------------------------------------------

# The default assignment operator is a pointing arrow: <-, 
# but you can also use the equal sign: =, as in most other languages.

x = c(1, 2, 3, 4)
x

# Note :You can name an object in R almost anything you want,
#       but there are a few rules:
#       1. A name cannot start with a number. 
#       2. A name cannot use some special symbols,like ^, !, $, @, +, -, /, or *:

x[2]; x[2:4]
x[-4]
x[x > 2]

# Logical Operators #-------------------------------------------------


# Let's play a game! I created a and b; 
# Their values are both positive integers less than 10 
# Try to guess a and b
{
  a<-7
  b<-2
}

# Hint:
# a>b
# a>=b
# a<b
# a<=b
# a==b
# a!=b
# a %in% c(1,2,3)

# Mathematical Functions #-------------------------------------------------
exp(1)
exp(c(1, 2, 3, 4))

# Q: Calculate the square root of the sequence 1:4 (Use function sqrt())
{
  # A: 
  sqrt(1:4)
}

# Data Frames #-------------------------------------------------
# Data frames group vectors together into a two-dimensional table. 
# Each vector becomes a column in the table.
# As a result, each column of a data frame can contain a DIFFERENT TYPE of data; 
# but within a column, every cell must be the SAME TYPE of data

# Another explaination:
{
  # Data frames store data as a sequence of columns. 
  # Each column can be adifferent data type. 
  # Every column in a data frame must be the SAME LENGTH.
}

# To create a data frame:
# 1. Each vector should be set equal to a NAME that describes the vector. 
{
  city = c('New York', 'San Francisco', 'Chicago', 'Houston', 'Los Angeles')
  age = c(23, 43, 51, 32, 60)
  sex = c('F', 'M', 'F', 'F', 'M')
}
# 2. Give data.frame any number of vectors, each separated with a comma.
{
  people = data.frame(city, age, sex)
}
people

# Q: What if the vectors have different length?
{
  # A:
  # Try code:
  city1 = c('New York', 'San Francisco', 'Chicago', 'Houston')
  age1 = c(23, 43)
  people1 = data.frame(city1, age1)
  # Try code:
  city2 = c('New York', 'San Francisco', 'Chicago', 'Houston')
  age2 = c(23, 43, 12)
  people2 = data.frame(city2, age2)
  
  # Youll need to make sure that each vector is the same length, 
  # otherwise it can be made so with Rs recycling rules;
  # Or R will give an error message
  # Since data frames cannot combine columns of different lengths.
}

# Using the $ symbol to extract a column
people$age; people$sex
people$age > 30 #Conditioned samples extracted from column
people$city[people$age > 30] #Conditioning across variables

#-------------------------------------------------------------------------------------------#
# Importing Local Data into a Data Frame
inspections = read.csv('data/BrooklynInspectionResults.csv', header=TRUE)
inspections[c(66, 70, 71, 72), c(1,3,6)]

class(inspections)

# Q: Get to know learn about class()
{
  # A: 
  ?class
}

#Extract the restaurants surveyed
restaurants = inspections$DBA

#Count the number of unique restaurants in the data set
restaurant_set = unique(restaurants)
length(restaurant_set)

# Q: Is restaurant_set a vector or a data.frame?
{
  # A: 
  class(restaurant_set)
  # Factors are Rs way of storing categorical information, like ethnicity or eye color. 
  # Think of a factor as something like a gender; it can only have certain values (male or female)
  # So restaurant_set is just a column, so it only has length here
}

#Limit the data to only those entries with critical violations
inspections = inspections[inspections$CRITICAL.FLAG == "Critical", ]
# Q: What does this code mean?
{
  # A: It selected the obseveations whoes CRITICAL.FLAG is "Critical".(rows)
  #    Also, it selected all the variables (columns) 
}

# Other data resources
# Excel:
{
  #install.packages("openxlsx")
  library(openxlsx)
  excel_data = read.xlsx("data/excel.xlsx", sheet=1)  #read first sheet
}

# stata, spss, sas
{
  #install.packages("foreign")
  library(foreign)
  stata_data = read.dta("data/statafile.dta")
  spss_data = read.spss("data/spssfile.sav")
  sas_data = read.xport("data/sasfile.xpt")
}
#-------------------------------------------------------------------------------------------#
# Exporting R Data to a Local File

write.table(people, file='write/people.csv', sep=',')
write.csv(people, file='write/people2.csv') #Equivalent statement

# Lists -------------------------------------------------------------------

# Lists are the most flexible data structure; 
# their elements can be of DIFFERENT types and DIFFERENT lengths.

people.list = list(AgeOfIndividual=age, Location=city, Gender=sex)
people.list

# Note:
{
  # Lists are like atomic vectors because they group data into a one-dimensional set. 
  # However, lists do not group together individual values; 
  # lists group together R objects, such as atomic vectors, data frames and other lists.
}
# Let's put the dataframe people in this list!
people.list$tabular.data = people
people.list
people.list$tabular.data

# We can use a double index operator to extract elements of a list. 
# For example, to extract the last data element, you can do the following:
people.list[[length(people.list)][age>30,]

# Note:
{
# We use length() to measure list. 
# List is quite similar to an atomic vector
}
            
# Exercise 
# Use a list to store your personal information, like your name, gender and age.
# Store them in separate elements.
            
# Example Answer:
{
personal.info <- list(name="Vivian", gender="F", age=25)
personal.info
 }
            
# Object Features ---------------------------------------------------------
            
# For any one object, we can use the class() function to print its class(es).
class(people)
# Additionally, you can use the attributes() function to print its properties.
attributes(people)
# str() can be used to understand an object's class, attributes, and sample data.
str(people)
            
# Q: Try to learn the features about people.list
{
# A:class(people.list)
#   attributes(people.list)
#   str(people.list)
}