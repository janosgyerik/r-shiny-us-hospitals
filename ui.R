source('common.R')

library(shiny)

shinyUI(pageWithSidebar(
  
  headerPanel("US Hospitals"),
  
  sidebarPanel(
    sliderInput("rank.range", 
                "Ranks to include:", 
                min = 1, 
                max = 20, 
                value = c(1, 20)),
    selectInput("state",
                "Select state:",
                choices = states)
  ),
  
  mainPanel(
    tableOutput("filtered")
  )
))
