library(shiny)


ui <- fluidPage(

   
    titlePanel("My first app"),

    
    sidebarLayout(
        sidebarPanel(h4("This is the sidebar")),

       
        mainPanel(plotOutput("hist"))
    )
)


server <- function(input, output) {

    output$hist <- renderPlot({
        hist(mtcars$mpg)
    })
}

shinyApp(ui = ui, server = server)
