# Source:
# https://data.medicare.gov/data/hospital-compare
# Click on CSV Flat Files -- Revised, download and unzip
PATH <- 'data/Outcome of Care Measures.csv'

get.data <- function() {
  df <- read.csv(PATH, colClasses = "character")
  for (col in length(df):11) {
    if (sum(grepl('[0-9]', df[,col])) == 0) {
      df[,col] <- NULL
    }
  }
  names(df) <- gsub('\\.', ' ', names(df))
  names(df) <- gsub('   ', ' - ', names(df))
  names(df) <- gsub('30 Day', '30-Day', names(df))
  df
}

df <- get.data()

states <- unique(df$State)

outcomes <- tail(names(df), -10)

mid <- function(df, nmin, nmax) {
  tail(head(df, nmax), nmax - nmin + 1)
}

get.colnum <- function(df, name) {
  which(colnames(df) == name)
}

get.colnum.wrapper <- function(df, nameOrNum) {
  ifelse(is.numeric(nameOrNum), nameOrNum, get.colnum(nameOrNum))
}
