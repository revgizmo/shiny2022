library(shiny)
library(bslib)
theme <- bs_theme()
theme <- bs_theme_update(theme, base_font = font_google("Raleway"), font_scale = NULL, 
                         bootswatch = "materia")

ui <- fluidPage(theme = theme,
                titlePanel("03 Ex Inputs"),
                
                
                sidebarLayout(sidebarPanel(
                  selectInput("menu1",
                              "Select grouping variable",
                              choices=c("County"="county","Category"="big_cat"))
                ),
                
                #mixing sidebarLayout and fluidRows
                mainPanel(
                  fluidRow(column(6, 
                                  textOutput("text1")),
                  column(6, h3(
                    "Barchart of categories sold here"
                  ))),
                  fluidRow(column(12, h2("Line plot goes here")))
                )))


server <- function(input, output) {
  #bs_themer()
  output$text1 <- renderText({input$menu1})
}


shinyApp(ui = ui, server = server)
