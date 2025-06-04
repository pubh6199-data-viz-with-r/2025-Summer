# Load necessary libraries
library(shiny)
library(shinydashboard)
library(DT)
library(plotly)
library(heatmaply)
library(dplyr)

# Prepare the mtcars dataset
data(mtcars)
# Add row names as a column for car names
mtcars <- mtcars %>%
  tibble::rownames_to_column("car_name")

# Define column names for selection dropdowns
numeric_cols <- names(mtcars)[sapply(mtcars, is.numeric)]
