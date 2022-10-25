library(shiny)
library(bslib)


theme <- bs_theme()
theme <- bs_theme_update(theme, base_font = font_google("Raleway"), font_scale = NULL, 
                         bootswatch = "materia")

ui <- fluidPage(theme = theme,
                titlePanel("02 Ex Layout"),
                
                
                sidebarLayout(sidebarPanel(h3(
                  "Change grouping variable here"
                )),
                
                #mixing sidebarLayout and fluidRows
                mainPanel(
                  fluidRow(column(6, h3(
                    "Table Output will go here"
                  )),
                  column(6, h3(
                    "Barchart of categories sold here"
                  ))),
                  fluidRow(column(12, h2("Line plot goes here")))
                )))


server <- function(input, output) {
  #bs_themer()
}


shinyApp(ui = ui, server = server)
