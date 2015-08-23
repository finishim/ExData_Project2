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
    
    # Subset NEI to Baltimore, MD
    
    NEIbaltimore <- subset(NEI, NEI$fips==24510)
    
    # Subst NEI to Los Angeles, CA
    
    NEIlosangeles <- subset(NEI, NEI$fips=="06037")

    # Subset SCC to Vehicle Sources
    # EI.Sector ends with "Vehicles"
    
    selectVehicle <- grep("Vehicles$", SCC$EI.Sector, ignore.case=T)
    sccVehicle <- SCC[selectVehicle,]
    
    # Subset those rows in NEIbaltimore & NEIlosangeles that relate to vehicles
    
    neiVehicleBM <- subset(NEIbaltimore, SCC %in% sccVehicle$SCC)
    neiVehicleLA <- subset(NEIlosangeles, SCC %in% sccVehicle$SCC)
    
    # Group by Year, Summarize with "sum" function
    
    library(dplyr)
    neiVehicleBM <- group_by(neiVehicleBM, year)
    neiVehicleBMSummary <- summarize(neiVehicleBM, pm25 = sum(Emissions, na.rm = TRUE), City = "Baltimore")
    neiVehicleLA <- group_by(neiVehicleLA, year)
    neiVehicleLASummary <- summarize(neiVehicleLA, pm25 = sum(Emissions, na.rm = TRUE), City = "Los Angeles")
    
    # Combine the Summary Data Frames
    neiVehicleSummary <- rbind(neiVehicleBMSummary,neiVehicleLASummary)
    # Draw the plot
    
    library(ggplot2)
    
    # Display the Total Emissions by all types, but if needed one can learn how much by each type
    # So get the bars to overlap this time with different "type"
    g <- ggplot(data = neiVehicleSummary, aes(x=year, y=pm25, fill=City)) + 
        geom_bar(stat="identity", position="dodge") + 
        ggtitle("Comparison of Total Emissions from Motor Vehicles in Baltimore & LA 1999-2008") + 
        xlab("Year") + 
        ylab("Emissions (tons)") + 
        xlim(1997,2010)
    
    ggsave(g, file = "plot6.png",  scale = 0.5)
}