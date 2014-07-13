source('common.R')

library(shiny)

shinyUI(pageWithSidebar(
  
  headerPanel("US Hospitals"),
  
  sidebarPanel(
    selectInput("outcome",
                h4("Rank by"),
                choices = outcomes),
    sliderInput("rank.range", 
                h4("Ranks to include"),
                min = 1, 
                max = 50,
                value = c(1, 20)),
    selectInput("state",
                h4("State"),
                choices = states),
    checkboxGroupInput("fields",
                       h4("Fields"),
                       choices = names(df))
  ),
  
  mainPanel(
    tableOutput("filtered")
  )
))
