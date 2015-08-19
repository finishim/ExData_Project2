project2plot1 <- function() {
    
    # Exploratory Data Analysis
    # Course Project 2
    
    # Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
    # Using the base plotting system, make a plot showing the total PM2.5 emission from all sources 
    # for each of the years 1999, 2002, 2005, and 2008.
    
    # Download the file and extract the portion needed
    
    url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
    download.file(url, destfile = ".\\data\\nei.zip", mode = "wb")
    file <- unzip(".\\data\\nei.zip", exdir = ".\\data")
    
    # Read all the data and subset
    
    NEI <- readRDS(file[2])
    SCC <- readRDS(file[1])
