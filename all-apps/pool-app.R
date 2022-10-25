library(shiny)
library(duckdb)
library(DBI)
library(pool)
library(tidyverse)
library(reactable)

con <- pool::dbPool(
  drv = duckdb::duckdb(),
  dbname = "dta",
  dbdir=":memory:"
)

dbWriteTable(con, #the name of the duckdb connection
             "iowa", #the name of the target table
            vroom::vroom("www/data/iowa_2022.csv"), #this is inside the www folder
              overwrite=TRUE)  

years_in_data <- dbGetQuery(con,"SELECT DISTINCT YEAR(sale_date) FROM iowa")
years_in_data <- years_in_data |> arrange(`year(sale_date)`) |> pull(`year(sale_date)`)

counties_in_data <- dbGetQuery(con,"SELECT DISTINCT county FROM iowa")
counties_in_data <- sort(str_to_title(counties_in_data$county))

ui <- fluidPage(
  
  titlePanel("Working with a Database"),
  
  
  sidebarLayout(
    sidebarPanel(
      selectInput("yr","Pick a year to display",choices=years_in_data),
      selectInput("county","Pick a county to display",choices=counties_in_data),
    ),
    
    
    mainPanel(
      verbatimTextOutput("vto1"),
      tableOutput("table1")
    )
  )
)

server <- function(input, output, session) {
  
  fetch_dta <- reactive( tbl(con,"iowa") |> 
                          filter(year(sale_date) == !!input$yr) |> 
                          filter(county == !!input$county) |> 
                          select(sale_date,store_number,store_name,sale_dollars) |> 
                          collect() )
  
  output$vto1 <- renderPrint(
    skimr::skim(fetch_dta())
  )
  
  output$table1 <- renderTable({
    head(fetch_dta(),20)
  })
  
}

shinyApp(ui, server)