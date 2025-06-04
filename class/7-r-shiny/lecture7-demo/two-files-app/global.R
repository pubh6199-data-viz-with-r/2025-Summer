library(shiny)
library(ggplot2)
library(dplyr)

# Data wrangling: Add a car name column and factor variables
mtcars_clean <- mtcars %>%
  tibble::rownames_to_column("car") %>%
  mutate(
    cyl = as.factor(cyl),
    gear = as.factor(gear)
  )
#glimpse(mtcars_clean)