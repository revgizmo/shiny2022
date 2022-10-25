#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinythemes)
# Define UI for application that draws a histogram
ui <- fluidPage(theme=shinytheme("flatly"),
                
                # Application title
                titlePanel("Flatly theme!"),
                
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
                    h1("sales by county"),
                    h3("Total sales by county in terms of dollars"),
                    p("sales_by_county_dollars"),
                    br(),

                    h1("Cagegory Frequency"),
                    h3("Most frequently sold counts of category names"),
                    p("category_freq"),
                    br(),
                    
                    h1("sales by category"),
                    h3("Total sales by category in terms of dollars sales_by_county_dollars"), 
                    p("sales_by_category"),
                    br(),
                    
                    h1("sales by category - simplified"),
                    h3("Most frequently sold counts of category names"), 
                    p('Create a variable that simplifies the categories. We choose "Whisky," "Vodka," "Rum," "Gin," "Liqueur" and "other," but you can choose your own. cagegory_condensed'),
                    br(),
                    
                    h1("sales by month for 2020"),
                    h3("Summarise the total sales by month for 2020"), 
                    p("sales_by_month"),
                    br(),
                    
                    br(),
                    plotOutput("distPlot")

                    
                    # 
# -   Which of these can be represented by tables? Which might lend themselves to visualizations? We've provided one possible solution, but you can choose your own.
# 
# # Populate the Shiny layout with placeholders
# 
# -   populate that Shiny layout with placeholders.
# 
#     -   Just use simple components, like `p()`aragraphs or `h1()`, `h2()` , ... headers
# ")
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


# 
# -   Most frequently sold counts of category names category_freq
# 
# -   Create a variable that simplifies the categories. We choose "Whisky," "Vodka," "Rum," "Gin," "Liqueur" and "other," but you can choose your own. cagegory_condensed
# 
# -   Summarize the count of sales by your simplified categories.
# 
# -   Summarise the total sales by month for 2020
# 
# -   Which of these can be represented by tables? Which might lend themselves to visualizations? We've provided one possible solution, but you can choose your own.
# 
# # Populate the Shiny layout with placeholders
# 
# -   populate that Shiny layout with placeholders.
# 
#     -   Just use simple components, like `p()`aragraphs or `h1()`, `h2()` , ... headers
# 
# # Making a theme
# 
# -   Also customize a theme for your app. To do this, use the `bslib()` package.
# 
# -   Copy the code from the bs-theme.app to make your theme interaction. Pick colors and fonts, and then be sure to **copy your theme customization** from the console into your app!
# 
#     -   Note: since we are using placeholders, you may not have all the widgets yet nor see their full theming. You may revisit this customization again later.