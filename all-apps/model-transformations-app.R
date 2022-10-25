library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Model Transformation Exploration"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            h2("Choose a term transformation"),
            p("and see how it fits your data"),
            radioButtons("radio1","Model Tranformation",
            choices=c("Linear x"="lin",
                      "Quadratic x^2" = "quad",
                    "Cubic x^3" = "cub",
                    "Reciprocal 1/x" = "recip",
                    "Log log(x)" = "log",
                    "Exp e^-x" = "exp"))
        ),

        # Show a plot of the generated distribution
        mainPanel(
           plotOutput("plot1")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
    mod <- reactive({
      
      if (input$radio1 == "lin"){
        term <- "conc"
      } else if (input$radio1 == "quad") {
        term <- "conc + I(conc^2)"
      } else if (input$radio1 == "cub") {
        term <- "conc + I(conc^2) + I(conc^3)"
      } else if (input$radio1 == "recip") {
        term <- "I(1/conc)"
      } else if (input$radio1 == "log") {
        term <- "conc + I(log(conc))"
      } else if (input$radio1 == "exp") {
        term <- "conc + I(exp(-conc))"
      } else {
        term <- "1"
      }
      frmla <- formula(paste("uptake ~ ",term))
      modl <- lm(frmla,data=CO2)
      return(modl)
    })
    
    output$plot1 <- renderPlot({
       #plot(CO2$conc,CO2$uptake,pch=15,col="grey")
       #points(x=CO2$conc,y=mod(),col="pink",lwd=2,type="l")
      req(input$radio1)
      visreg::visreg(mod())
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
