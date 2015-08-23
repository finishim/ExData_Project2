project2plot6 <- function() {
    
    # Exploratory Data Analysis
    # Course Project 2
    
    # Compare emissions from motor vehicle sources in Baltimore City with emissions from 
    # motor vehicle sources in Los Angeles County, California (fips == "06037"). 
    # Which city has seen greater changes over time in motor vehicle emissions?
    
    # Download the file and extract the portion needed
    
    url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
    download.file(url, destfile = ".\\data\\nei.zip", mode = "wb")
    file <- unzip(".\\data\\nei.zip", exdir = ".\\data")
    
    # Read all the data
    
    NEI <- readRDS(file[2])
    SCC <- readRDS(file[1])
}