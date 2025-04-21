# Use these commands to install them if you have not already
# install.packages('plotly')
# install.packages('htmlwidgets')
# install.packages('htmltools')
# install.packages('leaflet')
# install.packages('DT')
# install.packages('reactable')
# install.packages('reactablefmtr')
# install.packages('sparkline')
# install.packages('shiny')
# install.packages('shinyWidgets')
# install.packages('rsconnect')

# Should be installed from previous classes:
library(knitr)
library(tidyverse)
library(fontawesome)
library(countdown)
library(metathis)
library(viridis)
library(cowplot)
library(rnaturalearth)
library(rnaturalearthhires)
library(rnaturalearthdata)

# New
library(leaflet)
library(plotly)
library(DT)
library(reactable)
library(reactablefmtr)
library(sparkline)

# Read in data sets for class
gapminder <- read_csv(here::here("data", "gapminder.csv"))
internet_users <- read_csv(here::here('data', 'internet_users_country.csv'))

# Process
world_internet_2015 <- ne_countries(
  scale = "medium", returnclass = "sf") %>%
  select(code = iso_a3) %>%
  left_join(internet_users, by = "code") %>%
  filter(year == 2015)
