library(shiny)

# UI
ui <- fluidPage(
  titlePanel("Histogram Example"),
  
  sidebarLayout(
    sidebarPanel(
      sliderInput("bins",
                  "Number of bins:",
                  min = 5, max = 50, value = 30)
    ),
    
    mainPanel(
      plotOutput("histPlot")
    )
  )
)

# Server
server <- function(input, output) {
  
  output$histPlot <- renderPlot({
    # Generate random data
    data <- rnorm(500)
    
    # Create histogram with user-specified bins
    hist(data, breaks = input$bins, col = "skyblue",
         border = "white", main = "Histogram of Random Normal Data",
         xlab = "Value", ylab = "Frequency")
  })
}

# Run the app
shinyApp(ui = ui, server = server)
