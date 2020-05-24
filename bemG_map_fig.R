##############################################################################/
##############################################################################/
#Plotting the "La Réunion" map
##############################################################################/
##############################################################################/

#loading the data, packages and functions
source("bemG_load_data.R")
#specific dataset consisting of shapefile, only useful for plotting maps
load("data/shapefiles/ReuDep.RData")
load("data/shapefiles/ReuUrb.RData")
load("data/shapefiles/ReuVeg.RData")
load("data/shapefiles/ReuAgri.RData")


##############################################################################/
#Map plotting####
##############################################################################/

plot(ReuDep$geometry,col=brewer.pal(11,"Spectral")[6],lwd=3)
plot(ReuUrb,col=brewer.pal(9,"RdPu")[3],
     border=brewer.pal(9,"RdPu")[3],add=TRUE)
plot(ReuVeg,col=brewer.pal(9,"BuGn")[6],
     border=brewer.pal(9,"BuGn")[6],add=TRUE)
plot(ReuAgri,col=brewer.pal(8,"Accent")[1],
     border= brewer.pal(8,"Accent")[1],add=TRUE)
plot(ReuDep$geometry,col="transparent",lwd=3,add=TRUE)

#export to .pdf 20 x 18 inches



WGS84 GPS 4326











##############################################################################/
#END
##############################################################################/