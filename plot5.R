project2plot5 <- function() {
    
    # Exploratory Data Analysis
    # Course Project 2
    
    # How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?
    
    # Download the file and extract the portion needed
    
    url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
    download.file(url, destfile = ".\\data\\nei.zip", mode = "wb")
    file <- unzip(".\\data\\nei.zip", exdir = ".\\data")
    
    # Read all the data
    
    NEI <- readRDS(file[2])
    SCC <- readRDS(file[1])
    
    # Subset NEI to Baltimore, MD
    
    NEIbaltimore <- subset(NEI, NEI$fips==24510)
    
    # Subset SCC to Vehicle Sources
    # EI.Sector ends with "Vehicles"
    
    selectVehicle <- grep("Vehicles$", SCC$EI.Sector, ignore.case=T)
    sccVehicle <- SCC[selectVehicle,]
    
    # Subset those rows in NEIbaltimore that relate to coal combustion
    
    neiVehicle <- subset(NEIbaltimore, SCC %in% sccVehicle$SCC)
    
    # Group by Type and Year, Summarize with "sum" function
    
    library(dplyr)
    neiVehicle <- group_by(neiVehicle, type, year)
    neiVehicleSummary <- summarize(neiVehicle, pm25 = sum(Emissions, na.rm = TRUE))
    
    # Draw the plot
    
    library(ggplot2)
    
    # Display the Total Emissions by all types, but if needed one can learn how much by each type
    # So get the bars to overlap this time with different "type"
    g <- ggplot(data = neiVehicleSummary, aes(x=year, y=pm25)) + 
        geom_bar(stat="identity", fill="steelblue") + 
        ggtitle("Total Emissions from Motor Vehicles in Baltimore 1999-2008") + 
        xlab("Year") + 
        ylab("Emissions (tons)") + 
        xlim(1997,2010)
    
    ggsave(g, file = "plot5.png")
}