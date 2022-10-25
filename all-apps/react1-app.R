library(shiny)


ui <- fluidPage(

    
    titlePanel("Demo React"),


    sidebarLayout(
        sidebarPanel(
            numericInput("numericIn1",
                         label = "Choose your favorite number",
                         value = 42,
                         min = 0,
                         max = 100)
        ),

       
        mainPanel(
           textOutput("textOut1")
        )
    )
)


server <- function(input, output) {

    output$textOut1 <- renderText({
      input$numericIn1
    })
}


shinyApp(ui = ui, server = server)
