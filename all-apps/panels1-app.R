library(shiny)


ui <- fluidPage(

   
    titlePanel(""),

    
    sidebarLayout(
        sidebarPanel(),

       
        mainPanel(plotOutput("hist"))
    )
)


server <- function(input, output) {

    output$hist <- renderPlot({
        hist(mtcars$mpg)
    })
}

shinyApp(ui = ui, server = server)
