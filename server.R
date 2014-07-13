source('common.R')

filter.by.state <- function(df, state) {
  subset(df, State == state)
}

clean.numeric.col <- function(df, col) {
  if (!is.numeric(col)) {
    col <- get.colnum(df, col)
  }
  df <- subset(df, df[,col] != 'Not Available')
  df[,col] <- as.numeric(df[,col])
  df
}

### shiny part

library(shiny)

shinyServer(function(input, output) {
  nmin <- reactive(input$rank.range[1])
  nmax <- reactive(input$rank.range[2])
  filtered <- reactive(filter.by.state(df, input$state))
  filtered <- reactive(clean.numeric.col(df, input$outcome))
   
  output$filtered <- renderTable(mid(filtered(), nmin(), nmax()))
})
