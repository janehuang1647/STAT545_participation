#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
# ehehehe

library(shiny)
library(tidyverse)

a <- 5
print(a^2)


bcl <- read.csv("bcl-data.csv", stringsAsFactors = FALSE)
# Define UI for application that draws a histogram
ui <- fluidPage(
  "this is some texts",
  br(),
  p("this is some texts"),
  tags$h1(em("level 1 header")),
  h1("test"),
  HTML("<H1>Level 1 header, part 3</h1>"),
  
  br(),
  p("what am i?"),
  a(href="http://stat545.com/Classroom/notes/cm107.nb.html#why-use-shiny","link to main page!"),
  print(a),
  br(),
  
  
  titlePanel("BC Liquor price app", 
             windowTitle = "BCL app"),
  sidebarLayout(
    sidebarPanel(
      # Add this slider to the sidebar panel so that the user can select a price range:
      
      sliderInput("priceInput", "Select your desired price range.",
                  min = 0, max = 100, value = c(15, 30), pre="$"),
      
      radioButtons("typeinput", "Select your alcoholic beverage type",
                   choices=c("BEER", "REFRESHMENT", "SPIRITS", "WINE"),
                   selected= "WINE")
      
    ),
    mainPanel(
      plotOutput("price_hist"),
      # plotOutput("plot2"),
      tableOutput("NEWTABLE")
    )
  ))

# Define server logic required to draw a histogram
# use input$... to access the input of some specific term
server <- function (input,output){
  observe(print(input$priceInput))
  
  bcl_filtered <- reactive({
    bcl %>% 
    filter(Price < input$priceInput[2], 
           Price >input$priceInput[1],
           Type == input$typeinput 
           )
  })
  
  output$price_hist <- renderPlot({
    bcl_filtered() %>% 
      ggplot(aes(Price))+
      geom_histogram()
    
  })
  
  # output$plot2 <- renderPlot(ggplot2::qplot(bcl$Price))  # can be other plot functions
  output$NEWTABLE <- renderTable(
    bcl_filtered()  
    
  )
} 

# Run the application 
shinyApp(ui = ui, server = server)

