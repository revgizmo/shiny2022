library(shiny)

ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(),
    mainPanel(
      h1("This is a level 1 header"),
      h2("This is a level 2 header"),
      h4("This is a level 4 header"),
      h6("This is a level 6 header. It's actually smaller than a paragraph."),
      p("This is a paragraph")
      
    )
  )
)


server <- function(input, output, session) {
  
}

shinyApp(ui, server)