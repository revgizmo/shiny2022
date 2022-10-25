library(shiny)

ui <- fluidPage(
  navlistPanel(
    tabPanel("Raw Data", 
             h4("This is where you can show some data"),
             tableOutput("table1")
    ),
    tabPanel("Methodology",
             h4("We're going to make some models.")),
    tabPanel("Conclusions",h4("This is what we found out."))
  )
)


server <- function(input, output) {

  output$table1 <- renderTable({head(mtcars)})
}


shinyApp(ui = ui, server = server)
