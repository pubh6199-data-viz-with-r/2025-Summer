# Define UI
dashboardPage(
  dashboardHeader(title = "mtcars Dashboard"),
  
  dashboardSidebar(
    sidebarMenu(
      menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
      menuItem("Data", tabName = "data", icon = icon("table"))
    ),
    
    # Filter controls
    sliderInput("mpg_filter", 
                "Filter by MPG:",
                min = min(mtcars$mpg),
                max = max(mtcars$mpg),
                value = c(min(mtcars$mpg), max(mtcars$mpg)),
                step = 0.1),
    
    # Scatter plot controls
    selectInput("x_var", "X-axis Variable:", 
                choices = numeric_cols,
                selected = "wt"),
    
    selectInput("y_var", "Y-axis Variable:", 
                choices = numeric_cols,
                selected = "mpg"),
    
    selectInput("color_var", "Color Variable:", 
                choices = numeric_cols,
                selected = "cyl")
  ),
  
  dashboardBody(
    tabItems(
      # Dashboard tab
      tabItem(tabName = "dashboard",
              fluidRow(
                box(title = "Scatter Plot", status = "primary", solidHeader = TRUE,
                    plotlyOutput("scatter_plot", height = 400), width = 8),
                
                box(title = "Heatmap", status = "warning", solidHeader = TRUE,
                    plotlyOutput("heatmap", height = 400), width = 4)
              )
      ),
      
      # Data tab
      tabItem(tabName = "data",
              box(title = "Filtered Dataset", status = "primary", solidHeader = TRUE,
                  DTOutput("data_table"), width = 12)
      )
    )
  )
)
