################################################
###Question 1: The top 250 movies from IMDB. ###
################################################

# install.packages(c("RCurl","XML"))
library(RCurl)
library(XML)
library(dplyr)
library(RJSONIO)

url     <- 'http://www.imdb.com/chart/top?ref_=ft_250'
raw     <- getURL(url)
data    <- htmlParse(raw)
top_250 <- readHTMLTable(url, which = 1,stringsAsFactors = FALSE)


### Split year, rank and title.
names(top_250)[names(top_250)=="Rank & Title"] <- "title_bad"
names(top_250)[names(top_250) == "IMDb Rating"] <- "rating"
top_250$rank <- sub("\\..*", "", top_250$title_bad)
top_250$year <- sub("\\).*", "", sub(".*\\(", "", top_250$title_bad)) 
top_250$title <- sub("\\(.*", "", sub(".*\\.","", top_250$title_bad))

### Make dataset to have only rank, title, year and rating.
top_250 <- top_250[, c("rank", "title", "year", "rating")]


#####################################################
### Question 2.1: Years with most top 250 movies ###
#####################################################
### Two ways to do it.
### Method #1:
top_years <- aggregate(top_250$year, by = list(top_250$year), length)
colnames(top_years) <- c("year","count")
top_years <- arrange(top_years, desc(count))
head(top_years)


### Method #2:
by_years <- group_by(top_250, year)
year_count <- summarise(by_years, count = n())

### year count
### 1 1995     9
### 2 1957     8
### 3 2001     7
### 4 2014     7
### 5 2015     7
### 6 2000     6

year_count_d <- arrange(year_count, desc(count))
head(year_count_d)

### year count
### (chr) (int)
### 1 1995     9
### 2 1957     8
### 3 2001     7
### 4 2014     7
### 5 2015     7
### 6 2000     6

#################################################
### Question 2.2: give the average of all 
### of the ratings, and average of 5 year spans 
#################################################

####Average of all ratings in dataset
top_250$rating <- as.numeric(top_250$rating)
mean(top_250$rating)

###[1] 8.2584

min(top_250$year)
### [1] "1921"
max(top_250$year)
### [1] "2016"
### Average rating by 5 year span
top_250$year_group <- cut(as.numeric(top_250$year), seq(1921, 2016, by = 5), 
                      dig.lab = 5, include.lowest = TRUE)

by_year_grp <- group_by(top_250, year_group)
year_group_mean <- summarise(by_year_grp, mean_rating = mean(rating))

#########################################################
### Question 2.3: histogram of movies in 5 year spans ### 
#########################################################

year_group_count <- summarise(by_year_group, count = n())
hist(year_group_count$year_group,  include.lowest = TRUE)

year_groups <- top_250$year_group
library(ggplot2)
barplot(table(year_groups), main = "barplot")


##############################################################
### Question 3: Name, plot and awards of my favorite movie ###
##############################################################

url <- "http://www.omdbapi.com/?t=my+cousin+vinny&y=1992&type=movie"
favorite <- getURL(url)
favorite_parse<-fromJSON(favorite)
favorite_movie <- as.data.frame(t(favorite_parse))

### {"Title":"My Cousin Vinny","Year":"1992", 

### "Plot":"Two New Yorkers are accused of murder in rural Alabama
### while on their way back to college, and one of their cousins--
### an inexperienced, loudmouth lawyer not accustomed to Southern rules
### and manners--comes in to defend them."

### "Awards":"Won 1 Oscar. Another 3 wins & 2 nominations."

############################################
### Question 4: 40 Movies of the top 250 ###
############################################

test <- sample_n(top_250,1)
test_title <- test$title
test_year <- test$year


trim<- function(x) {
  y <- gsub("^\\++|\\++$", "", x)
  y <- gsub("^\\s+|\\s+$", "", y)
  y <- gsub(" ","+", y)
  y <- gsub("^\"", "",y)
}

good_title <- trim(test_title)

url <- paste0("http://www.omdbapi.com/?t=",good_title,"&y=",test_year,"&type=movie")

### THIS IS WHERE I LEFT OFF.  NEED TO CREATE LOOP.




### I DON'T THINK I NEED ANY OF THIS.
raw = getURL(url)
data = fromJSON(raw)
webpage <- readLines(tc <- textConnection(data)); close(tc)
data2 <- as.data.frame(webpage)

pagetree <- htmlTreeParse(webpage, error=function(...){}, useInternalNodes = TRUE)

data <- as.character(gsub(".*{","",data))
test_df <- readHTMLTable(pagetree, which = 1,stringsAsFactors = FALSE)

xpath = '//tr[@itemprop="reviews"]/td[2]/div'
nodes = getNodeSet(data, xpath)
text = sapply(nodes, xmlValue)
text


### I cannot do this, and therefore cannot do the rest of the homework.