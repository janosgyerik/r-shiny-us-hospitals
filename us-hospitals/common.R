path.source <- 'data/Outcome of Care Measures.csv'
path.cleaned <- 'cache/hospitals.cleaned.RData'
# file.remove(path.cleaned)

clean.data <- function() {
  df <- read.csv(path.source, colClasses = "character")
  for (col in length(df):11) {
    if (sum(grepl('[0-9]', df[,col])) == 0) {
      df[,col] <- NULL
    }
  }
  names(df) <- gsub('\\.', ' ', names(df))
  names(df) <- gsub('   ', ' - ', names(df))
  names(df) <- gsub('30 Day', '30-Day', names(df))
  names(df) <- gsub('Death  Mortality  Rates', 'Mortality Rates', names(df))

  hnames <- df$'Hospital Name'
  hnames <- gsub('MED CENTER', 'M.C.', hnames)
  hnames <- gsub('MEDICAL CENTER', 'M.C.', hnames)
  hnames <- gsub('MEDICAL CTR', 'M.C.', hnames)
  hnames <- gsub('MED CENTER', 'M.C.', hnames)
  hnames <- gsub('MEMORIAL HOSPITAL', 'M.H.', hnames)
  hnames <- gsub('HOSPITALS CENTER', 'H.C.', hnames)
  hnames <- gsub('HOSPITAL CENTER', 'H.C.', hnames)
  hnames <- gsub('HOSPITALS', 'H.', hnames)
  hnames <- gsub('HOSPITAL', 'H.', hnames)
  hnames <- gsub('HEALTH SYSTEM', 'H.S.', hnames)
  hnames <- gsub(', THE$', '', hnames)
  hnames <- gsub('HEALTHCARE', 'HC.', hnames)
  hnames <- gsub('UNIVERSITY', 'UNIV.', hnames)
  hnames <- gsub('SYSTEMS', 'S.', hnames)
  hnames <- gsub('SYSTEM', 'S.', hnames)
  hnames <- gsub('CENTERS', 'C.', hnames)
  hnames <- gsub('CENTER', 'C.', hnames)
  df$Hospital <- hnames
  df
}

save.cleaned.data <- function() {
  df <- clean.data()
  save(df, file=path.cleaned)
}

load.cleaned.data <- function() {
  if (!file.exists(path.cleaned)) {
    parent <- dirname(path.cleaned)
    if (!file.exists(parent)) {
      dir.create(parent)
    }
    save.cleaned.data()
  }
  load(file=path.cleaned)
  df
}

df <- load.cleaned.data()

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
