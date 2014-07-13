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
  filtered <- reactive({
    df <- filter.by.state(df, input$state)
    df <- clean.numeric.col(df, input$outcome)
    df <- df[,sapply(input$fields, function(name) get.colnum(df, name))]

    nmin <- input$rank.range[1]
    nmax <- input$rank.range[2]
    mid(df, nmin, nmax)
  })
  # todo: order by outcome
  # todo: reverse order option
  # todo: show rank#

  output$filtered <- renderTable(filtered())
})
