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
                titlePanel("05 Ex Reactive"),
                
                
                sidebarLayout(sidebarPanel(
                  selectInput("menu1",
                              "Select grouping variable",
                              choices=c("County"="county","Category"="big_cat")),
                  dateRangeInput("datepick1","Pick a range for the line graph",start = "2020-01-01",end="2020-12-31",startview="year")
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
  
  # eventReactive
  # here, we take a reaction on a change in menu1 to recaculate the summary table
  res1 <- eventReactive(input$menu1, {
    dta |> 
      group_by(.data[[input$menu1]]) |> 
      summarize(sales_dollars = sum(sale_dollars,na.rm=T),
                sales_volume = sum(volume_sold_liters,na.rm=T)) |> 
      arrange(desc(sales_dollars)) |> 
      slice_head(n=10)
  })
  
  
  # output table 1
  # this now takes the results from the eventReactive when it is triggered
  output$tabl1 <- renderTable({
    req(res1())
    res1()
    })
  
  # reactive expression to filter the data when the dates change
  filtered_dta <- reactive({
    #message(input$date1[1])
    dta |> 
      # tidy eval to link the date picker values to dplyr variables !!input$datepick1[1]
      filter(month >= lubridate::month(!!input$datepick1[1]),
             month <= lubridate::month(!!input$datepick1[2]))
  })
  
  #output plot 1
  output$plot1 <- renderPlot({
    req(filtered_dta())
    filtered_dta() |> janitor::tabyl(big_cat) |> drop_na() |> arrange(desc(n)) |> ggplot(aes(x=big_cat,y=percent))+ geom_col()
  })
  
  #output plotly 1
  output$plotly1 <- renderPlotly({
    req(filtered_dta())
    filtered_dta() |> 
      group_by(month) |> 
      summarise(sales_dollars = sum(sale_dollars,na.rm=T)) |> 
      plot_ly(x = ~month, y = ~sales_dollars, type = 'scatter', mode = 'lines')
  })
}


shinyApp(ui = ui, server = server)
