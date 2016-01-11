library(knitr)
library(markdown)
library(Hmisc)
library(rms)


# Set Working Directory from clipboard
# wd <- normalizePath(readClipboard(), "/", mustWork = FALSE)
wd <- "Z:/Drive/Archive Settings/Git/recodePDFtable"
setwd(wd)
getwd()

knit2html("PDF_table_reformatting.Rmd")
browseURL("PDF_table_reformatting.html")



