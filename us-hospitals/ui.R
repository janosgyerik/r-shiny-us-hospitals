source('common.R')

library(shiny)

source('about.R')

shinyUI(fluidPage(
  
  titlePanel("US Hospitals"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput("outcome",
                  h4("Rank by"),
                  choices = outcomes),
      sliderInput("rank.range",
                  h4("Ranks to include"),
                  min = 1,
                  max = 100,
                  value = c(1, 20)),
      selectInput("state",
                  h4("State"),
                  choices = states),
      checkboxGroupInput("fields",
                         h4("Fields"),
                         choices = names(df))
    ),
    mainPanel(
      tabsetPanel(type = "tabs", selected = "Plot",
                  tabPanel("About", about),
                  tabPanel("Table",
                           h3(textOutput('outcome')),
                           tableOutput("filtered")),
                  tabPanel('Plot', plotOutput('barplot'))
      )
    )
  )
))