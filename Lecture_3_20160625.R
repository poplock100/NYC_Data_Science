### How to store data as date?
### use as.Date() to create date class object.

date1 <- "1989-05-04"
class(date1)
### [1] "character"

date1 <- as.Date(date1)
class(date1)
### [1] "character"

### to change format:
date1 <- "05/04/1989"
date1 <- as.Date(date1, format = "%m/%d/%Y")
date1

date2 <- date1+31


time1 <- "1969-02-28"
time1 <- as.POSIXct(time1)
time1


time1 <- "2011-03-11 01:30:00"
time1 <- as.POSIXct(time1)
time2 <- seq(from=time1, to = Sys.time(), by = "months")
time2

###ISOdatetime funtion can convert numeric to date.
### ISOdatetime(year, month, day, hour, min, sec, tz)
time1 <- ISOdatetime(2017,06,24,0,0,0)
time1

set.seed(0)
rtimes <- ISOdatetime(2013, rep(4:5), sample(30,10))

### zoo and xts packages are recommended to deal with time serious objects
### install.packages("xts")
library(xts)
x <- 1:4
y  <- seq(as.Date("2001-06-15"), length = 4, by = "day")
date1 <- xts(x,y)
date2 <- data.frame(x,y)
date2

### x          y
### 1 1 2001-06-15
### 2 2 2001-06-16
### 3 3 2001-06-17
### 4 4 2001-06-18

### So, xts is better because dataframe doesn't really work here.


### coredata extracts the core data of the date.
value <- coredata(date1)
value

### [,1]
### [1,]    1 
### [2,]    2
### [3,]    3
### [4,]    4

coredata(date1) = 2:5
date1

### [,1]
### 2001-06-15    2
### 2001-06-16    3
### 2001-06-17    4
### 2001-06-18    5

time <- index(date1)
time

y <- seq(as.Date("2001-06-18"), length = 4, by = "day")
date2 <- xts(x,y)

class(date2)

### Combine datasets by columns
date3 <- cbind(date1, date2)
date3

###             ..1 ..2
###  2001-06-15   2  NA
###  2001-06-16   3  NA
###  2001-06-17   4  NA
###  2001-06-18   5   1
###  2001-06-19  NA   2
###  2001-06-20  NA   3
###  2001-06-21  NA   4

date3 <- cbind(date1,date2)

names(date3 = c("V1","V2"))


### Combine datasets by rows.
 date4 <- rbind(date1, date2)
 names(date4) <- "value"
 
 
### The window function can help us extract or modify a series of dates.
 window(date4, start = as.Date("2001-01-04"))
 
 
 ## lag() and diff()
 lag(date2)
 ### [,1]
### 2001-06-18   NA
 ###  2001-06-19    1
 ###  2001-06-20    2
 ###  2001-06-21    3
 
 diff(date2)
 
 
 ### [,1]
 ### 2001-06-18   NA
 ### 2001-06-19    1
 ### 2001-06-20    1
 ### 2001-06-21    1
 
 
 ### Exploring stock data
 ### install.packages("quantmod")
 library(quantmod)
 options(getSymbols.auto.assign=FALSE)
 library(xts)
 SSEC <- getSymbols("^SSEC", src = "yahoo", from = "2000-01-01")
 data <- SSEC
data$close <- SSEC$SSEC.Close
 ###Compute teh change rate, and find out the biggest change day:
 
 data$ratio <- with(data, diff(close)/close)
 data.df <- as.data.frame(data)
 data.df[order(abs(data.df$ratio), decreasing = T), ] [1:5,]

 
 ###Is there a calendar effect?
 ### install.packages("lubridate")
 library(lubridate)
 data$mday <- month(data)
 res <- aggregate(data$ratio, data$mday, mean, na.rm = TRUE)
 cat(format(res*100, digits = 2, scientific = FALSE))
 
 #############Accessing databases
 ### There are many data base management systems (DBMS) for working with
 ### relational databases, and R can connect to the common ones.
 
 install.packages(c("DBI","RSQLite", "learningr"))
 library(DBI)
 library(RSQLite)
 driver <- dbDriver("SQLite")
 db_file <- system.file("extdata", "crabtag.sqlite", package="learningr")
 conn <- dbConnect(driver, db_file)
 conn
 query <- "SELECT count(*) FROM Daylog"
 (id_block = dbGetQuery(conn,query))
 
 dbDisconnect(conn)
 
 
 ###Data from Websites.
 
 ###Different 
 ###install.packages(c("RCurl","RJSONIO"))
 
 ###missed a whole bunch
 mykey = "a98d04ac4156c84"
 url <- paste0("http://apiwunderground.com/api/", mykey, "/conditions/forecast/q/autoip.json")
 ###tons missing
 
