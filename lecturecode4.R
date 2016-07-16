
# Why ggplot2? ------------------------------------------------------------
library(ggplot2)
library(ggthemes)
# Using base R???s plot function
plot(iris$Sepal.Width, iris$Sepal.Length)
# Using ggplot2
ggplot(iris, aes(x = Sepal.Length, y = Petal.Length)) + 
  geom_point(aes(color = Species))

ggplot(iris, aes(x = Sepal.Length, y = Petal.Length,color = Species)) + 
  geom_point() +
  geom_smooth(method = "lm", se=F)
                                                                                  

ggplot (iris, aes (x = Sepal.Length, y = Sepal.Width,fill=Species)) +
  stat_density2d(geom="density2d", aes(color = Species,fill=Species),
                 size=1,contour=TRUE)
  
 
ggplot (iris, aes (x = Sepal.Length, y = Sepal.Width, fill = Species)) +
  stat_density2d(geom="density2d", aes(color = Species,fill=Species),
                 size=1,contour=TRUE)+
  facet_grid (. ~ Species)

# Constructing a ggplot2 Plot ---------------------------------------------

# Scatterplots ------------------------------------------------------------

# get to know the dataset
?mpg
head(mpg)

# Q: how many variables and observations are there in this dataset, what're their types?
{ # A: 
  summary(mpg)
  str(mpg)
}

# adding the base
g <- ggplot(data = mpg, aes(x = displ, y = hwy))
# adding the points
g + geom_point()

# adding the points and linear trend line
g + geom_point() + geom_smooth(method = "lm",se=F)

# Aesthetics --------------------------------------------------------------
## A look at all 25 symbols
{
df2 <- data.frame(x = 1:5 , y = 1:25, z = 1:25)
s <- ggplot(df2, aes(x = x, y = y))
s + geom_point(aes(shape = z), size = 10) + scale_shape_identity()
}
## While all symbols have a foreground colour, symbols 19-25 also take a
## background colour (fill)
{
s + geom_point(aes(shape = z), size = 10, colour = "Blue") +
  scale_shape_identity()
s + geom_point(aes(shape = z), size = 10, colour = "Blue", fill = "Black") +
  scale_shape_identity()
}
g + geom_point(aes(color = class))
g + geom_point(aes(size = class))
g + geom_point(aes(shape = class,size=5))
g + geom_point(aes(alpha = class))
# Q: what do color, size, shape and alpha 
{
# A: alpha sets the opacity of the point.  
}

# Faceting ----------------------------------------------------------------

g + geom_point() + facet_grid(. ~ cyl) # Here we create a separate subplot for each level of the cyl variable.

g + geom_point() + facet_grid(drv ~ .)

g + geom_point() + facet_grid(drv ~ cyl) # To facet your plot on the combination of two variables

g + geom_point() + facet_wrap( ~ class)

# Q: What if we replace facet_grid with facet_wrap?
# Q: How about replace facet_wrap ti facet_grid?

# Geoms -------------------------------------------------------------------

# Geometric objects are the actual marks we put on a plot. Examples include:
#   
# points (geom_point, for scatter plots, dot plots, etc)
# lines (geom_line, for time series, trend lines, etc)
# boxplot (geom_boxplot, for, well, boxplots!)

# ~ A plot must have at least one geom; there is no upper limit.
#   You can add a geom to a plot using the + operator

# You can get a list of available geometric objects using the code below:
help.search("geom_", package = "ggplot2")
# or simply type geom_<tab> in any good R IDE (such as Rstudio or ESS) 
# to see a list of functions starting with geom_


g + geom_smooth(se=F)  # method = "auto" is the default
# multiple geoms
g + geom_point() + 
  geom_smooth(se = FALSE)  # Turn off confidence band

# change the scatterplot to boxplot
g<-ggplot(data = mpg, aes(x = class, y = hwy)) + geom_point()
g + geom_boxplot()

# Q: How could we make the relationship between class and hwy easier to read?
{# A:
g <- ggplot(data = mpg, aes(x = reorder(class, hwy), y = hwy))
g + geom_boxplot()
}

# Q: Redraw the previous plots with the classes ordered by the median.
{
# A:
  ggplot(data = mpg, aes(x = reorder(class, hwy, median), y = hwy)) + 
  geom_boxplot()
}

# Example: Diamonds Data Set -------------------------------------------------------
diamonds
# Q: How to get to know the data?
{
# A: 
  summary(diamonds)
  str(diamonds)
  names(diamonds)
  dim(diamonds)
}

# 1. Bar chart
# The relationship between the x and z variables (two continuous variables)?
# Just the cut variable (a categorical variable)?
# Just the x variable (a continuous variable)?

ggplot(data = diamonds,aes(x = cut)) + 
  geom_bar(aes(fill = cut)) # fill by cut

ggplot(data = diamonds, aes(x = cut)) + 
  geom_bar(aes(color = cut)) # color by cut

