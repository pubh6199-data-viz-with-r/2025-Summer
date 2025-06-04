server <- function(input, output) {
  # Render the plot
  output$scatterPlot <- renderPlot({
    ggplot(mtcars_clean, aes_string(x = input$xvar, y = input$yvar)) +
      geom_point(aes_string(color = input$colorvar), size = 3) +
      ggrepel::geom_text_repel(aes(label = car), vjust = -1, size = 4) +
      theme_minimal(base_size = 20) +
      labs(title = paste("Scatter Plot of", input$yvar, "vs", input$xvar),
           x = input$xvar, y = input$yvar)
  })
}