library(XML)
# install.packages("XML")
 
 
 
 
 
 ###Babynames data
 bnames = read.csv("bnames.csv", stringsAsFactors = FALSE)
 births = read.csv("births.csv", stringsAsFactors = FALSE)

 alison <- bnames[bnames$name == "Alison",]
 qplot(year, prop, data = alison, geom ="line" )
 
 
 ################################
 ### dplyr
 
 install.packages("dplyr")
 library(dplyr)
 bnames
 head(bnames)
 
 tbl_df(bnames)
 ###shows df in console and also shows which class each variable is.
 
 # Subset, Transform and Reorder -------------------------------------------
 
 df = data.frame(
   color = c("blue", "black", "blue", "blue", "black"),
   value = 1:5)
 tbl = tbl_df(df)
 
 filter(tbl, color == "blue")
 
### Source: local data frame [3 x 2]
 
 ###color value
 ###(fctr) (int)
 ###1   blue     1
 ### 2   blue     3
 ### 3   blue     4
 
 filter(df, value%in%c(1,4))
### color value
### 1  blue     1
### 2  blue     4
 
 ###Filters based on conditions, but SELECTS BY ROW.
 ### i.e. get entire observation.
 
 ### In the bnames dtatset:
 ### Find all the names in same soundex as "Vivian".
 
 vivan <- filter(bnames, name == "Vivian")
 vivan$soundex[1]
 ### [1] "V150"
 
 filter(bnames, soundex == "V150")
 ##Can put all together at once (not working)
 filter(bnames, name == "Vivian"& soundex == vivian$soundex)
 
 ### Final all girls born in 1900 or 2000.
 filter(bnames, sex == "girl" & (year == 1900 | year == 2000))
 
 ### Sex = boy, name = helen
 filter(bnames, sex== "boy" & name == "Helen")
 
 ### How many times did a name reach a prop  >0.01
 filter(bnames, year >2000 & prop >0.01)
 
 ###Select
 color_col <-select(tbl, color)
 ### This will give the column named "color" and all its data.
 
 ### Can also use to remove column:
 value_col <- select(tbl, -color)
 
 ###Select
 select(tbl, color)
 select(tbl, -color)
 
 help(select)
 
 ### Can find variable names using "starts_with", "ends_with", and "contains")
 select(bnames, soundex)
 select(bnames, starts_with("sound"))
 
 ### Can selct more than one at a time:
 select(bnames, soundex, sex, year)
 select(bnames, ends_with("ex"))
 
 ###rename
 ### rename(df, old = new)
 
 ##arrange
 ## sorts data by specified column
 df1 <- data.frame(color = c(4,1,5,3,2), value = 1:5)
 arrange (df1, color)
 arrange (df1, desc(color))
 
 ###Top 3 most popular names:
 
 arrange(bnames, desc(prop))[1:3,]
 
 ###What year was Alison's name the most popular?
 arrange(filter(bnames, name == "Alison"), desc(prop))
 
alison <- filter(bnames, name == "Alison")
arrange(alison, desc(prop))[1,]

summarise(alison, tot_count= n())
 

###Change prop to percentage in new column
mutate(alison, perc = prop*100)

### Create summary min, mean and max prop
summarise(alison, min = min(prop), max = max(prop), mean = mean(prop), count = n())

filter(alison, year== 1969)


###Combining datasets

x = data.frame(
  name = c("John", "Paul", "George", "Ringo", "Stuart", "Pete"),
  instrument = c("guitar", "bass", "guitar", "drums", "bass",
                 "drums"))
y = data.frame(
  name = c("John", "Paul", "George", "Ringo", "Brian"),
  band = c("TRUE", "TRUE", "TRUE", "TRUE", "FALSE"))

xy <- merge(x,y, by = "name", all.x = TRUE)
xy <- left_join(x,y,by = "name")

### Find all names ...

bnames2 <- left_join(bnames, births, by = c("year", "sex"))
bnames2

bnames2 <- mutate(bnames2, n = round(prop*births))
bnames2

by_color <- group_by(tbl, color)
by_color

summarise(by_color, total = sum(value))

by_name <- group_by(bnames2, name)
totals <- summarise(by_name, total = sum(n))
totals

group_by(bnames2, name, sex)
group_by(bnames2, sex, name)

name_sex <- group_by(bnames2, name, sex)
totals2 <- summarise(name_sex, n())
totals2

### Calculate total number of babies in each soundex
by_soundex <- group_by(bnames2, soundex)
tot_babies <- summarise(by_soundex, tot_babies = sum(n))
tot_babies


###Sort by soundex
sorted<-arrange(tot_babies, desc(tot_babies))
sorted  


bnames3 <- select(bnames2, -soundex)
name_sex <- group_by(bnames3,name, sex)
summary1 <- summarise(name_sex, total = sum(n))
name_sex
summary1
summary2 <- summarise(summary1, total = sum(total))
summary3 <- summarise(summary2, total = sum(total))
summary2
summary3
