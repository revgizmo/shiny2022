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
            #nothing yet
        ),

        # Show a plot of the generated distribution
        mainPanel(
           textOutput("someText"),
           verbatimTextOutput("someCode"),
           tableOutput("table1"),
           dataTableOutput("table2"),
           reactableOutput("table-reactable")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$someText <- renderText({"This is some text"})
    output$someCode <- renderPrint({"This will look like console code"})
    output$table1 <- renderTable(head(CO2))
    output$table2 <- renderDataTable(CO2)
    co2_sample <- dplyr::sample_n(CO2,10)
    #this formatting doesn't really make sense, it's just to demo.
    
}

# Run the application 
shinyApp(ui = ui, server = server)
