### RDA 3 lecture code

# Manipulating Dates and Timestamps ---------------------------------------

# The attribute system lets R represent more types of data than just doubles, integers,
# characters, logicals, complexes, and raws. 

# R uses a special class to represent dates and times. 
# To see this, run Sys.time().
now<-Sys.time()
now
# Sys.time returns the current time on your computer. 
# The time looks like a character string when you display it, but its data type is actually "double" 
typeof(now)
unclass(now) # store as seconds
# and its class is "POSIXct" "POSIXt" (it has two classes)
class(now)

# How to store data as date?
# Use as.Date() to create date class object.
date1 = '1989'
class(date1)
date1 = as.Date(date1)
date1
class(date1)

# We can also change the format using as.Date()
date1 = '05/04/1989'
date1 = as.Date(date1, format='%m/%d/%Y')
date1
date2 = date1 + 31
date2
date2 - date1

# Compare the result with these command:
date_1 = '05/04/1989'
date2 = date_1 + 31

# Count from 1970.01.01 in the date class object:
Sys.Date() - structure(0, class='Date')

# Create a sequence of days
dates = seq(date1, length=4, by='day')
format(dates, '%w') # w stands for week
# Try %y,%m,%s, and try to interpret the meanings
weekdays(dates) # Extract the weekday

# next time ---------------------------------------------------------------


# Use as.POSIXct to create POSIXct class objects.
time1 = '1989-05-04'
time1 = as.POSIXct(time1)
time1 

time1 = "2011-03-1 01:30:00"
time1 = as.POSIXct(time1, format="%Y-%m-%d %H:%M:%S")
time1

# Try to interpret this part of code
time1 = as.POSIXct("2011-03-1 01:30:00", tz='GMT')
time2 = seq(from=time1, to=Sys.time(), by='month')
time2

# Create a POSIXct class object based on a numeric object.
# The ISOdatetime function can convert a numeric object into a POSIXct object.

# ISOdatetime(year, month, day, hour, min, sec, tz = "")
# ISOdate(year, month, day, hour = 12, min = 0, sec = 0, tz = "GMT")

time1 = ISOdatetime(2011,1,1,0,0,0)
time1
rtimes = ISOdatetime(2013, rep(4:5,5), sample(30,10), 0, 0, 0)
rtimes

# Time Series Object

# The zoo and xts packages are recommended to deal with time series objects.
#install.packages("xts")
library(xts)
x = 1:4
y = seq(as.Date('2001-01-01'), length=4, by='day')
date1 = xts(x, y)
date1

value = coredata(date1) # Extracting the Core Data of date1
coredata(date1) = 2:5
date1

time = index(date1)

# While we are using the xts package, other data manipulation methods like subset
# and aggregate still work.
x = 5:2
y = seq(as.Date('2001-01-02'), length=4, by='day')
date2 = xts(x, y)
date2

# combine datasets by columns
date3 = cbind(date1, date2)
date3
names(date3) = c('v1', 'v2')

# combine datasets by rows
date4 = rbind(date1, date2)
names(date4) = 'value'
date4

# The window function can help us extract or modify a subset of a time series object
# (as observed between defined start and end times).

window(date4, start=as.Date("2001-01-04"))
#lag() and diff() are still available
lag(date2)
diff(date2) 


# Case Study: Exploring Stock Data ----------------------------------------

install.packages("quantmod")
library(quantmod)
options(getSymbols.auto.assign=FALSE)
library(xts)
SSEC = getSymbols('^SSEC', src='yahoo', from='2000-01-01')
head(SSEC, 3)

# What's the day has the biggest change
# Compute the change rate, and find out the biggest change day:

data$ratio = with(data, diff(close)/close)
data.df = as.data.frame(data)
data.df[order(abs(data.df$ratio), decreasing=T), ][1:5, ] # we use absolute values here

# Is there a calendar effect? To check, we aggregate returns by month

install.packages("lubridate")
library(lubridate)
data$mday = month(data)
data
res = aggregate(data$ratio, data$mday, mean, na.rm=TRUE)
cat(format(res*100, digits=2, scientific=F))


# Case Study: Tencent QQ Data Analysis ------------------------------------

#install.packages(c("stringr","plyr"))
library(stringr)
library(plyr)
library(lubridate)
data = read.table('data/qqdata.csv', header=TRUE, sep=',',
                  stringsAsFactors=FALSE)
head(data, 3)

time = as.POSIXct(data$time, tz='GMT')
id = as.factor(data$id)
data1 = data.frame(id, time)
data1

user = as.data.frame(table(data1$id))
user = user[order(user$Freq, decreasing=T), ]
user[1:5, ]  #getting the top five chat users

data1$hour = hour(data1$time)
data1

