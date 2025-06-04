# make a scatter plot using the `mtcars` dataset
# x-axis is wt
# y-axis is mpg
# color by cyl
# label points with car names

library(ggplot2)
library(dplyr)
library(tibble)
# Data wrangling: Add a car name column and factor variables
mtcars_clean <- mtcars %>%
  rownames_to_column("car") %>%
  mutate(
    cyl = as.factor(cyl),
    gear = as.factor(gear)
  )
# Create the scatter plot
ggplot(mtcars_clean, aes(x = wt, y = mpg)) +
  geom_point(aes(color = cyl)) +
  geom_text(aes(label = car), vjust = -1, size = 3) +
  labs(
    title = "Scatter Plot of MPG vs Weight"
  ) +
  theme_minimal()
