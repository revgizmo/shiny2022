#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

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
          markdown("
## Chapter I

### St. Jago-- Cape de Verd Islands

AFTER having been twice driven back by *heavy* southwestern gales, Her Majesty's ship **Beagle**, a ten-gun brig, under the command of Captain Fitz Roy, R. N., sailed from Devonport on the 27th of December, 1831.

-   The object of the expedition was to complete the survey of Patagonia and Tierra del Fuego, commenced under Captain King in 1826 to 1830,--to survey the shores of Chile, Peru, and of some islands in the Pacific--and to carry a chain of chronometrical measurements round the World.

-   On the 6th of January we reached [Teneriffe](https://en.wikipedia.org/wiki/Tenerife), but were prevented landing, by fears of our bringing the cholera: the next morning we saw the sun rise behind the rugged outline of the Grand Canary island, and suddenly illuminate the Peak of Teneriffe, whilst the lower parts were veiled in fleecy clouds.

1.  This was the first of many delightful days never to be forgotten.
2.  On the 16th of January, 1832, we anchored at Porto Praya, in St. Jago, the chief island of the Cape de Verd archipelago.
"),
a(href='https://www.gutenberg.org/files/944/944-0.txt', 'The Voyage of the Beagle'),
br(),
          img(src='images/campfires.jpeg', alt='Four ways of building a fire', width="150", height="150"),
plotOutput("distPlot")
         
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
}

# Run the application 
shinyApp(ui = ui, server = server)
