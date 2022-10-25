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
# this code taken from reactable reference docs
bar_style <- function(width = 1, fill = "#e6e6e6", height = "75%", align = c("left", "right"), color = NULL) {
  align <- match.arg(align)
  if (align == "left") {
    position <- paste0(width * 100, "%")
    image <- sprintf("linear-gradient(90deg, %1$s %2$s, transparent %2$s)", fill, position)
  } else {
    position <- paste0(100 - width * 100, "%")
    image <- sprintf("linear-gradient(90deg, transparent %1$s, %2$s %1$s)", position, fill)
  }
  list(
    backgroundImage = image,
    backgroundSize = paste("100%", height),
    backgroundRepeat = "no-repeat",
    backgroundPosition = "center",
    color = color
  )
}

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Old Faithful Geyser Data"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            #nothing yetre
        ),

        # Show a plot of the generated distribution
        mainPanel(
           textOutput("someText"),
           reactableOutput("table")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$someText <- renderText({"This formatting doesn't really make sense, it's just to demo"})
    co2_sample <- dplyr::sample_n(CO2,10)
    #this formatting doesn't really make sense, it's just to demo.
    output$table <- renderReactable({
      reactable(co2_sample,
                columns = list(
                  Treatment = colDef(
                    style = function(value) {
                      if (value == "chilled") {
                        color <- "#ccffff"
                      } else {
                        color <- "#ffcccc"
                      }
                      list(background = color, fontWeight = "bold")
                    }
                  ),
                  Type = colDef(
                    style = function(value) {
                      if (value == "Quebec") {
                        color <- "#cc3399"
                      } else {
                        color <- "#33cc33"
                      }
                      list(color = color)
                    }
                  ),
                  uptake = colDef(
                    style = function(value) {
                      bar_style(width = value / max(co2_sample$uptake), fill = "hsl(208, 70%, 90%)")
                    }
                  ),
                  conc = colDef(
                    format = colFormat(separators = T, digits = 2),
                    style = function(value) {
                      bar_style(width = value / max(co2_sample$conc), height = "70%", align = "right",fill="#ff6699")
                    }
                  )
                ))
    })
    
}

# Run the application 
shinyApp(ui = ui, server = server)
