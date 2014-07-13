source('common.R')

library(shiny)

shinyUI(pageWithSidebar(
  
  headerPanel("US Hospitals"),
  
  sidebarPanel(
    selectInput("outcome",
                "Select outcome:",
                choices = outcomes),
    sliderInput("rank.range", 
                "Ranks to include:", 
                min = 1, 
                max = 20, 
                value = c(1, 20)),
    selectInput("state",
                "Select state:",
                choices = states),
    checkboxGroupInput("fields",
                       label = "Fields",
                       choices = names(df),
                       selected = c(
                         'Hospital Name',
                         'City',
                         'State'
                         ))
  ),
  
  mainPanel(
    tableOutput("filtered")
  )
))
