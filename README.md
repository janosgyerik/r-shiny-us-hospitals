US Hospitals (R Shiny)
======================
This is a simple data visualization tool for hospitals in the United States.

You can rank hospitals by mortality rates from various causes,
such as heart failure, heart disease, pneumonia, and others.
You can filter the results by state, and select the data fields to display.

The hospital data is publicly available from the Data.Medicare.Gov website.
You can download the same data set by following these steps:
  
1. Go to https://data.medicare.gov/data/hospital-compare
2. Click on **CSV Flat Files - Revised**
3. Extract the file **Outcome of Care Measures.csv** from the ZIP file

## Deploying to shinyapps.io

Simply run these commands inside the directory of your Shiny app:

```R
library(shinyapps)
deployApp()
```

It takes a while. When completed, R will open the app's page in your browser.

For more details, [see the docs][2].

---
This site is built using [Shiny by RStudio][1]

[1]: http://shiny.rstudio.com/
[2]: https://github.com/rstudio/shinyapps/blob/master/guide/guide.md