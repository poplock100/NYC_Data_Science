

library(ggplot2)
texas <-- read.table("C:/Users/Ali/Documents/R/NYC_Data_Science/data/texas.csv",sep="-")
texas2 <-- read.csv("C:/Users/Ali/Documents/R/NYC_Data_Science/data/texas.csv",
                    type.convert(texas2$state))
texas$state <- as.factor(table$state)
table(texas$state, texas$county)
g <- ggplot(data= texas, aes(x = long, y = lat))

head(texas)

 g <- ggplot(data = diamonds, aes(x = carat, y= price) +
   geom_point())

 ### To access data within your list, you can call it like regular object:
 g <- ggplot(data = diamonds, aes(x = carat, y = price)) + geom_point()
 str(g)
 ### Can change x label here:
 g$x$label <- "anything"
 g
 
 
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
 ### radar type
 g
 g + coord_polar()
 
 # flip
 g
 g + coord_flip()
 
 # fixed
 ### zooms in on a part of the graph
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
 
 ### To only see a part, change the limits:
 g + coord_cartesian(ylim = c(10000,15000), xlim = c(2, 3))
 
 
 
 # Coordinate Systems
 tx
 tx + coord_map()
 
 # Pie charts
 d2 <- subset(diamonds, color == "D")
 cc <- ggplot(data = d2, aes(x = color)) + geom_bar(aes(fill = cut), position = "fill")
 cc
 
 cc + coord_polar(theta = "y")
 
 ### Pie chart is really stacked bar chart in polar coordinates
 d2 <- subset(diamonds, color ==
                "D"
 )
 cc <- ggplot(data = d2, aes(x =
                               color)) + geom_bar(aes(fill =
                                                        cut), position = fill)
                                  
 ### lastplot() function: 
  ### will call up your last plot so that you don't have to write it all again.
 
 ggplot(data = mpg, aes(x = displ, y = hwy)) + geom_point(aes(color = cty))
 last_plot() + scale_color_gradient(low = "red", high = "yellow")
 last_plot() + scale_color_gradient(low = "green", high = "purple")
 
 ### ON PLOTS, COLOR() IS OUTSIDE COLOR.  INSIDE = FILL()
 
 ### There is a ggplot2 cheat sheet.
 
 # Axis Labels -------------------------------------------------------------
 
 p + ylab("Number of Diamonds")
 tx + scale_fill_brewer(palette = "Blues") +
   xlab("") +
   ylab("") +
   theme_bw() +
   coord_map() +
   ggtitle("Population of Texas Counties")
 ### use xlab("") [or ylab("") to remove axis labels
 ### ggtitle("Name of Title") to add titles