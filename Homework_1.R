### Problem 1
### Get familiar with your working directory:
  
### . What is your working directory?
getwd()

### . Change it to your desktop
setwd("C:/Users/Ali/Desktop")


### Problem 2
### Give the commands to do the following:
### . Install the knitr package
install.packages("knitr")

### . Load knitr into your R environment
library(knitr)


### Problem 3
### Search for help

### . Bring the html help page up for function called "c"
?c

### . Bring the html help page up for function called "sum"
?sum

### . Find all the functions which contain the word of "plot"
??plot

### . Run the example function for "plot"
example(plot)

### Problem 4
### What kind of object CANNOT be placed in a list object?
### . list: YES
### . matrix Answer: YES
### . data.frame: YES
### . function: NO

### Problem 5
### Generate a 5 x 4 data.frame that looks like this:
a <- c("one", "two", "three", "four", "five")
b <- c(6,7,8,9,10)
c <- c(11,12,13,14,15)
d <- c(16,17,18,19,20)

df <- data.frame(cbind(a,b,c,d))

summary(df)
  
### Do a summary, what did you find?
### ANSWER: each colum was sorted, with each column being treated as a factor:
# a      b      c      d    
# five :1   10:1   11:1   16:1  
# four :1   6 :1   12:1   17:1  
# one  :1   7 :1   13:1   18:1  
# three:1   8 :1   14:1   19:1  
# two  :1   9 :1   15:1   20:1 


### Using the people(with temperature info) data.frame provided below, find:

city <- c('beijing', 'shanghai', 'chengdu', 'shanghai', 'beijing')
age <- c(23, 43, 51, 32, 60)
sex <- c('F', 'M', 'F', 'F', 'M')
temp <- c(27, 29, 23, 14, NA)
people <- data.frame(city, age, sex, temp, stringsAsFactors = F)

### . average temperature of city ( using the $ sign and [ ,2] interchangeably)
mean(people$temp,  na.rm = TRUE)
### [1] 23.25

### . the records whose city=shanghai, and sex=F
shanghai_f <- data.frame(people[people$city == "shanghai" & people$sex == "F", ])

### . for all the females, how many of them live in shanghai,chengdu
### Solution # 1
females <- data.frame(people[people$sex == "F" & (people$city == "chengdu" | people$city == "shanghai"), ])
nrow(females)
### [1] 2 

### . for all the males, how many of them is older than 20.
males <- data.frame(people[people$sex == "M" & people$age > 20, ])
nrow(males)
### [1] 2

### . how many of the city has records whose temperature was between 20 and 30
city_temp <- na.omit(data.frame (people[people$temp >= 20 & people$temp <= 30, ]))
nrow(city_temp)
### [1] 3
  

