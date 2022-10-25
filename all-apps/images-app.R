library(shiny)


ui <- fluidPage(

    # Application title
    titlePanel("Images Demo"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
          selectInput("id", 
                      "Pick a flower", 
                      choices = c("daffodil","tulip")),
          
        ),

        # Show the image
        mainPanel(
          imageOutput("photo")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$photo <- renderImage({
      list(
        src="./images/tulip.jpg",
        width=500
      )
    }, deleteFile=F)
}

# Run the application 
shinyApp(ui = ui, server = server)
