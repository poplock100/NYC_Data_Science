# Homework 3
# Problem 1
# Use whatever method of web scraping you think is appropriate 
# to get all the names of the top 250 movies, their ratings, 
# and their year of release.
library(bitops)
library(RCurl)
library(XML)
library(dplyr)
library(ggplot2)
url <- "http://www.imdb.com/chart/top"
raw <- getURL(url)
data <- htmlParse(raw)

xtitle <- '//td[@class = "titleColumn"]/a'
xyear <- '//td[@class="titleColumn"]/span'
xrate <- '//td[@class="ratingColumn imdbRating"]/strong'

title <- getNodeSet(data, xtitle)
year <- getNodeSet(data, xyear)
rate <- getNodeSet(data, xrate)

title.text <- sapply(title, xmlValue)
year.text <- sapply(year, xmlValue)
rate.text <- sapply(rate, xmlValue)

#remove the "()" of the year
year.text <- substr(year.text, 2, 5)

top250 <- data.frame(title = title.text, year = year.text, rating = rate.text, stringsAsFactors = F)

# Problem 2
# What years produced more of the top 250 movies?
sort(table(top250$year), decreasing = TRUE)
# 1995 1957 2003 2014 1994 2000 2001 2004 2009 2010 
# 10    7    7    7    6    6    6    6    6    6

# Give the average of all the ratings, 
# and the average per 5 year span.
class(top250$rating)
# character
top250$rating <- as.numeric(top250$rating)
mean(top250$rating, na.rm = TRUE)
# [1] 8.2612

top250$year <- as.numeric(top250$year)
summary(top250$year)
#    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
#    1921    1962    1988    1982    2003    2015 

yearcut <- seq(min(top250$year), max(top250$year)+1, by = 5)
top250$period <- cut(top250$year, yearcut, include.lowest = TRUE)

rate.5years <- group_by(top250, period) %>% summarise(., average = mean(rating), count = n())
summary(rate.5years$average)
hist(top250$year, breaks = yearcut)

# Problem 4
library(RCurl)
library(RJSONIO)
movie_name = "Fight Club"
year.string = as.character(top250$year[top250$title == "Fight Club"])
url_encoded_movie_name = URLencode(paste0("www.omdbapi.com/?t=", movie_name, '&y=', year.string, '&type=movie&tomatoes=true'))
print(url_encoded_movie_name)
# [1] "www.omdbapi.com/?t=Fight%20Club&y=1999&type=movie&tomatoes=true"

web = getURL(url_encoded_movie_name)
raw = fromJSON(web)
raw[c("Title","Plot", "Awards")]

# Problem 5
title = c()
year = c()
rated = c()
released = c()
runtime = c()
genre = c()
director = c()
writer = c()
actors = c()
plot = c()
language = c()
country = c()
awards = c()
poster = c()
metascore = c()
imdbRating = c()
imdbVotes = c()
imdbID = c()
tomatoMeter = c()
tomatoRating = c()
tomatoFresh = c()
tomatoRotten = c()
tomatoUserMeter = c()
tomatoUserRating = c()
tomatoUserReviews = c()
production = c()
for (i in 1:40) {
  movie_name = top250$title[i]
  year.string = as.character(top250$year[i])
  url_encoded_movie_name = URLencode(paste0("www.omdbapi.com/?t=", movie_name, '&y=', year.string, '&type=movie&tomatoes=true'))
  web = getURL(url_encoded_movie_name)
  raw = fromJSON(web)
  title = c(title, raw["Title"])
  year = c(year, raw["Year"])
  rated = c(rated, raw["Rated"])
  released = c(released, raw["Released"])
  runtime = c(runtime, raw["Runtime"])
  genre = c(genre, raw["Genre"])
  director = c(director, raw["Director"])
  writer = c(writer, raw["Writer"])
  actors = c(actors, raw["Actors"])
  plot = c(plot, raw["Plot"])
  language = c(language, raw["Language"])
  country = c(country, raw["Country"])
  awards = c(awards, raw["Awards"])
  poster = c(poster, raw["Poster"])
  metascore = c(metascore, raw["Metascore"])
  imdbRating = c(imdbRating, raw["imdbRating"])
  imdbVotes = c(imdbVotes, raw["imdbVotes"])
  imdbID = c(imdbID, raw["imdbID"])
  tomatoMeter = c(tomatoMeter, raw["tomatoMeter"])
  tomatoRating = c(tomatoRating, raw["tomatoRating"])
  tomatoFresh = c(tomatoFresh, raw["tomatoFresh"])
  tomatoRotten = c(tomatoRotten, raw["tomatoRotten"])
  tomatoUserMeter = c(tomatoUserMeter, raw["tomatoUserMeter"])
  tomatoUserRating = c(tomatoUserRating, raw["tomatoUserRating"])
  tomatoUserReviews = c(tomatoUserReviews, raw["tomatoUserReviews"])
  production = c(production, raw["Production"])
}
top250.imdb <- data.frame(title, year, rated, released, runtime, genre, 
                          director, writer, actors, plot, language, 
                          country, awards, poster, metascore, imdbRating, 
                          imdbVotes, imdbID, tomatoMeter, tomatoRating,
                          tomatoFresh, tomatoRotten, tomatoUserMeter, tomatoUserRating,
                          tomatoUserReviews, production, stringsAsFactors = F)