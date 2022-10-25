library(shiny)
library(ggplot2)

ui <- fluidPage(# Application title
  titlePanel("Plots Demo"),
  
  
  sidebarLayout(
    sidebarPanel(
      p("Try clicking on a point on the first scatterplot"),
      p("Try brushing (dragging) over points on the second scatterplot")
      
      ),
    
    
    mainPanel(
      plotOutput("aPlot", click = "plot_click"),
      verbatimTextOutput("vto"),
      h4("Nearby points: "),
      tableOutput("data"),
      plotOutput("bPlot", brush = "plot_brush"),
      h4("Nearby points: "),
      tableOutput("data2"),
    )
  ))


server <- function(input, output) {
  output$aPlot <- renderPlot({
    plot(CO2$conc, CO2$uptake)
    abline(lm(uptake ~ conc, data = CO2), col = "magenta", lwd = 3)
  })
  output$bPlot <- renderPlot({
    ggplot(CO2,aes(conc,uptake))+geom_point()+geom_smooth(method="loess",colour="orchid")
  })
  
  output$vto <- renderPrint({
    # make sure there's been a click
    req(input$plot_click)
    x <- round(input$plot_click$x, 2)
    y <- round(input$plot_click$y, 2)
    
    glue::glue("{x}, {y}")
  })
  
  output$data <- renderTable({
    req(input$plot_click)
    nearPoints(CO2, input$plot_click, xvar = "conc", yvar = "uptake")
  })
  output$data2 <- renderTable({
    req(input$plot_click)
    brushedPoints(CO2, input$plot_brush)
  })
}

# Run the application
shinyApp(ui = ui, server = server)
