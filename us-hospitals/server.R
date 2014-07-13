source('common.R')

filter.by.state <- function(df, state) {
  subset(df, State == state)
}

clean.numeric.col <- function(df, name) {
  col <- get.colnum(df, name)
  df <- subset(df, grepl('[0-9]', df[,col]))
  df[,col] <- as.numeric(df[,col])
  df
}

rank.by.col <- function(df, name) {
  col <- get.colnum(df, name)
  df <- df[order(df[,col], df$'Hospital Name'),]
  df$Rank <- rank(df[,col], ties.method='min')
  df$Value <- df[,col]
  df
}

### shiny part

library(shiny)

shinyServer(function(input, output) {
  filtered <- reactive({
    df <- filter.by.state(df, input$state)
    df <- clean.numeric.col(df, input$outcome)
    df <- rank.by.col(df, input$outcome)
    df <- df[,sapply(c('Hospital Name', 'Rank', 'Value', input$fields), function(name) get.colnum(df, name))]

    nmin <- input$rank.range[1]
    nmax <- input$rank.range[2]
    mid(df, nmin, nmax)
  })

  output$filtered <- renderTable(filtered())

  output$outcome <- renderText(input$outcome)

  output$barplot <- renderPlot({
    df <- filtered()
    names <- df$'Hospital Name'
    names <- gsub('MED CENTER', 'M.C.', names)
    names <- gsub('MEDICAL CENTER', 'M.C.', names)
    names <- gsub('MEMORIAL HOSPITAL', 'M.H.', names)
    names <- gsub('HOSPITAL', 'H.', names)
    par(mfrow=c(1,1), mar=c(2,15,2,2))
    barplot(rev(df$Value), horiz=T, names.arg=rev(names), las=2)
    title(main=input$outcome)
  })
})
