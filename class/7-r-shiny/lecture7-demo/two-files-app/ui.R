ui <- fluidPage(
  titlePanel("Interactive Scatter Plot - mtcars"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput("xvar", "Choose X-axis variable:", choices = names(mtcars), selected = "wt"),
      selectInput("yvar", "Choose Y-axis variable:", choices = names(mtcars), selected = "mpg"),
      selectInput("colorvar", "Choose color variable:", choices = names(mtcars), selected = "cyl"),
    ),
    mainPanel(
      plotOutput("scatterPlot")
    )
  )
)