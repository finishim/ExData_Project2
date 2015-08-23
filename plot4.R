project2plot4 <- function() {
    
    # Exploratory Data Analysis
    # Course Project 2
    
    # Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008?
    
    # Download the file and extract the portion needed
    
    url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
    download.file(url, destfile = ".\\data\\nei.zip", mode = "wb")
    file <- unzip(".\\data\\nei.zip", exdir = ".\\data")
    
    # Read all the data
    
    NEI <- readRDS(file[2])
    SCC <- readRDS(file[1])
    
    # Subset only the coal combustion
    
    selectCoal <- grep("^fuel comb -(.*)- coal$", SCC$EI.Sector, ignore.case=T)
    sccCoal <- SCC[selectCoal,]
    ## source: https://class.coursera.org/exdata-031/forum/thread?thread_id=60#post-406
    
    # Subset those rows in NEI that relate to coal combustion
    
    neiCoal <- subset(NEI, SCC %in% sccCoal$SCC)
    
    # Group by Type and Year, Summarize with "sum" function
    
    library(dplyr)
    neiCoal <- group_by(neiCoal, type, year)
    neiCoalSummary <- summarize(neiCoal, pm25 = sum(Emissions, na.rm = TRUE))
    
    # Draw the plot
    
    library(ggplot2)
    
    # Open PNG Device
    png(filename = 'plot4.png', width = 480, height = 480)
    
    # Display the Total Emissions by all types, but if needed one can learn how much by each type
    # So get the bars to overlap this time with different "type"
    g <- ggplot(data = neiCoalSummary, aes(x=year, y=pm25, fill=type)) + 
        geom_bar(stat="identity") + 
        ggtitle("Total Emissions by Type in US from Coal Combustion-Related Sources by Year") + 
        xlab("Year") + 
        ylab("Emissions (tons)") + 
        xlim(1997,2010)
    
    print(g)
    dev.off()
}