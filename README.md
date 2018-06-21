# Heatmap_rWorldMap
First attempt at plotting a heatmap of metal production using rWorldMap

Instructions:
1) Session -> Set Working Directory -> To Source File Location

2) Before running the first time, install the following packages:
install.packages(c("rworldmap", "readr", "RColorBrewer", "classInt"))

Put data files in ./Data

Be sure to update the text in mapParams to align with the correct data (ie. Global Copper Production)
each time you run the code.

X11 will not work on Mac devices. I have not tested on a Windows device recently.