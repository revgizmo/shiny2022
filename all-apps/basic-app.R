#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(reactable)

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Old Faithful Geyser Data"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            sliderInput("bins",
                        "Number of bins:",
                        min = 1,
                        max = 50,
                        value = 30)
        ),

        # Show a plot of the generated distribution
        mainPanel(
           plotOutput("distPlot"),
           textOutput("someText"),
           verbatimTextOutput("someCode"),
           tableOutput("table1"),
           dataTableOutput("table2"),
           reactableOutput("table_reactable")
           
           
           
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$distPlot <- renderPlot({
        # generate bins based on input$bins from ui.R
        x    <- faithful[, 2]
        bins <- seq(min(x), max(x), length.out = input$bins + 1)

        # draw the histogram with the specified number of bins
        hist(x, breaks = bins, col = 'darkgray', border = 'white')
    })
    output$someText <- renderText({"This is some text"})
    output$someCode <- renderPrint({"This will look like console code"})
    output$table1 <- renderTable(head(CO2))
    output$table2 <- renderDataTable(CO2)
    output$table_reactable <- renderReactable(reactable(CO2))
    
    
}

# Run the application 
shinyApp(ui = ui, server = server)
