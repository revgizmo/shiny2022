library(shiny)


ui <- fluidPage(

    # Application title
    titlePanel("Tidy Eval Demo"),

    # Sidebar with a selectize input
    sidebarLayout(
        sidebarPanel(
            selectizeInput("grpvar","Select a grouping variable",
                           choices=c("Plant","Type"))
        ),

        # Show results
        mainPanel(
           verbatimTextOutput("vto1")
        )
    )
)

# Define server logic 
server <- function(input, output) {

    output$vto1 <- renderPrint({
      CO2 |> 
        group_by(.data[[input$grpvar]], Treatment) |> 
        summarise(avg_uptake = mean(uptake,na.rm=T)) |> 
        ungroup() |> 
        pivot_wider(id_cols=.data[[input$grpvar]], values_from = avg_uptake, names_from = Treatment)
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
