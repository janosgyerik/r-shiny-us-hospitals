source('common.R')

filter.by.state <- function(df, state) {
  subset(df, State == state)
}

clean.numeric.col <- function(df, name) {
  col <- get.colnum(df, name)
  df <- subset(df, df[,col] != 'Not Available')
  df[,col] <- as.numeric(df[,col])
  df
}

rank.by.col <- function(df, name) {
  col <- get.colnum(df, name)
  df <- df[order(df[,col], df$'Hospital Name'),]
  df$Rank <- 1:nrow(df)
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
  # todo: reverse order option
  # todo: fix rank# for ties

  output$filtered <- renderTable(filtered())
})
