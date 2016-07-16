
##### RDA 2. Raw Code ######

# In-depth Study of Data Objects ------------------------------------------
int <- c(1L, 2L, 4L)
int
typeof(int)

text <- c("Hello", "World")
text
typeof(text)

logic<-1:3>=3:1
logic
typeof(logic)


vector1 = seq(2, 10, by=2) 
vector2 = 1:10 + 2
vector3 = 1:(10 + 2)



n = 100
w = pi/n
x = seq(from = 0, to = pi, length = n)
rect = sin(x) * w
sum(rect)

group1 = rep(1:3, times=c(8, 10, 9))
group2 = factor(group1)
class(group1)
class(group2)

# exercise
### group: 1,1,1,1,2,2,2,2,2,3,3,3
### score: 100,92,75,82,NA,90,72,98,60,78,93,67

set.seed(0)
vec_logic = c(TRUE, TRUE, TRUE, FALSE)
vec_char = c('A', 'B', 'C', 'D') 
vec_num1 = runif(5)
vec_char2 = sample(c('A', 'B'), size=10, replace=TRUE)
vec_num2 = numeric(10) #10-item zero vector 
vec_logic; vec_char2; vec_num2

set.seed(0)
vector = rnorm(10)
vec_max = max(vector)
vec_min = min(vector)
vector_trimmed = vector[vector < vec_max & vector > vec_min]
vec_mean = mean(vector_trimmed)
vec_mean

vector = 1:12
my_matrix = matrix(vector, nrow = 3, ncol = 4, byrow = F) #Default.
my_matrix
dim(vector) = c(4, 3)
vector

set.seed(0)
vector1 = vector2 = vector3 = rnorm(3)
my_matrix = cbind(vector1, vector2, vector3)
vector1
my_matrix

my_mat = matrix(1:9,3,3)
my_mat

my_mat[1:2, ]

a = array(1:8, dim = c(2, 2, 2))
a

city = c('Seattle', 'Chicago', 'Boston', 'Houston')
temp = c(78, 74, 50, 104)
data = data.frame(city, temp)

data[ ,1]
data[ ,'city']
data$city

data = data.frame(city, temp, stringsAsFactors = F)
data$city = factor(data$city)

ave = mean(data$temp)
data[data$temp > ave, ]

data = data.frame(city, temp)
summary(data)

dim(data)
head(data)
str(data)

order(data$temp)
data[order(data$temp), ]
data[order(data$temp, decreasing=TRUE), ][1:2, ]

temp = c(27, 29, 23, 14, NA)
mean(temp)
mean(temp, na.rm=TRUE)

temp = c(27, 29, 23, 14, NULL)
length(temp)

people.list$tabular.data = NULL

sapply(iris[ ,1:4], function(x) sd(x)/mean(x))
mylist = as.list(iris[ ,1:4])
sapply(mylist, mean)

lapply(mylist, mean)
myfunc = function(x) {
  ret = c(mean(x), sd(x))
  return(ret)
}
result = lapply(mylist, myfunc)
result
result.matrix = t(as.data.frame(result))
colnames(result.matrix) = c("mean", "sd")
result.matrix

set.seed(1)
vec = round(runif(12) * 100)
mat = matrix(vec, 3, 4)
apply(mat, 1, sum) #Applying across the rows.

apply(mat, 2, function(x) max(x)-min(x)) #Applying across the columns.
tapply(X = iris$Sepal.Length, INDEX=list(iris$Species), FUN=mean)
with(iris, tapply(X = Sepal.Length, INDEX=list(Species), FUN=mean))
with(iris, aggregate(Sepal.Length, by = list(Species), mean))


# Control Statements ------------------------------------------------------

num = 5
if (num %% 2 != 0) {
  cat(num, 'is odd')
}

num = 4
if (num %% 2 != 0) {
  cat(num, 'is odd')
} else {
  cat(num, 'is even')
}

if (num %% 2 != 0) {
  cat(num, 'is odd')
} else if (num == 0) {
  cat(num, 'is even, although many people do not realize it.')
} else {
  cat(num, 'is even')
}