# 2. Position Adjustments
# Note:
{
# If you map the fill aesthetic to another variable, 
# like cut, you get a stacked bar chart. 
# Each colored rectangle represents a combination of cut and color.
}
ggplot(data = diamonds, aes(x = color)) + 
  geom_bar(aes(fill = cut))

ggplot(data = diamonds, aes(x = color)) + 
  geom_bar(aes(fill = cut), position = "fill")

ggplot(data = diamonds, aes(x = color)) + 
geom_bar(aes(fill = cut), position = "dodge")
# Note:
{
# In the stacked bar chart, ggplot2 stacked bars that have the same cut value on top of each other. 
# In this plot, ggplot2 places bars that have the same cut value beside each other.
}

# What is strange about this graph?
ggplot(data = mpg, aes(x = cty, y = hwy)) + 
  geom_point()

ggplot(data = mpg, aes(x = cty, y = hwy)) + 
  geom_point(position = "jitter") # Unhide hidden data using jitter
# Note:
{
# You can avoid this gridding by setting the position adjustment to “jitter”. 
# position = "jitter" adds a small amount of random noise to each point. 
# This spreads the points out because no two points are likely to receive the same amount of random noise.  
  }

# It's just a short cut for a point geom with a jitter position adjustment.
ggplot(data = mpg, aes(x = cty, y = hwy)) + 
  geom_point(position = "jitter")

ggplot(data = mpg, aes(x = cty, y = hwy)) + 
  geom_jitter()

# geom_jitter() is another way to do position = "jitter"

# 3. Histograms
g <- ggplot(data = diamonds, aes(x = carat))
g + geom_histogram(binwidth = 1)

g + geom_histogram(binwidth = 0.1)

g + geom_histogram(binwidth = 0.01)

# Most parameters come with a preset default value.  
#stat_bin: binwidth defaulted to range/30.
g + geom_histogram()

# What if we want to see part of the histogram?
g <- ggplot(data = diamonds, aes(x = depth))
zoom <- coord_cartesian(xlim = c(55, 70))
g + geom_histogram(binwidth = 0.2) + zoom

# Fill=cut 
g + geom_histogram(aes(fill = cut), binwidth = 0.2) + 
  zoom

## Comparing Variables

g <- ggplot( data = diamonds, aes(x = depth)) 
zoom <- coord_cartesian(xlim = c(55, 70))
g + geom_histogram(binwidth = 0.2) + facet_wrap( ~ cut) + zoom

# Additional variables are sometimes hard to compare 
# if they are separated into facets because the shape 
# for smaller groups can be diminished or overshadowed by larger groups.

# What if we threw away the bars?
g + geom_freqpoly(aes(color = cut), binwidth = 0.2) +
facet_wrap( ~ cut) + zoom

# What if we just drew each on the same plot?
g + geom_freqpoly(aes(color = cut), binwidth = 0.2) + zoom 
g + geom_density(aes(color = cut)) + zoom

# Compare the distribution of prices for different cuts.
# Does anything seem unusual?

# Attempt #1: Faceting makes comparison hard in this case.
ggplot(data = diamonds, aes(x = price)) + 
  geom_histogram(binwidth = 500) + 
  facet_wrap(~ cut)

# Attempt #2: Stacked heights are also hard to compare.
ggplot(data = diamonds, aes(x = price)) + 
  geom_histogram(aes(fill = cut))

# Attempt #3: Better, but categories still have differing relative frequencies.
ggplot(data = diamonds, aes(x = price)) + 
  geom_freqpoly(aes(color = cut), binwidth = 500)

ggplot(data = diamonds, aes(x = price)) + 
  geom_density(aes(color = cut))

## Visualizing Big Data

g <- ggplot(data = diamonds, aes(x = carat, y = price)) 
g + geom_point(aes(color = cut))

# How do we work with visualizations when they become overwhelming 
# due to the amount of data?

g + geom_bin2d() # Heat map of 2d bin counts
g + geom_density2d() # 2d density plot
g + geom_point() + geom_density2d() # 2d density on top of a scatter plot
g + geom_smooth() # smooth line/ trend line
g + geom_smooth(aes(group = cut)) # trend lines by cut
g + geom_smooth(aes(color = cut)) # color the trend lines
g + geom_smooth(aes(color = cut), se = FALSE) # without confidence bands
g + geom_smooth(aes(color = cut), method = "lm", se = FALSE) # Regression lines
g + geom_smooth(aes(color = cut), method = "loess", se = FALSE) # LOESS smoother

# Adjust the size and/or transparency of points
g + geom_point()
g + geom_point(size = 0.5)
g + geom_point(alpha = 0.1)
g + geom_point(size = 0.5, alpha = 0.1)


# Saving Graphs -----------------------------------------------------------

# Uses size on screen
ggsave("my-plot.pdf")
ggsave("my-plot.png")
# Uses specified size
ggsave("my-plot.pdf", width = 6, height = 6)
ggsave("my-plot.png", width = 6, height = 6)


