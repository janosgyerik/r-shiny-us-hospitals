source('common.R')

filter.by.state <- function(df, state) {
  subset(df, State == state)
}

clean.numeric.col <- function(df, name) {
  col <- get.colnum(df, name)
  #df <- subset(df, df[,col] != 'Not Available')
  df <- subset(df, grepl('[0-9]', df[,col]))
  df[,col] <- as.numeric(df[,col])
  df
}

rank.by.col <- function(df, name) {
  col <- get.colnum(df, name)
  df <- df[order(df[,col], df$'Hospital Name'),]
  df$Rank <- rank(df[,col], ties.method='min')
  df
}

### shiny part

library(shiny)

shinyServer(function(input, output) {
  filtered <- reactive({
    df <- filter.by.state(df, input$state)
    df <- clean.numeric.col(df, input$outcome)
    df <- rank.by.col(df, input$outcome)
    df <- df[,sapply(c('Rank', input$fields), function(name) get.colnum(df, name))]

    nmin <- input$rank.range[1]
    nmax <- input$rank.range[2]
    mid(df, nmin, nmax)
  })

  output$filtered <- renderTable(filtered())
})
