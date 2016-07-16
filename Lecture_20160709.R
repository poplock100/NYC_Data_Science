install.packages("ggplot2")
library(ggplot2)

head(mpg)
### figure out what's in the data to get to know it.
summary(mpg)
str(mpg)

### Scatterplots
g <- ggplot(data = mpg, aes(x = displ, y = hwy))
g + geom_point() + geom_smooth(method = "lm")
g + geom_point() + geom_smooth()

g + geom_point(aes(color = class))
g + geom_point(aes(size = class))
g + geom_point(aes(shape = class))
g + geom_point(aes(alpha = class))
### Alpha is opacity of dot.


###Faceting
g + geom_point() + facet_grid (.~cyl)
### creates number of scatter plots as there are categories of cylinders.
### graphs are side by side (because columns (always columns if to right of ~))

g + geom_point() + facet_grid (drv~.)
### creates number of scatter plots as there are categories of drv
### graphs are one on top of other (because rows( always rows if to left of ~))

g + geom_point() + facet_grid (drv~cyl)
### This does both of the two above, together.

g + geom_point() + facet_wrap (~class)
### makes one graph for each variable that the one after the ~ can compare to.


help.search("geom_", package = "ggplot2")
### This gets a list of available geometric object that can be used for graphs.
### Or, just do geom_<tab> to see a list of all commands that start with "geom".

g + geom_smooth()
### line for data with shadow of confidence intervals.

g + geom_smooth(se = FALSE)
### removes confidence interval shadow (se = standard error)

g + geom_point() + geom_smooth(se = FALSE)
### scatter plot with line without CI.

g <- ggplot(data = mpg, aes(x = class, y = hwy)) + geom_point() 

g + geom_boxplot()
### Scatterplot + boxplot

g <- ggplot(data = mpg, aes(x = reorder(class,hwy), y = hwy))+
  geom_boxplot()

ggplot(data = diamonds, aes(x = color)) +
  geom_bar(aes(fill = cut))
### makes stacked bar chart, based on count of cut.

ggplot(data = diamonds, aes(x = color)) +
  geom_bar(aes(fill = cut), position = "fill")
### makes stacked bar chart based on percentage.


ggplot(data = diamonds, aes(x = color)) + 
  geom_bar(aes(fill = cut), position = "dodge")
### makes grouped bar chart.

### HIstograms.
g <- ggplot(data = diamonds, aes(x = carat)) + geom_histogram(binwidth = 1)
  

###
g <- ggplot(data = diamonds, aes(x = depth))
zoom <- coord_cartesian(xlim = c(55, 70))
g + geom_histogram(binwidth = 0.2) + zoom

g + geom_histogram(aes(fill = cut), binwidth = 0.2) + zoom
### Makes zoomed histogram, with each cut differentiated on the histogram by chart color

### geom_freqpoly
### Allows you to graph multiple items by line instead of filled bars
### Frequency, not count.  So, shows density.

names(diamonds)
### Compare distribution of price by cut
ggplot(data = diamonds, aes(x = price)) + geom_freqpoly(aes(color = cut))
### shows frequency lines by count

ggplot(data = diamonds, aes(x = price)) + geom_density(aes(color = cut))
### shows frequency lines by density


########
### Big data

g <- ggplot(data = diamonds, aes(x = carat, y = price)) 

g + geom_point(aes(color = cut))
g + geom_bin2d()
g + geom_density2d()
g + geom_point() + geom_density2d()
g + geom_smooth()
g + geom_smooth(aes(group = cut))
g + geom_smooth(aes(color = cut))
g + geom_smooth(aes(color = cut), se = FALSE)
g + geom_smooth(aes(color = cut), method = "lm", se = FALSE)
g + geom_smooth(aes(color = cut), method = "loess", se = FALSE)

g + geom_point()
g + geom_point(size = 0.5)
g + geom_point(alpha = 0.1)
g + geom_point(size = 0.5, alpha = 0.1)

### Saving plots
### Can be saved as pdf or png.
### using size on screen
ggsave("my-plot.pdf")
ggsave("my-plot.png")

### save with custom size
ggsave("my-plot.pdf", width = 6, height = 6)
ggsave("my-plot.png", width = 6, height = 6)



#########################
#########################
### In class exercise ###
#########################
#########################

### Get economy data.

dat <- read.csv("C:/Users/Ali/Documents/R/NYC_Data_Science/data/EconomistData.csv")
summary(dat)
### 173 obs, 6 variables
names(df)
class(df$HDI)
### scatter plot with CPI on x axis and HDI on the y axis

g <- ggplot(data = dat, aes(x = CPI, y = HDI)) +
        geom_point()

### Make the dots blue
g <- ggplot(data = dat, aes(x = CPI, y = HDI)) +
  geom_point(color = "blue")

### Color the dots according to the region
g <- ggplot(data = dat, aes(x= CPI, y = HDI)) +
  geom_point(aes(color = Region))

### Boxplot of CPI by region
g <- ggplot(data = dat, aes(x = Region, y = CPI)) +
  geom_boxplot()

### Overlay points on top of boxplot
g <- ggplot(data = dat, aes(x = Region, y = CPI)) +
  geom_boxplot() +
  geom_point(color = "purple")

### Overlay a smoothing line on top of scatter plot.
g <- ggplot(data = dat, aes(x = Region, y = CPI)) +
    geom_point(color = "purple") +
  geom_smooth()

