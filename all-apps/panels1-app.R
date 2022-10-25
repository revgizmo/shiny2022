library(shiny)


ui <- fluidPage(

   
    titlePanel("My first app"),

    
    sidebarLayout(
        sidebarPanel(h4("This is in the sidebar")),
        
        
        mainPanel(
          h1("This is a level 1 header"),
          h2("This is a level 2 header"),
          h4("This is a level 4 header"),
          h6("This is a level 6 header. It's actually smaller than a paragraph."),
          p("This is a paragraph"),
          plotOutput("hist"))
        
    )
)


server <- function(input, output) {

    output$hist <- renderPlot({
        hist(mtcars$mpg)
    })
}

shinyApp(ui = ui, server = server)
