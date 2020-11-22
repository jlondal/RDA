cat(".Rprofile: Setting UK repositoryn")
r = getOption("repos") # hard code the UK repo for CRAN
r["CRAN"] = "http://cran.uk.r-project.org"
options(repos = r)
rm(r)

install.packages("keras")
install.packages("gridExtra")
install.packages("xts")
install.packages("DAAG")
install.packages("dplyr")
install.packages("lubridate")
install.packages("zoo")
install.packages("lattice")
install.packages("xgboost")
install.packages("sqldf")
install.packages("randomForest")
install.packages("RPostgreSQL")
