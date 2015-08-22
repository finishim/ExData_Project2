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
}