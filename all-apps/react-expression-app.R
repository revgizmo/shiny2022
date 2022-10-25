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
    msg <- reactive({glue::glue("I love the number {input$numericIn1}!")})
    output$textOut1 <- renderText({
      msg()
    })
}


shinyApp(ui = ui, server = server)
