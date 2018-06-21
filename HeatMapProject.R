# First HeatMap exploration
# By: Tristan Kaiser
# 09/01/2016

library(readr)
library(rworldmap)
library(RColorBrewer)
library(classInt)

# Load data ---------------------------
df <- read.csv('./Data/Metal_Data.csv', header = TRUE, na.strings=c("", NA))


# Clean data -------------------------
# Convert Percentage column to numeric
# You will run into a lot of issues here if the CSV file has a funky format
df$Percentage <- as.numeric(sub("%", "", df$Percentage))


# Build map -------------------------
# Join data to map
dfMap <- joinCountryData2Map(df
                             ,joinCode = "ISO3"
                             ,nameJoinColumn = "CountryCode"
                             ,verbose = TRUE)

# Set Colours
colourChoice <- palette(c("white", "#fee5d9", "#fcbba1", "#fc9272", "#fb6a4a", "#ef3b2c", "#cb181d", "#990000"))

# Create categories for data
# Breaks indicate the colour categories
dfMap@data[["percentage.category"]] <- cut(dfMap@data[["Percentage"]],
                 breaks = c(-1, 0, 2, 5, 10, 20, 40, 60, 100),
                 include.lowest = TRUE, na.rm = TRUE)

# Label the colour categories
levels(dfMap@data[["percentage.category"]]) <- c("0%", "<2%",
                                    "=>2% - <5%",
                                    ">=5% - <10%",
                                    ">=10% - <20%",
                                    ">=20% - <40%",
                                    ">=40% - <60%",
                                    ">=60% - 100%")

# Open the Map Viewer
# Only works in Windows
mapDevice("x11")

# Plot the data categories
mapParams <- mapCountryData(dfMap,
                            nameColumnToPlot = 'percentage.category',
                            catMethod = 'categorical',
                            mapTitle = 'Global Copper Production 2013 - 18,500,000 tonnes',
                            addLegend = FALSE,
                            colourPalette = colourChoice,
                            oceanCol = 'lightBlue',
                            missingCountryCol = 'white')

# Add the Legend -------------------------------
# Current settings worked on X11 viewer
# Adjust cex until the box fits properly
mapParams$legendText <- levels(dfMap@data[["percentage.category"]])
do.call(addMapLegendBoxes, c(mapParams,x = 'bottomleft',
                             cex = .6,
                             title = "% of World Production",
                             horiz = FALSE))

# Modify these values until the source & box align correctly
text(111,-85, "Source: USGS & Kaiser Research", cex = .8)
rect(67,-80, 155, -90)