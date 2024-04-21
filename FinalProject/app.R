#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)
library(tidyverse)


# Define UI for application that draws a histogram
ui <- fluidPage(
  
  # Application title
  titlePanel("The explosion of Congenital Syphillis and its consequences"),
  
  # Alter the plots
  sidebarLayout(
    sidebarPanel(varSelectInput("person", "Congenital or women aged 15-44",
                                CS_by_year%>%select(c(-Year, -X))),
                 selectInput("year", "Year after explosion", choices =CSsymptoms$Year,
                             selected = CSsymptoms$Year[2018])
                 
                 
    ),
    
    # Show two plots
    mainPanel(
      plotOutput("overall"),
      plotOutput("after")
      
    )
    
  )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  #option<-reactive({input$person})
  
  output$overall<-renderPlot({ggplot(data = CS_by_year, aes(x = Year, y=!!sym(input$person)))+geom_col()})
  
  #option1<-reactive({input$Year})
  datr<-reactive({data<-CSsymptoms
  data<-subset(data, Year ==input$year)
  return(data)})
  
  output$after<-renderPlot({#data<-CSsymptoms
    #data<-subset(data, Year = !!sym(input$year))
    ggplot(datr(), aes(x = Vital.Status, y = Cases))+geom_col()
  })
}

# Run the application
shinyApp(ui = ui, server = server)
