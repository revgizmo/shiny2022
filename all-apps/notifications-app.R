library(shiny)

# adding a confirmation window

modal_confirm <- modalDialog(
  "Do you really want to do this?",
  title = "In the danger zone",
  footer = tagList(
    actionButton("cancel","Cancel",class="btn btn-info"),
    actionButton("ok","Confirm",class="btn btn-danger")
  )
)
# Define UI for application that draws a histogram
ui <- fluidPage(
    
    # Application title
    titlePanel("Notifications"),

     
    sidebarLayout(
        sidebarPanel(
            actionButton("but1","Press me!",class="btn btn-primary"),
            p(),
            actionButton("but2","Head into the Danger Zone!", class="btn btn-warning")
        ),

        # Show a plot of the generated distribution
        mainPanel(
           textOutput("to")
        )
    )
)


server <- function(input, output) {
    observeEvent(input$but1,{
      showNotification("You pressed!", type="message")
    })
    observeEvent(input$but2,{
      showModal(modal_confirm)
    })
    observeEvent(input$ok,{
      showNotification("Approved",type="warning")
      removeModal()
    })
    observeEvent(input$cancel,{
      showNotification("Denied!",type="error")
      removeModal()
    })
    
    output$to <- renderText("nothing too exciting here")
}

# Run the application 
shinyApp(ui = ui, server = server)