hours = as.data.frame(table(data1$hour))
hours = hours[order(hours$Freq, decreasing=T), ]
hours

data1$wday = wday(data1$time)
wdays = as.data.frame(table(data1$wday))
wdays = wdays[order(wdays$Freq, decreasing=T), ]
wdays

# Baby names data ---------------------------------------------------------
#Remember to set your working directory.
setwd("~/Documents/NycDataScience/RDA_lecture_code")
bnames = read.csv("data/bnames.csv.bz2", stringsAsFactors = FALSE)
births = read.csv("data/births.csv", stringsAsFactors = FALSE)

# To get some basic information about the data
head(bnames,5)
tail(bnames,5)
# Q: How many observations and how many variables are contained in these two data sets?
{
# A:
dim(bnames) # 258000      5
dim(births) # 260   3
}

mike <- bnames[bnames$name == "Mike", ]
qplot(year, prop, data = mike, geom = "line")

vivian <- bnames[bnames$name == "Vivian", ]
qplot(year, prop, data = vivian, geom = "line")

qplot(year, prop, data = vivian, geom = "point")

qplot(year, prop, data = vivian, geom = "line", color = sex)

michaels <- bnames[bnames$name == "Michael" |
                     bnames$name == "Michelle", ]
qplot(year, prop, data = michaels, geom = "line",
      color = interaction(sex, name))

vivian <- bnames[bnames$name == "Vivian", ]
qplot(year, prop, data = vivian, geom = "line")


# dplyr -------------------------------------------------------------------

#install.packages("dplyr")
library(dplyr)

# Take a look at your datasets
bnames
head(bnames)

# dplyr can help you look at the datasets better,
# it provides a new data structure for R---- the Table ("tbl")

# tbl is just a special type of data.frame. 
# It knows how to display the data properly
bnames = tbl_df(bnames)
bnames 
# Note:
{
# now R would only show you part of data that fit your console
# change your window size and run the code again
}

births = tbl_df(births)
births
class(bnames)


# Subset, Transform and Reorder -------------------------------------------
# To understand each function easily, we create a simple data frame
df = data.frame(
  color = c("blue", "black", "blue", "blue", "black"),
  value = 1:5)
tbl = tbl_df(df)
tbl


# Filter ------------------------------------------------------------------

filter(tbl, color == "blue")
filter(df, value %in% c(1, 4))

# deal with baby names data 
# In the bnames dataset:
# 1.Find all of the names that are in the same soundex as the name “Vivian”.
{
vivian = filter(bnames, name == "Vivian")
vivian
vivian$soundex[1]
}
# 2. Find all of the girls born in 1900 or 2000.
{
filter(bnames, sex == "girl" & (year == 1900 | year == 2000))
}
# 3. How many times did a name reach a prop greater than 0.01 after the year 2000?
{
filter(bnames, year > 2000 & prop > 0.01)
}

# select ------------------------------------------------------------------
# The following process shows the way to take the color column out of data. 
select(tbl , color)
# We can also eliminate the color column
select(tbl, -color)
help(select)

# Some other ways you can select variable
select(bnames, soundex)
select(bnames, starts_with("sound"))
select(bnames, ends_with("ex"))
# Q: Is there any other way to select "sex" and "soundex" together?
{
# A:
select(bnames,sex,soundex)
}
# Q:Difference Between filter and select?
{
# A:
# filter: Keep rows by criteria.
# select: Pick columns by name.
}

# rename ------------------------------------------------------------------
head(
  select(iris, petal_length = Petal.Length)
)

head(
  rename(iris, petal_length = Petal.Length)
)

# Q: What is the difference between rename() and select()?
{
# A:
# rename() keeps all variables.
# select can also rename the variables in the resulting dataset:
# But select() keeps only the variables you specify.
}

# arrange -----------------------------------------------------------------

df1 = data.frame(color = c(4,1,5,3,2),
                 value = 1:5)
arrange(df1, color)
# Q: What's the default setting for arrange?
{
# A: The default is sort a variable in ascending order
arrange(df1, desc(color)) #Arranging the data in descending order.

}

# We learned to use order to sort our data 
df_order = order(df1$color) #Returns the indices for ascending order.
df1[df_order,]
# The top3 Popular name:
arrange(bnames, desc(prop))[3,]
# Q: What year was Vivian’s name the most popular?
arrange(filter(bnames, name == "Vivian"), desc(prop))[1,]

# mutate ------------------------------------------------------------------
# We can also add columns to datasets by manipulating existing variables.
mutate(tbl, double = 2 * value)
mutate(tbl, double = 2 * value, quadruple = 4 * value)

# transmute():Drops OLD variables and only retains the newly defined variables
transmute(tbl, double = 2 * value, quadruple = 4 * value)

