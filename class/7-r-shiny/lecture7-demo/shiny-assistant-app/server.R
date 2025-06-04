# Define server logic
function(input, output) {
  
  # Filter data based on MPG slider
  filtered_data <- reactive({
    mtcars %>%
      filter(mpg >= input$mpg_filter[1] & mpg <= input$mpg_filter[2])
  })
  
  # Scatter plot
  output$scatter_plot <- renderPlotly({
    req(input$x_var, input$y_var, input$color_var)
    
    p <- plot_ly(data = filtered_data(), 
                x = ~get(input$x_var), 
                y = ~get(input$y_var),
                color = ~get(input$color_var),
                text = ~car_name,
                type = "scatter",
                mode = "markers+text",
                textposition = "top right",
                marker = list(size = 10),
                hoverinfo = "text") %>%
      layout(
        xaxis = list(title = input$x_var),
        yaxis = list(title = input$y_var),
        title = paste("Scatter Plot of", input$y_var, "vs", input$x_var),
        legend = list(title = list(text = input$color_var))
      )
    
    return(p)
  })
  
  # Heatmap
  output$heatmap <- renderPlotly({
    # Select numeric columns for heatmap
    heatmap_data <- filtered_data() %>%
      select(-car_name) %>%
      as.matrix()
    
    rownames(heatmap_data) <- filtered_data()$car_name
    
    heatmaply(heatmap_data, 
              scale = "column",
              colors = colorRampPalette(c("blue", "white", "red"))(100),
              main = "Car Performance Heatmap",
              xlab = "Variables",
              ylab = "Cars") %>%
      layout(margin = list(l = 100, r = 20, b = 70, t = 50))
  })
  
  # Data table
  output$data_table <- renderDT({
    datatable(filtered_data(),
              options = list(pageLength = 10, 
                             autoWidth = TRUE,
                             scrollX = TRUE),
              rownames = FALSE,
              caption = "Filtered mtcars Dataset")
  })
}
