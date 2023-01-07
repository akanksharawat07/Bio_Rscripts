#LETS CREATE A DUMMY DATAFRAME
Plantdf <- read.table(text = "
  species sepal_length sepal_width petal_length petal_width 
  setosa 5.1 3.5 1.4 0.2
  versicolor 7.0 3.2 4.7 1.4
  vieginica 6.3 3.3 6.0 2.5
  setosa  4.9 3.0 1.4 0.2  
  versicolor 6.4 3.2 4.5 1.5
  virginica 6.7 3.0 5.2 2.3
", header = TRUE)
# Next, install and load the ggplot2 library:
install.packages("ggplot2")
library(ggplot2)
# Now, create a scatter plot using the ggplot() function and the aes() function to define the x-axis, y-axis, and other aesthetics:
#This will create a scatter plot with the sepal length values on the x-axis and the sepal width values on the y-axis.
ggplot(data = Plantdf, aes(x = sepal_length, y = sepal_width)) +
  geom_point()
# to plot multiple features in the same plot, you can use the facet_wrap() function to create multiple panels, one for each feature. For example, to create a separate panel for each species, you could do the following:
ggplot(data = Plantdf, aes(x = sepal_length, y = sepal_width)) +
  geom_point() +
  facet_wrap(~ species)
# You can also use the color aesthetic to differentiate between different categories or groups within a feature. For example, to color the points according to the species, you could do the following:
ggplot(data = Plantdf, aes(x = sepal_length, y = sepal_width, color = species)) +
  geom_point()

