# Customizing Graphics in ‘ggplot2’


# Customizing Graphics ----------------------------------------------------

# Texas population data
library(ggplot2)
texas = read.csv("data/texas.csv")
head(texas)

g <- ggplot(data = texas, aes(x = long, y = lat))
g + geom_point()  # What’s going on here?

g + geom_polygon(aes(group = group))

head(texas)

texas2 = texas[sample(nrow(texas)), ]  #Row order matters!
ggplot(data = texas2, aes(x = long, y = lat)) + geom_polygon(aes(group = group))

# install.packages("maps")
# help(package = "maps")
library(maps)
counties = map_data("county") 	# Using the built-in USA county 	 								# map dataset.
ggplot(data = counties, aes(x = long, y = lat)) + geom_polygon(aes(group = group, fill = group))

tx <- g + geom_polygon(aes(group = group, fill = bin))
tx

# Titles ------------------------------------------------------------------
tx + ggtitle("Population of Texas Counties")
#Creates a ggplot2 title, and adds it to the tx graph.

tx + ggtitle("Population of Texas Counties")
tx

#To create a new graph that always has a title, save a new object.
tx2 <- tx + ggtitle("Population of Texas Counties")
tx2

# Manipulating Plots ------------------------------------------------------

# What is in a ggplot object?
g <- ggplot(data = diamonds, aes(x = carat, y = price)) + geom_point()
str(g)


# Coordinate Systems ------------------------------------------------------

g$coordinates
coord_cartesian()
g2 <- g + coord_polar()

# Now compare
g$coordinates
g2$coordinates

# polar
g
g + coord_polar()

# flip
g
g + coord_flip()

# fixed
g
g + coord_fixed(ratio = 1/10000)

# trans
g
g + coord_trans(ytrans = "log10")
g + coord_trans(ytrans = "log10", xtrans = "log10")

#cartesian (default)
g
g + coord_cartesian()

#cartesian (to zoom)
g
g + coord_cartesian(ylim = c(0,5000), xlim = c(0, 1))

# Coordinate Systems
tx
tx + coord_map()

# Pie charts
d2 <- subset(diamonds, color == "D")
cc <- ggplot(data = d2, aes(x = color)) + geom_bar(aes(fill = cut), position = "fill")
cc

cc + coord_polar(theta = "y")


# Scales ------------------------------------------------------------------
scale_aesthetic_name()
# scale_color_gradient
ggplot(data = mpg, aes(x = displ, y = hwy)) + geom_point(aes(color = cty))
last_plot() + scale_color_gradient(low = "red", high = "yellow")
# scale_size_area
ggplot(data = mpg, aes(x = displ, y = hwy)) + geom_point(aes(size = cyl))
last_plot() + scale_size_area()
#Size of points proportional to value.

# scale_shape_manual
ggplot(data = mpg, aes(x = displ, y = hwy)) + geom_point(aes(shape = fl))
last_plot() + scale_shape_manual(values = c(0, 15, 1, 16, 3))  

# shapes
r <- ggplot(data = mpg, aes(x = displ, y = cry)) + geom_point(aes(color = drv, shape = fl))
#Specify the shapes manually 
r + scale_shape_manual(values = c(0, 15, 1, 16, 3))

# Color Brewer
#install.packages("RColorBrewer")
library(RColorBrewer)
display.brewer.all()
tx + scale_fill_brewer(palette = "OrRd")
tx + scale_fill_brewer(palette = "Spectral")
tx + scale_fill_brewer(palette = "Greens")
tx + scale_fill_manual(values = c("red", "orange", "yellow", "green", "blue"))      

# Themes ------------------------------------------------------------------
tx + theme_grey()
tx + theme_bw()
tx
tx + theme(panel.border = element_rect(colour = "black", fill = NA))

# ggthemes
library(ggthemes)  # install.packages("ggthemes")
p <- ggplot(data = diamonds, aes(x = color)) + geom_bar(aes(fill = cut))
p + theme_excel() + scale_fill_excel()
p + theme_economist() + scale_fill_economist()
p + theme_few() + scale_fill_few()
p + theme_solarized() + scale_fill_solarized()
p + theme_stata() + scale_fill_stata()
p + theme_wsj() + scale_fill_wsj(palette = "black_green")
p + theme_gdocs() + scale_fill_gdocs()
p + theme_tufte() + scale_fill_tableau()


# Axis Labels -------------------------------------------------------------

p + ylab("Number of Diamonds")
tx + scale_fill_brewer(palette = "Blues") +
  xlab("") +
  ylab("") +
  theme_bw() +
  coord_map() +
  ggtitle("Population of Texas Counties")


# Legends -----------------------------------------------------------------
# Change position with theme
q <- ggplot(data = mpg, aes(x = displ, y = hwy)) + geom_point(aes(color = cty))
q
q + theme(legend.position = "bottom")

#Continuous.
q + guides(color = "colorbar")


#Discrete.
q + guides(color = "legend")


#Neither.
q + guides(color = "none")

# Labels
tx + scale_fill_grey()
tx + scale_fill_grey(name = "Legend")
tx + scale_fill_grey(name = "Legend", labels = c("label 1", "label 2", "label 3","label 4", "label 5"))
tx + scale_fill_discrete(name = "Legend name")


# Other Visualizations ----------------------------------------------------
p <- ggplot(data = iris, aes(x = Species, y = Sepal.Length)) + 
  geom_violin(aes(fill = Species))

p <- ggplot(iris, aes(x = Species, y = Sepal.Length)) +
  geom_violin(fill = 'gray', alpha = 0.5) + 
  geom_dotplot(aes(fill = Species), binaxis = "y", stackdir = "center")

p <- ggplot(mpg, aes(x = 1)) +
  geom_bar(aes(fill = class)) + 
  coord_polar(theta = "y")

set.seed(1)
dir <- cut_interval(runif(100,0,360), n=16)
mag <- cut_interval(rgamma(100,15), n=4) 
sample = data.frame(dir=dir, mag=mag)
p <- ggplot(sample, aes(x=dir, fill=mag) ) +
  geom_bar() + 
  coord_polar()

install.packages("treemap")
library(treemap)
data = read.csv('data/apple.csv', TRUE)
treemap(data,
        index=c("item", "subitem"),
        vSize="time1206",
        vColor="time1106",
        type="comp",
        title='Apple Corp. Financial Statements',
        palette='RdBu')


# Relationships in Multivariate Data --------------------------------------

install.packages("car")
library(car)
scatterplotMatrix(mpg[ ,c(3,8,9)],
                  diagonal='histogram',
                  ellipse=TRUE)

install.packages("corrplot")
library(corrplot)
corrplot(cor(mtcars), order="hclust")


