project2plot2 <- function() {
    
    # Exploratory Data Analysis
    # Course Project 2
    
    # Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? 
    # Use the base plotting system to make a plot answering this question. 
    
    # Download the file and extract the portion needed
    
    url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
    download.file(url, destfile = ".\\data\\nei.zip", mode = "wb")
    file <- unzip(".\\data\\nei.zip", exdir = ".\\data")
    
    # Read all the data and subset
    
    NEI <- readRDS(file[2])
    SCC <- readRDS(file[1])
    
    # Subset Baltimore, MD fips = 24510
    
    NEIbaltimore <- subset(NEI, NEI$fips==24510)
    
    # Subset by Year, Apply "sum" function
    
    pm25TotalYearBaltimore <- tapply(NEIbaltimore$Emissions, NEI$year, sum)
    
    # Open PNG Device
    png(filename = 'plot2.png', width = 480, height = 480)
    
    # Plot the Bar Graph to Visualize PM2.5 Emissions Each Year
    barplot(pm25TotalYearBaltimore , main = "Total Emissions by Year", xlab="Year", ylab="Emissions (tons)")
    ## source: Coursera Getting and Cleaning Data Class: Reshaping Data
    
    dev.off()
    