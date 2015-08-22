project2plot3 <- function() {
    
    # Exploratory Data Analysis
    # Course Project 2
    
    # Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
    # which of these four sources have seen decreases in emissions from 1999-2008 for Baltimore City? 
    # Which have seen increases in emissions from 1999-2008? Use the ggplot2 plotting system to make a 
    # plot answer this question. Save as plot3.png.
    
    # Download the file and extract the portion needed
    
    url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
    download.file(url, destfile = ".\\data\\nei.zip", mode = "wb")
    file <- unzip(".\\data\\nei.zip", exdir = ".\\data")
    
    # Read all the data and subset
    
    NEI <- readRDS(file[2])
    SCC <- readRDS(file[1])
    
    # Subset Baltimore, MD fips = 24510
    
    NEIbaltimore <- subset(NEI, NEI$fips==24510)

    # Group by Type and Year, Summarize with "sum" function
    
    library(dplyr)
    NEIbaltimore <- group_by(NEIbaltimore, type, year)
    baltimorePM25summary <- summarize(NEIbaltimore, pm25 = sum(Emissions, na.rm = TRUE))
    ## source: https://class.coursera.org/exdata-031/forum/thread?thread_id=186#post-770

    # Plot the GGPlot graphs to Visualize PM2.5 Emissions Each Year for Different Types
    library(ggplot2)
    g <- ggplot(data = baltimorePM25summary, aes(x=year, y=pm25, fill=type)) + 
        geom_bar(stat="identity", position="dodge") + 
        ggtitle("Total Emissions by Type and Year in Baltimore") + 
        xlab("Year") + 
        ylab("Emissions (tons)") + 
        xlim(1997,2008)
    
    ggsave(g, file = "plot3.png")
}