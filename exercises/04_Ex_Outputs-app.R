library(shiny)
library(bslib)
library(tidyverse)
library(thematic) # to extend theme to ggplot
library(plotly)
theme <- bs_theme()
theme <- bs_theme_update(theme, base_font = font_google("Raleway"), font_scale = NULL, 
                         bootswatch = "materia")

dta <- readRDS("./www/Data/iowa_2020.RDS")

ui <- fluidPage(theme = theme,
                titlePanel("04 Ex Inputs"),
                
                
                sidebarLayout(sidebarPanel(
                  selectInput("menu1",
                              "Select grouping variable",
                              choices=c("County"="county","Category"="big_cat"))
                ),
                
                #mixing sidebarLayout and fluidRows
                mainPanel(
                  fluidRow(column(6, 
                                  tableOutput("tabl1")),
                  column(6, plotOutput("plot1"))),
                  fluidRow(column(12, plotlyOutput("plotly1")))
                )))


server <- function(input, output) {
  bs_themer()
  thematic::thematic_shiny() #this will draw some colors from the theme into ggplots (like background colors)
  
  # output table 1
  output$tabl1 <- renderTable({
    dta |> 
      summarize(sales_dollars = sum(sale_dollars,na.rm=T),
                sales_volume = sum(volume_sold_liters,na.rm=T)) |> 
      arrange(desc(sales_dollars))
    })
  
  #output plot 1
  output$plot1 <- renderPlot({
    dta |> janitor::tabyl(big_cat) |> arrange(desc(n)) |> ggplot(aes(x=big_cat,y=percent))+ geom_col()
  })
  
  #output plotly 1
  output$plotly1 <- renderPlotly({
    dta |> 
      group_by(lubridate::month(date)) |> 
      summarise(sales_dollars = sum(sale_dollars,na.rm=T)) |> 
      rename(month=`lubridate::month(date)`) |> 
      plot_ly(x = ~month, y = ~sales_dollars, type = 'scatter', mode = 'lines')
  })
}


shinyApp(ui = ui, server = server)
