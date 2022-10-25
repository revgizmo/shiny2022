library(shiny)


ui <- fluidPage(
 fluidRow(column(4,"4-unit wide column", style="background-color:#ffffcc;font-size:20px;padding:50px;"),
          column(8,"8-unit wide column", style="background-color:#ffff99;font-size:20px;padding:50px;")),
 fluidRow(column(6,"half page", style="background-color:#996699;color:white;font-size:20px;padding:50px;"),
          column(6,"half page", style="background-color:#cc6699;color:white;font-size:20px;padding:50px;"))
    
)


server <- function(input, output) {

    output$histPlot <- renderPlot({
        hist(mtcars$mpg)
    })
}


shinyApp(ui = ui, server = server)
