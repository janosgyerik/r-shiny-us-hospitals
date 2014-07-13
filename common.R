# Source:
# https://data.medicare.gov/data/hospital-compare
# Click on CSV Flat Files -- Revised, download and unzip
PATH <- 'data/Outcome of Care Measures.csv'

get.data <- function() {
  read.csv(PATH, colClasses = "character")
}

df <- get.data()
names(df) <- gsub('\\.', ' ', names(df))
names(df) <- gsub('   ', ' - ', names(df))
names(df) <- gsub('30 Day', '30-Day', names(df))

states <- unique(df$State)

outcomes <- tail(names(df), -10)

mid <- function(df, nmin, nmax) {
  tail(head(df, nmax), nmax - nmin + 1)
}

get.colnum <- function(df, name) {
  which(colnames(df) == name)
}
