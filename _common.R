set.seed(5678)

# Load libraries and options
library(knitr)
library(here)
library(tidyverse)
library(cowplot)
library(kableExtra)
library(lubridate)

options(dplyr.width = Inf)
options(knitr.kable.NA = '')

knitr::opts_chunk$set(
    message = FALSE,
    warning = FALSE,
    comment    = "#>",
    fig.retina = 3,
    fig.width  = 6,
    fig.height = 4,
    fig.show = "hold",
    fig.align  = "center",
    fig.path   = "figs/"
)

make_rubric <- function(rubric) {
  rubric %>%
    mutate(description = paste0("<b>", points, '</b><br>', description)) %>%
    select(-points) %>%
    spread(key = rating, value = description) %>%
    select(-category) %>%
    rename(Category = label) %>%
    arrange(order) %>%
    select(-order) %>%
    select(-maxPoints) %>%
    kable(format = 'html', escape = FALSE) %>%
    kable_styling(bootstrap_options = "striped")
}

icon_link <- function(
  icon = NULL,
  text = NULL,
  url = NULL,
  class = "icon-link",
  target = "_blank"
) {
  if (!is.null(icon)) {
    text <- make_icon_text(icon, text)
  }
  return(htmltools::a(
    href = url, text, class = class, target = target, rel = "noopener"
  ))
}

make_icon_text <- function(icon, text) {
  return(HTML(paste0(make_icon(icon), " ", text)))
}

make_icon <- function(icon) {
  return(tag("i", list(class = icon)))
}

clean_schedule_name <- function(x) {
    x <- x %>%
        str_to_lower() %>%
        str_replace_all(" & ", "-") %>%
        str_replace_all(" ", "-")
    return(x)
}

# Load custom functions

get_schedule <- function() {
    
    # Get raw schedule

    df <- read_csv(here::here('schedule.csv')) 

    # Class vars

    class <- df %>%
        mutate(
            description_class = ifelse(
                is.na(description_class),
                "",
                description_class),
            class = ifelse(
                is.na(stub_class),
                paste0("<b>", name_class, "</b><br>", description_class),
                paste0(
                    '<a href="class/', n_class, "-", stub_class, '.html"><b>',
                    name_class, "</b></a><br> ",
                    description_class)),
        ) %>%
        select(week, ends_with('class'))
    
    # Weekly assignment vars

    assignments <- df %>%
        filter(!is.na(n_assign)) %>%
        mutate(
            due_assign = lubridate::mdy(due_assign),
            assign = ifelse(
                is.na(due_assign),
                name_assign,
                paste0(
                    '<a href="hw/', n_assign, "-", stub_assign, '.html"><b>HW ',
                    n_assign, "</b></a><br>Due: ", due_assign))
        ) %>%
        select(week, ends_with('assign'))
    

    # Weekly lab vars
    
    labs <- df %>%
        filter(!is.na(n_lab)) %>%
        mutate(
            due_lab = lubridate::mdy(due_lab),
            lab = ifelse(
                is.na(due_lab),
                stub_lab,
                paste0(
                    '<a href="lab/', n_lab, "-", stub_lab, '.html"><b>Lab ',
                    n_lab, "</b></a><br>Due: ", due_lab))
        ) %>%
        select(week, ends_with('lab'))
    
    
    # Final schedule data frame

    schedule <- df %>% 
        select(week, date, theme, n_class, n_assign, n_lab) %>% 
        mutate(date_md = lubridate::mdy(date)) %>% 
        left_join(class, by = c("week", "n_class")) %>% 
        left_join(assignments, by = c("week", "n_assign")) %>%
        left_join(labs, by = c("week", "n_lab")) %>%
        ungroup()
    
    return(schedule)

}