num = 1:6
ifelse(num %% 2 == 0, yes='even', no='odd')

set.seed(0)
age = sample(0:100, 20, replace=TRUE)
res = ifelse(age > 70, 'old', ifelse(age <= 30, 'young', 'mid'))
res

age[1]

age_group = cut(age, breaks=c(0,30,70,100), labels=FALSE) #Returns integers.
age_group
switch(age_group[1], 'young', 'middle', 'old')

age_type = 'middle'
switch(age_type,
       young = age[age <= 30],
       middle = age[age <= 70 & age > 30]  ,
       old = age[age > 70]
)

campaign_data = read.csv('data/campaign_contributions.csv', header=TRUE)
campaign_data = campaign_data[campaign_data$AMNT > 0, ]
summary(campaign_data$AMNT)

str(campaign_data$CANDID)

id = "BB"  #Bloomberg.
size = "platinum"
data = campaign_data[campaign_data$CANDID == id, ]
switch(size,
       "bronze" = nrow(data[data$AMNT <= 50, ])/nrow(data),
       "silver" = nrow(data[data$AMNT <= 250 & data$AMNT > 50, ])/nrow(data),
       "gold" = nrow(data[data$AMNT <= 500 & data$AMNT > 250, ])/nrow(data),
       "platinum" = nrow(data[data$AMNT > 500, ])/nrow(data)
)

sign_data = read.csv('data/TimesSquareSignage.csv', header=TRUE)
obs = nrow(sign_data)
for (i in 1:obs) {
  if (is.na(sign_data$Width[i])) {
    cat('WARNING: Missing width for sign no.', i, '\n')
  }
}


i = 1
while (i <= obs) {
  if (is.na(sign_data$Width[i])) {
    cat('WARNING: Missing width for sign no.', i, '\n')
  }
  i = i + 1
}

i = 1
nas = which(is.na(sign_data$Width))
while (i < 6) {
  cat('WARNING: Missing width for sign no.', nas[i], '\n')
  i = i + 1
  if (i > 5) {
    cat('WARNING: Turned up more than 5 missing values')
  }
}

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

findprime = function(x) {
  if (x %in% c(2, 3, 5, 7)) return(TRUE)
  if (x %% 2 == 0 | x == 1) return(FALSE)
  xsqrt = round(sqrt(x))
  xseq = seq(from = 3, to = xsqrt, by = 2)
  if (all(x %% xseq != 0)) return(TRUE)
  else return(FALSE)
}

system.time({
  x1 = c()
  for (i in 1:1e4) {
    y = findprime(i)
    x1[i] = y
  }
})

system.time({
  x2 = logical(1e4)
  for (i in 1:1e4) {
    y = findprime(i)
    x2[i] = y
  }
})

system.time({
  sapply(1:1e4, findprime)
})

i = 2
x = 1:2
while (x[i] < 1e3) {
  x [i+1] = x[i-1] + x[i]
  i = i + 1
}
x = x[-i]
print(x)


# Functions ---------------------------------------------------------------

calc_area = function(r) {
  area = pi*r^2
  return(area)
}
calc_area(4)

DegreesToRadians = function(d) {
  valueInRadians = d * pi / 180
  return(valueInRadians)
}
DegreesToRadians(145)

ConeVolume = function(r, h) {
  volume = pi * r^2 * (h / 3)
  return(volume)
}
ConeVolume(2, 5)

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
SDcalc(1:10); SDcalc(1:10, type='population')

