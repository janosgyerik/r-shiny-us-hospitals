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

apply.params <- function(state, outcome, rank.range) {
  df <- filter.by.state(df, state)
  df <- clean.numeric.col(df, outcome)
  df <- rank.by.col(df, outcome)
  nmin <- rank.range[1]
  nmax <- rank.range[2]
  mid(df, nmin, nmax)
}

### shiny part

library(shiny)

shinyServer(function(input, output) {
  filtered <- reactive({
    apply.params(input$state, input$outcome, input$rank.range)
  })

  output$filtered <- renderTable({
    df <- filtered()
    df[,sapply(c('Hospital Name', 'Rank', 'Value', input$fields), function(name) get.colnum(df, name))]
  })

  output$outcome <- renderText(input$outcome)

  output$barplot <- renderPlot({
    df <- filtered()
    names <- df$'Hospital Name'
    names <- gsub('MED CENTER', 'M.C.', names)
    names <- gsub('MEDICAL CENTER', 'M.C.', names)
    names <- gsub('MEMORIAL HOSPITAL', 'M.H.', names)
    names <- gsub('HOSPITAL', 'H.', names)
    #par(mfrow=c(1,1), mar=c(2,15,2,2))
    #barplot(rev(df$Value), horiz=T, names.arg=rev(names), las=2, col='lightblue')
    #title(main=input$outcome)
    df$x = df$Value
    df$y = names
    ggplot(df, aes(x=x, y=reorder(y, -x))) +
      geom_point(colour='red') +
      ylab('') + xlab('') +
      ggtitle(input$outcome) +
      geom_segment(aes(yend=y), xend=0, colour="grey50") +
      theme_bw()
  })
})
