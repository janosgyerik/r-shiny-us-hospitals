url.data <- 'https://data.medicare.gov/data/hospital-compare'
url.sourcecode <- 'https://github.com/janosgyerik/r-shiny-us-hospitals'

about <- list(
  p('This is a simple data visualization tool for hospitals in the United States.'),
  p('You can rank hospitals by mortality rates from various causes,',
    'such as heart failure, heart disease, pneumonia, and others.',
    'You can filter the results by state,',
    'and select the data fields to display.'),
  p('The hospital data is publicly available from the Data.Medicare.Gov website.',
    'You can download the same data set by following these steps:'),
  tag('ul', list(
    tag('li', list('Go to', a(href=url.data, url.data))),
    tag('li', list('Click on', strong('CSV Flat Files - Revised'))),
    tag('li', list('Extract the file', strong('Outcome of Care Measures.csv'), 'from the ZIP file'))
  )),
  p('This is an open-source project.',
    'You can see the source code and report problems on GitHub:'),
  p(a(url.sourcecode, href=url.sourcecode)),
  hr(),
  p('This site is built using', a('Shiny by RStudio', href='http://shiny.rstudio.com/'))
)
