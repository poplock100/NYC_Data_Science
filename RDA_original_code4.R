

# Why ggplot2? ------------------------------------------------------------
plot(iris$Sepal.Width, iris$Sepal.Length)

# The “Grammar of Graphics” -----------------------------------------------

# Constructing a ggplot2 Plot ---------------------------------------------

# install.packages("ggplot2")
# library(ggplot2)
# 
# g <- ggplot(data = <name of R data frame>, 
#             aes(x = <name of default x variable), 
#             y = <name of default y variable>, ..., 
#             <other aesthetic mappings>),
# <other plot defaults>)

# p <- g + geom_<geom type>(aes(
#   <aesthetic mappings for this geom>),  <other arguments>)


# Scatterplots ------------------------------------------------------------

?mpg
head(mpg)

g <- ggplot(data = mpg, aes(x = displ, y = hwy))
g + geom_point()


g + geom_point() + geom_smooth(method = "lm")


# Aesthetics --------------------------------------------------------------

g + geom_point(aes(color = class))
g + geom_point(aes(size = class))
g + geom_point(aes(shape = class))
g + geom_point(aes(alpha = class))

# Faceting ----------------------------------------------------------------

+ geom_point() + facet_grid(. ~ cyl)

g + geom_point() + facet_grid(drv ~ .)

g + geom_point() + facet_grid(drv ~ cyl)

g + geom_point() + facet_wrap( ~ class)

# Geoms -------------------------------------------------------------------

g + geom_smooth()
g + geom_point() + geom_smooth(se = FALSE)  # Turn off confidence band
ggplot(data = mpg, aes(x = class, y = hwy)) + geom_point()

g <- ggplot(data = mpg, aes(x = class, y = hwy))

g + geom_boxplot()

g <- ggplot(data = mpg, aes(x = reorder(class, hwy), y = hwy))
g + geom_boxplot()
# compare two graphs
ggplot(data = mpg, aes(x = reorder(class,  hwy), y = hwy)) + geom_boxplot()
g + geom_boxplot()

ggplot(data = mpg, aes(x = reorder(class, hwy, median), y = hwy)) + geom_boxplot()


# Diamonds Data Set -------------------------------------------------------

names(diamonds)
ggplot(data = diamonds,aes(x = cut)) + geom_bar(aes(fill = cut))
ggplot(data = diamonds, aes(x = cut)) + geom_bar(aes(color = cut))
ggplot(data = diamonds, aes(x = color)) + geom_bar(aes(fill = cut))
ggplot(data = diamonds, aes(x = color)) + geom_bar(aes(fill = cut), position = "fill")
ggplot(data = diamonds, aes(x = color)) + 
  geom_bar(aes(fill = cut), position = "dodge")
ggplot(data = mpg, aes(x = cty, y = hwy)) + geom_point()
ggplot(data = mpg, aes(x = cty, y = hwy)) + 
  geom_point(position = "jitter")
ggplot(data = mpg, aes(x = cty, y = hwy)) + 
  geom_point(position = "jitter")

ggplot(data = mpg, aes(x = cty, y = hwy)) + geom_jitter()

g <- ggplot(data = diamonds, aes(x = carat))
g + geom_histogram(binwidth = 1)
g + geom_histogram(binwidth = 0.1)
g + geom_histogram(binwidth = 0.01)
#stat_bin: binwidth defaulted to range/30.
g + geom_histogram()
g <- ggplot(data = diamonds, aes(x = depth))
zoom <- coord_cartesian(xlim = c(55, 70))
g + geom_histogram(binwidth = 0.2) + zoom
g + geom_histogram(aes(fill = cut), binwidth = 0.2) + zoom
g <- ggplot( data = diamonds, aes(x = depth)) 
zoom <- coord_cartesian(xlim = c(55, 70))
g + geom_histogram(binwidth = 0.2) + facet_wrap( ~ cut) + zoom
g + geom_histogram(binwidth = 0.2) + geom_freqpoly(binwidth=0.2) + facet_wrap( ~ cut) + zoom
g + geom_freqpoly(aes(color = cut), binwidth = 0.2) +
  facet_wrap( ~ cut) + zoom
g + geom_freqpoly(aes(color = cut), binwidth = 0.2) + zoom
g + geom_density(aes(color = cut)) + zoom
ggplot(data = diamonds, aes(x = price)) + geom_histogram(binwidth = 500) + facet_wrap(~ cut)
ggplot(data = diamonds, aes(x = price)) + geom_histogram(aes(fill = cut))
ggplot(data = diamonds, aes(x = price)) + geom_freqpoly(aes(color = cut), binwidth = 500)
ggplot(data = diamonds, aes(x = price)) + geom_density(aes(color = cut))


# Visualizing Big Data ----------------------------------------------------

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

# Saving Graphs -----------------------------------------------------------

ggsave("my-plot.pdf")
ggsave("my-plot.png")

ggsave("my-plot.pdf", width = 6, height = 6)
ggsave("my-plot.png", width = 6, height = 6)


