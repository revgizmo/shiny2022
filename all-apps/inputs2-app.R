#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Old Faithful Geyser Data"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
          sliderInput( inputId="my-slider",
                       label='A range of values',
                       min = 0,
                       max = 100,
                       value = 0,
                       step = 5,
                       animate = TRUE),
          radioButtons("iceCream",label="Ice Cream Favorite Flavor",
                       choices = c("None"="none",
                                   "Vanilla" = "van",
                                   "Chocolate" = "choc",
                                   "Mango" = "mango",
                                   "Pistachio" = "pist",
                                   "Vegan Creme Soda" = "vegan"),
                       selected="vegan",
                       inline=T),
          checkboxGroupInput("cbox","My favorite R colors:",
                             choices = c("Burlywood"='burlywood',
                                         "Peachpuff3"='peachpuff3',
                                         "Lavenderblush4"='lavenderblush4',
                                         "Honeydew2"='honeydew2'),
                             selected=c('burlywood','honeydew2')),
          textInput("thoughts",label="How is your day going?", value="great!", width="150px"),
          selectizeInput("my-menu","For a mixed bouquet of flowers, I prefer...",
                        choices=c("Roses"='roses',
                                  "Iris"='iris',
                                  "Gladioli"='gladioli',
                                  "Peonies"='peonies'),
                        multiple=TRUE),
          dateRangeInput("vacation","My vacation will be ",
                         start="2022-01-01",end="2023-12-31",
                         format="M d, yy", startview="month",
                         language="fr"),
          fileInput("my-csvs","uploaded-csvs",multiple=F,accept=c('.csv','.rds'),
                    width="200px",buttonLabel = "upload!",
                    placeholder="upload csv or rds"),
          actionButton("do-it","Smash!",width="90%"),
            sliderInput("bins",
                        "Number of bins:",
                        min = 1,
                        max = 50,
                        value = 30)
        ),

        # Show a plot of the generated distribution
        mainPanel(
          div("This is my first div"),
          varSelectInput("my-vars",
                         "Choose your variables for analysis", 
                         data=mtcars,
                         multiple=T,
                         width="85%"),
          p('This is ',strong('strong'), ' or ', em('emphasis'), ' or ', code('a code example.')),
          p("Flexitarian portland everyday carry, heirloom vaporware viral artisan raclette health goth. Pitchfork heirloom you probably haven't heard of them tacos +1 whatever affogato williamsburg listicle vinyl forage paleo pour-over. Copper mug taxidermy cloud bread, fingerstache actually 90's tattooed succulents bitters hoodie austin banh mi vegan ugh. Actually put a bird on it cronut poutine chartreuse tofu, irony chambray dreamcatcher street art. Hoodie williamsburg pitchfork bicycle rights mixtape, fanny pack tumblr everyday carry whatever. Single-origin coffee cardigan viral skateboard fashion axe."),
          p("Palo santo marfa quinoa artisan glossier crucifix cloud bread YOLO fashion axe organic umami godard. Art party af helvetica la croix sustainable ennui vegan thundercats raw denim. Blue bottle subway tile sartorial slow-carb normcore chambray air plant crucifix raclette forage listicle chia. Squid hell of raclette pitchfork craft beer +1 thundercats swag celiac plaid copper mug subway tile put a bird on it selfies. Wolf kickstarter hammock next level, kogi mixtape vape man braid direct trade lumbersexual williamsburg chambray adaptogen."),
          p("Lomo pok pok direct trade photo booth roof party kitsch, brunch fanny pack. +1 bitters chartreuse kickstarter, glossier craft beer PBR&B copper mug health goth twee. Leggings vaporware vice, slow-carb readymade hammock hella meggings umami wayfarers sartorial. Blog leggings cardigan biodiesel glossier everyday carry small batch succulents."),
          plotOutput("distPlot")
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