### Now with smooth line
g <- ggplot(data = dat, aes(x =  CPI, y = HDI)) +
  geom_point(color = "purple") +
  geom_smooth(method = "lm")

### Create scatter plot with CPI on x and HDI on y.
### Color points to indicate region
g <- ggplot (data= dat, aes(x = CPI, y = HDI, color = Region))+
  geom_point()

###Modify x and y so that they have more easily understood names (spell 
      ###out "Human Development Index")
### two methods
g <- ggplot (data= dat, aes(x = CPI, y = HDI, color = Region))+
  geom_point() +
  ylab("Human Development Index")+
  xlab("Corruption Perceptions Index") +
  aes(title= "Corruption and Human Development")

### method 2
g <- ggplot (data= dat, aes(x = CPI, y = HDI, color = Region))+
  geom_point() +
  scale_y_continuous( name = "Human Development Index")+
  scale_x_continuous("Corruption Perceptions Index") +
  aes(title= "Corruption and Human Development")+
  scale_color_discrete(name = "Region of the World")

### Modify color scale to use specific values of your choosing

my_colors <- c("#24576D", "#099DD7", "#28AADC", "#248E58", 
               "#F2583F", "#0072B2", "#D55E00", "#CC79A7")
g <- ggplot (data= dat, aes(x = CPI, y = HDI, color = Region))+
  geom_point() +
  scale_y_continuous(name = "Human Development Index")+
  scale_x_continuous("Corruption Perceptions Index") +
  aes(title= "Corruption and Human Development")+
  scale_colour_manual(name = "Region of the World", values=my_colors)

### Create a set of scatterplots (with CPI on x and HDI on y) to 
### compare among different regions

g <- ggplot(data = dat, aes(x = CPI, y = HDI, color = Region)) +
  geom_point() +
  facet_grid(~Region)

### Reproduce graphic from the Economist.

### Using open dots.
g <- ggplot (data= dat, aes(x = CPI, y = HDI, color = Region))+
  geom_point(size = 4.5, shape = 1) +
  geom_point(size = 4, shape = 1) +
  geom_point(size = 3.5, shape = 1) +
  scale_y_continuous(name = "Human Development Index")+
  scale_x_continuous("Corruption Perceptions Index") +
  aes(title= "Corruption and Human Development")+
  scale_colour_manual(name = "Region of the World", values=my_colors)

### Add trend line.
(g <- ggplot (data= dat, aes(x = CPI, y = HDI, color = Region))+
  geom_point(size = 4.5, shape = 1) +
  geom_point(size = 4, shape = 1) +
  geom_point(size = 3.5, shape = 1) +
  scale_y_continuous(name = "Human Development Index")+
  scale_x_continuous("Corruption Perceptions Index") +
  aes(title= "Corruption and Human Development")+
  scale_colour_manual(name = "Region of the World", values=my_colors)+
  geom_smooth(aes(group = 1), 
              formula = y~log(x),
              method = "lm",
              color = "red", 
              se = FALSE))

### Labeling the points
pointsToLabel <- c("Russia", "Venezuela", "Iraq", "myanmar", "Sudan",
                   "Afghanistan", "Congo", "Cape Verde", "Botswana", "Barbados",
                   "Japan", "Germany", "USA", "Italy", "Spain", "Singapore", "Iraq",
                   "South Aftica", "New Zealand", "France", "England", "Canada")

### Add trend line.
(g <- ggplot (data= dat, aes(x = CPI, y = HDI, color = Region))+
  geom_point(size = 4.5, shape = 1) +
  geom_point(size = 4, shape = 1) +
  geom_point(size = 3.5, shape = 1) +
  scale_y_continuous(name = "Human Development Index")+
  scale_x_continuous("Corruption Perceptions Index") +
  aes(title= "Corruption and Human Development")+
  scale_colour_manual(name = "Region of the World", values=my_colors)+
  geom_smooth(aes(group = 1), 
              formula = y~log(x),
              method = "lm",
              color = "red", 
              se = FALSE)+
  geom_text(aes(label = Country),
           color = "gray20",
           data = subset(dat, Country %in% pointsToLabel))) 

### more code, but she took it down too fast
g2 <- g +
  theme_minimal()+ #start with minimal theme and add wheat we need
  teme(text = element_tex(color = "gray20"),
       legend)


(mR2 <- summary(lm(HDI~log(CPI), data = dat))$r.squared)
###ggplot2 has annotate() function

(g <- ggplot (data= dat, aes(x = CPI, y = HDI, color = Region))+
  geom_point(size = 4.5, shape = 1) +
  geom_point(size = 4, shape = 1) +
  geom_point(size = 3.5, shape = 1) +
  scale_y_continuous(name = "Human Development Index")+
  scale_x_continuous("Corruption Perceptions Index") +
  aes(title= "Corruption and Human Development")+
  scale_colour_manual(name = "Region of the World", values=my_colors)+
  geom_smooth(aes(group = 1), 
              formula = y~log(x),
              method = "lm",
              color = "red", 
              se = FALSE)+
  geom_text(aes(label = Country),
            color = "gray20",
            data = subset(dat, Country %in% pointsToLabel))+
  annotate("text"))


# to hashtag several things at once
# can use shift+ctrl+c

## ctrl+ <up arrow>: gets you to more easily find previous commands in the console