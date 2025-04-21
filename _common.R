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

# The icon_link() function is in {distilltools}, but I've modified this
# one to include  a custom class to be able to have more control over the
# CSS and an optional target argument

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

    # Quiz vars

    quiz <- df %>%
        mutate(
            quiz = ifelse(
                is.na(quiz),
                "",
                paste0('Quiz ', quiz, ":<br><em>", quiz_content, "</em>"))
        ) %>%
        select(week, ends_with('quiz'))

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
        mutate(
            due_assign = format(due_assign, format = "%b %d"),
            assign = ifelse(
                is.na(due_assign),
                name_assign,
                paste0(
                    '<a href="hw/', n_assign, "-", stub_assign, '.html"><b>HW ',
                    n_assign, "</b></a><br>Due: ", due_assign))
        ) %>%
        select(week, ends_with('assign'))
    
    # Mini project vars

    mini <- df %>%
        mutate(
            due_mini = format(due_mini, format = "%b %d"),
            mini = ifelse(
                is.na(due_mini),
                "",
                paste0(
                    '<a href="mini/', n_mini, "-", stub_mini, '.html"><b>',
                    name_mini, "</b></a><br>Due: ", due_mini))
        ) %>%
        select(week, ends_with('mini'))

    # Final project vars

    project <- df %>%
        mutate(
            due_project = format(due_project, format = "%b %d"),
            project = ifelse(
                is.na(due_project),
                "",
                paste0(
                    '<a href="project/', n_project, "-", stub_project, '.html"><b>',
                    name_project, "</b></a><br>Due: ", due_project))
        ) %>%
        select(week, ends_with('project'))

    
    # Final schedule data frame

    schedule <- df %>% 
        select(week, date, theme) %>% 
        mutate(date_md = format(date, format = "%b %d")) %>% 
        left_join(class, by = "week") %>% 
        left_join(quiz, by = "week") %>%
        left_join(assignments, by = "week") %>% 
        left_join(mini, by = "week") %>% 
        left_join(project, by = "week") %>%
        ungroup()
    
    return(schedule)

}
