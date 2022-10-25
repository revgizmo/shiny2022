library(shiny)

ui <- fluidPage(
  actionButton("but1","Click me!"),
  plotOutput("po1")
)

server <- function(input, output, session) {
  observeEvent(input$but1,{
    message("Data will be simulated") #this appears in the R console
  })
  
  dta <- eventReactive(input$but1, {
    rnorm(100)
  })
  
  output$po1 <- renderPlot({
    req(dta)
    hist(dta())
  })
}

shinyApp(ui, server)