SDcalc = function(x, type = 'sample') {
  stopifnot(is.numeric(x), length(x) > 0,
            type %in% c('sample', 'population'))
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

test = c(1:10, NA)
SDcalc(test, type='sample')

SDcalc(test, type='sample', na.rm=TRUE)

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

which_generation = Vectorize(which_generation)
which_generation(years)

a <- c('NPR', 'New York Times', 'MSNBC')
b <- c('Wall Street Journal', 'NPR', 'Fox News')

'%int%' = function(x, y) {
  intersect(x, y)
}
a %int% b

c = c('Salon', 'The Onion', 'NPR')
a %int% b %int% c

news_list = list(a, b, c)
Reduce('%int%', news_list)


# Data Transformation Overview --------------------------------------------
# Subset
#Three different ways to do the exact same thing!
data_sub = iris[iris$Species=='setosa', 3:5]
data_sub1 = subset(iris, Species=='setosa', 3:5)
data_sub2 = with(iris, iris[Species=='setosa', 3:5])
head(data_sub, 1); head(data_sub1, 1); head(data_sub2, 1)
#Transform
#The transform() function can be used to create a new column in an existing dataset.
iris_tr = transform(iris, v1=log(Sepal.Length))
head(iris_tr, 1)
#Equivalent:
iris_tr1 = iris
iris_tr1$v1 = log(iris$Sepal.Length)
head(iris_tr1, 1)
# Discretize
#The cut() function can be used to transform a numeric variable into a categorical variable.
groupvec = quantile(iris_tr$v1, c(0, 0.25, 0.50, 0.75, 1.0))
labels = c('A', 'B', 'C', 'D')
iris_tr$v2 = cut(iris_tr$v1, breaks=groupvec, labels=labels, include.lowest=TRUE)

groupvec
iris_tr[c(1,6), ]
# Set Levels of a Factor
vec = rep(c(0,1), c(4,6))
vec
#Converting to a factor and creating the labels/levels all at once.
vec_fac
vec_fac = factor(vec, labels=c('male','female'))
#First converting to a factor.
vec1 = factor(rep(c(0,1,3), c(4,6,2)))
vec1
#Then creating the labels/levels.
levels(vec1) = c("male", "female", "male")
vec1
vec2 = factor(rep(c('b','a'), c(4,6)))
vec2
levels(vec2)
relevel(vec2, ref='b') #Changing the reference level.


# Data Reshape ------------------------------------------------------------

data = iris[, 1:4] #A wide dataset; columns are variables, rows are observations.
head(data, 5)

# Use the stack() function to reshape to long form; use unstack() for wide form. 
data_l = stack(data) #A long dataset; treats all elements as pieces of data.
data_w = unstack(data_l) #A wide dataset; columns are variables, rows are obs.
str(data_l); str(data_w)

#Let's take the last two columns of iris and reshape them to wide form.
subdata = iris[ ,4:5] #This subset of the overall data is in long form.
subdata[c(1,51, 101), ]
subdata_w = unstack(subdata) #Each factor becomes a column in the wide form.
head(subdata_w, 1)

# reshape2
install.packages("reshape2")
library(reshape2)                  #Cast long format to wide format.
dcast(data=subdata,             #Specifying the data to manipulate.
      formula=Species ~ .,      #Species should be the main column; nothing else.
      value.var='Petal.Width',  #Values to fill in should come from Petal.Width.
      fun=mean)                    #Aggregate the values by the mean.

iris_long = melt(data=iris,         #Melt wide format to long format.
                 id.vars ='Species')           #The main identification variable is Species.
set.seed(5)
i = sample(nrow(iris_long), 5)
iris_long[i, ]

dcast(data=iris_long,                  #Specifying the data to manipulate.
      formula=Species ~ variable,  #Species is main col.; swing variable col.
      value.var = 'value',               #Values to fill in should come from value col.
      fun=mean)                           #Aggregate the values by the mean.
#In-class exercise using Tips dataset
dcast(tips, sex ~ ., value.var='tip', fun=mean)
dcast(tips, sex ~ size, value.var='tip', fun=mean)
dcast(tips, sex ~ . , value.var='total_bill', fun=mean)


# Split and Combine Data --------------------------------------------------

datax = data.frame(id=c(1,2,3), gender=c('M', 'F', 'M'))
datay = data.frame(id=c(3,1,2), name=c('tom','john','mary'))
datax; datay
merge(datax, datay, by='id')

iris_split = split(iris, iris$Species)
class(iris_split)
attributes(iris_split)
str(iris_split)

iris_unsplit <- unsplit(iris_split, iris$Species)
class(iris_unsplit)
iris_unsplit[c(1,51, 101), ]
#Split Example
library(reshape2) #Not using the reshape2 functions, just want the tips dataset.
tips
tips_by_sex = split(tips, tips$sex)
head(tips_by_sex[[1]], 2)
ratio_fun = function(x) {
  sum(x$tip) / sum(x$total_bill)
}
result = lapply(tips_by_sex, ratio_fun)
result


# Character Manipulation --------------------------------------------------
fruit = 'apple orange grape banana'
nchar(fruit)

split.string.list = strsplit(fruit, split=' ')
split.string.list
fruitvec = unlist(split.string.list)
fruitvec

paste(fruitvec, collapse = ' ')
paste(fruitvec, collapse=',')
paste(fruitvec, 'extra')
paste(fruitvec, 'extra', sep = '.')

n = 1:20
xvar = paste('x', n, sep = '')
right = paste(xvar, collapse = ' + ')
left = 'y ~'
my_formula = paste(left, right)
my_formula

substr(fruit, 1, 5)
substr(fruit, 1, 7)
substr(fruit, 9, 21)

gsub('apple', 'strawberry', fruit)
gsub('a', '?', fruit)
gsub('an', 'HA', fruit)

grep('grape', fruitvec)
grep('a', fruitvec)
grep('an', fruitvec)


# Case Study: Exploring CRAN ----------------------------------------------

#get packages table
#install.packages("XML")
library(XML)
web = 'http://cran.r-project.org/web/packages/available_packages_by_name.html'
packages = readHTMLTable(web, stringsAsFactors = FALSE)

pnames = packages[[1]][ ,1]
length(pnames)

pnames = pnames[2:11]
b = 'http://cran.r-project.org/web/packages/'
a = '/index.html'
urls = paste0(b, pnames, a)

table = readHTMLTable(urls[1], stringsAsFactors=FALSE, header=FALSE)
info = table[[1]]
paste0(info$V1, info$V2)

tables = lapply(urls, readHTMLTable, stringsAsFactors=FALSE, header=FALSE)
infos = lapply(tables, function(x) x[[1]])
infovec = lapply(infos, function(x) paste0(x$V1, x$V2))

aname = lapply(infovec, function(x) x[grep('Author:', x)])
anamevec = lapply(aname, function(x) substr(x, 8, nchar(x)))
anamevec = unlist(anamevec)
name.df = data.frame(pnames, anamevec)


# Manipulating Dates and Timestamps ---------------------------------------
date1 = '1989-05-04'
date1 = as.Date(date1)
class(date1)

date1 = '05/04/1989'
date1 = as.Date(date1, format='%m/%d/%Y')

date2 = date1 + 31
date2 - date1

date2 > date1

Sys.Date() - structure(0, class='Date')

dates = seq(date1, length=4, by='day')
format(dates, '%w')

weekdays(dates)

time1 = ISOdatetime(2011,1,1,0,0,0)
rtimes = ISOdatetime(2013, rep(4:5,5), sample(30,10), 0, 0, 0)

#install.packages("xts")
library(xts)
x = 1:4
y = seq(as.Date('2001-01-01'), length=4, by='day')
date1 = xts(x, y)

value = coredata(date1)
coredata(date1) = 2:5
time = index(date1)

x = 5:2
y = seq(as.Date('2001-01-02'), length=4, by='day')
date2 = xts(x, y)
date3 = cbind(date1, date2)
names(date3) = c('v1', 'v2')
date4 = rbind(date1, date2)
names(date4) = 'value'

window(date4, start=as.Date("2001-01-04"))
#lag() and diff() are still available
lag(date2)
diff(date2) 


# Case Study: Exploring Stock Data ----------------------------------------

#install.packages("quantmod")
library(quantmod)
options(getSymbols.auto.assign=FALSE)
library(xts)
SSEC = getSymbols('^SSEC', src='yahoo', from='2000-01-01')
head(SSEC, 3)

data$ratio = with(data, diff(close)/close)
data.df = as.data.frame(data)
data.df[order(abs(data.df$ratio), decreasing=T), ][1:5, ]

#install.packages("lubridate")
library(lubridate)
data$mday = month(data)
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

user = as.data.frame(table(data1$id))
user = user[order(user$Freq, decreasing=T), ]
user[1:5, ]  #getting the top five chat users

data1$hour = hour(data1$time)
hours = as.data.frame(table(data1$hour))
hours = hours[order(hours$Freq, decreasing=T), ]
data1$wday = wday(data1$time)
wdays = as.data.frame(table(data1$wday))
wdays = wdays[order(wdays$Freq, decreasing=T), ]


# Accessing Databases -----------------------------------------------------

#install.packages(c("DBI","RSQLite","learningr"))
library(DBI)
library(RSQLite)
driver = dbDriver("SQLite")
db_file = system.file("extdata", "crabtag.sqlite", package="learningr")
conn = dbConnect(driver, db_file)
query = "SELECT count(*) FROM Daylog"
(id_block = dbGetQuery(conn, query))

dbDisconnect(conn)


# Getting Data from Web ---------------------------------------------
install.packages(c("RCurl","RJSONIO"))
library(RCurl)
library(RJSONIO)
#the 'mykey' variable might need to be changed; create your own if it doesn't work
mykey = 'a98d04ac43156c84'
url = paste0('http://api.wunderground.com/api/', 
             mykey, '/conditions/forecast/q/autoip.json')
print(url)

fromurl = function(finalurl) {
  web = getURL(finalurl)
  raw = fromJSON(web)
  high = raw$forecast$simpleforecast$forecastday[[2]]$high['celsius']
  low = raw$forecast$simpleforecast$forecastday[[2]]$low['celsius']
  condition = raw$forecast$simpleforecast$forecastday[[2]]$conditions
  currenttemp = raw$current_observation$temp_c
  currentweather = raw$current_observation$weather
  city = as.character(raw$current_observation$display_location['full'])
  result = list(city=city, current=paste(currenttemp, '°C ',
                                         currentweather, sep=''), 
                tomorrow=paste(low, '-', high,'°C ', condition, sep=''))
  names(result) = c('city', 'current', 'tomorrow')
  return(result)
}

fromurl(url)

library(XML)
url = 'http://mirrors.ustc.edu.cn/CRAN/web/packages/available_packages_by_date.html' 
tables = readHTMLTable(url,
                       stringsAsFactors=FALSE,
                       header=TRUE)
data = tables[[1]]
data[2,]

res = nchar(data[,2])
hist(res, main="R Package Name Length", xlab="Length")

library(XML)
url = "http://www.w3schools.com/xml/plant_catalog.xml"
xmlfile = xmlTreeParse(url)  #download and parse XML
xmltop = xmlRoot(xmlfile)    #get root node
xmlValue(xmltop[[10]][[1]])  #get leaf node data

xmlValue(xmltop[['PLANT']][['COMMON']])  #get data from children of 'xmltop'

xmlSApply(xmltop[[1]], xmlValue)  #get data from each child of XML nodes

plantcat = xmlSApply(xmltop, function(x) xmlSApply(x, xmlValue)) 
plantcat_df = data.frame(t(plantcat),row.names=NULL) 
plantcat_df[1:5,1:4]


###Review of shawshank redemption.

library(RCurl)
library(XML)
url = 'http://www.imdb.com/title/tt0111161/criticreviews?ref_=tt_ov_rt'
raw = getURL(url)
data = htmlParse(raw)
xpath = '//tr[@itemprop="reviews"]/td[2]/div'

### return all the rows that have these attributes
## td[2] gives the second element
### div gives me all the div
nodes = getNodeSet(data, xpath)
text = sapply(nodes, xmlValue)
text
class(text)