# summarise ---------------------------------------------------------------
# Note: the name of this function is summariSe not summarize

# Use summarise() with aggregate functions, which take a vector of values, 
# and return a single number.
# In base R : min(), max(), mean(), sum(), sd(), median(), IQR().
# In dyplr: n(), n_distinct(), first(), last() and nth() 
summarise(tbl, total = sum(value))
summarise(tbl, total = sum(value), avg = mean(value))
# Exercise:
# With the vivian data frame:
# 1.Add a new column to the data that changes the prop to a percentage.
head(mutate(vivian, perc = prop * 100))
# 2.Create a summary that displays the min, mean, and max prop Vivian’s name.
summarise(vivian, 
          min = min(prop),
          mean = mean(prop),
          max = max(prop))


# Joining Data Sets -------------------------------------------------------

births
head(bnames)
head(births)
x = data.frame(
  name = c("John", "Paul", "George", "Ringo", "Stuart", "Pete"),
  instrument = c("guitar", "bass", "guitar", "drums", "bass",
                 "drums"))
y = data.frame(
  name = c("John", "Paul", "George", "Ringo", "Brian"),
  band = c("TRUE", "TRUE", "TRUE", "TRUE", "FALSE"))

# left_join: Include all of x, and matching rows of y.
left_join(x, y, by = "name") #To which column is the error referring?

# inner_join: Include rows of x that appear in y, and matching rows of y
inner_join(x, y, by = "name")

# semi_join: Include rows of x that appear in y
semi_join(x, y, by = "name")

# anti_join: Include rows of x that do not appear in y
anti_join(x, y, by = "name")

# Combine Two Data Sets
# 1. Combine bnames with births.
# 2. Add a new column that shows the number of babies whose name is the corresponding name 
#    and born in the corresponding year.

# First combine bnames with births:
bnames2 = left_join(bnames, births, by = c("year","sex"))
bnames2
# Then create a new column that shows the total number of babies born each year for each name.
bnames2 = mutate(bnames2, n = round(prop * births))
bnames2


# Groupwise Operations ----------------------------------------------------

vivian = filter(bnames2, name == "Vivian")
sum(vivian$n)

#We could have also used the summarise function.
summarise(vivian, total = sum(n))


# group_by ----------------------------------------------------------------

summarise(tbl, total = sum(value))
by_color = group_by(tbl, color) #Has a new grouped table component.
summarise(by_color, total = sum(value))

group_by(bnames2, name) #This looks very similar to bnames2; what???s different?
by_name = group_by(bnames2, name)
totals = summarise(by_name, total = sum(n))
head(totals)

group_by(bnames2, name, sex)
by_name = group_by(bnames2, name)
group_by(by_name, sex) #Does not yield what we really wanted...

name_sex = group_by(bnames2, name, sex)
totals2 = summarise(name_sex, total = sum(n))
head(totals2)

by_name_sex = group_by(bnames2, name, sex)
ungroup(by_name_sex)

by_soundex = group_by(bnames2, soundex)
stotals = summarise(by_soundex, total = sum(n))
stotals

arrange(stotals, desc(total))

j500 = filter(bnames, soundex == "J500")
unique(j500$name)

year_sex = group_by(bnames2, year, sex)
ytotals = summarise(year_sex, births = sum(n))
ytotals

year_sex = group_by(bnames2, year, sex)
ranks = mutate(year_sex, rank = rank(desc(prop)))
ranks

ones = filter(ranks, rank == 1)
ones = select(ones, year, name, sex)
unique(ones$name)

arrange(summarise(group_by(ones, name), count = n()), desc(count))


arrange(summarise(group_by(ones, name), count = n()), desc(count))
#Or...
group_by(ones,name) %>% 
  summarise(.,count=n()) %>% 
  arrange(.,desc(count))


bnames3 = select(bnames2,-soundex) #Dropping the soundex column.
name_sex = group_by(bnames3, name, sex)
name_sex

bnames3 = select(bnames2,-soundex)
name_sex = group_by(bnames3, name, sex)
summary1 = summarise(name_sex, total = sum(n))
summary1 #Summarises first by going across the sex group.

bnames3 = select(bnames2,-soundex)
name_sex = group_by(bnames3, name, sex)
summary1 = summarise(name_sex, total = sum(n))
summary2 = summarise(summary1, total = sum(total))
summary2 #Summarises second by going across the name group.

bnames3 = select(bnames2,-soundex)
name_sex = group_by(bnames3, name, sex)
summary1 = summarise(name_sex, total = sum(n))
summary2 = summarise(summary1, total = sum(total))
summary3 = summarise(summary2, total = sum(total))
summary3 #Summarises by compressing the remaining information.



# Summary -----------------------------------------------------------------

browseVignettes(package = "dplyr")
