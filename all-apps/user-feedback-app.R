
library(shiny)


ui <- fluidPage(
    #sets up the nested html and javascript to display feedback
    shinyFeedback::useShinyFeedback(),
    
    
    titlePanel("Demo App"),

    
    sidebarLayout(
        sidebarPanel(
            p("We should really be specific about allowed values."),
            p("But if we weren't, how could we alert the user?..."),
            p("Try entering a negative number:"),
            textInput("ti1","Input a value", value="enter a value"),
            p("And a number greater than 100:"),
            textInput("ti2","Input a value", value="enter another value"),
            p("And the number 42:"),
            textInput("ti3","Input a value", value="enter another value"),
            p("Then correct your inputs to make them in bounds (between 0 and 100)")
        ),

        
        mainPanel(
          h3("The answer will appear when the inputs are right..."),
           textOutput("to")
        )
    )
)


server <- function(input, output, session) {

    tout <- reactive({
      tinum1 <- readr::parse_number(input$ti1)
      tinum2 <- readr::parse_number(input$ti2)
      tinum3 <- readr::parse_number(input$ti3)
      pass1 <- tinum1 < 0
      shinyFeedback::feedbackWarning("ti1",pass1,"Less than 0")
      pass2 <- tinum2 <= 100
      shinyFeedback::feedbackDanger("ti2",pass2,"Greater than 100")
      pass3 <- tinum3 == 42
      shinyFeedback::feedbackSuccess("ti3",pass3,"The answer!")
      req(!pass1 & !pass2 & pass3)
      tinum1 + tinum2 + tinum3
    })
    
    output$to <- renderText(tout())
}

# Run the application 
shinyApp(ui = ui, server = server)
