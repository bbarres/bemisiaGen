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
load("data/shapefiles/ReuAlt.RData")
load("data/shapefiles/ReuIso.RData")


##############################################################################/
#Map plotting####
##############################################################################/

#op<-par(mfrow=c(1,2))
#example of map with isopleth
plot(ReuDep$geometry,col=brewer.pal(11,"Spectral")[6],lwd=3)
plot(ReuUrb,col=brewer.pal(9,"RdPu")[3],
     border=brewer.pal(9,"RdPu")[3],add=TRUE)
plot(ReuVeg,col=brewer.pal(9,"BuGn")[6],
     border=brewer.pal(9,"BuGn")[6],add=TRUE)
plot(ReuAgri,col=brewer.pal(8,"Accent")[1],
     border= brewer.pal(8,"Accent")[1],add=TRUE)
plot(st_geometry(ReuIso),col=grey(15:1/15,alpha=0.3),
     axes=FALSE,legend=FALSE,add=TRUE,lwd=1)
plot(ReuDep$geometry,col="transparent",lwd=4,add=TRUE)
#export to .pdf 20 x 18 inches

#another example of map with tanaka's effect
tanaka(x=ReuAlt,breaks=seq(150,3070,200),
       col=grey(15:1/15),
       legend.pos="n",
       mask=ReuDep$geometry)
plot(ReuDep$geometry,
     col=rgb(t(as.matrix(col2rgb(brewer.pal(11,"Spectral")[6]))),
             alpha=150,maxColorValue=255),
     lwd=3,add=TRUE)
plot(ReuUrb,
     col=rgb(t(as.matrix(col2rgb(brewer.pal(9,"RdPu")[3]))),
             alpha=150,maxColorValue=255),
     border=rgb(t(as.matrix(col2rgb(brewer.pal(9,"RdPu")[3]))),
                alpha=150,maxColorValue=255),
     add=TRUE)
plot(ReuVeg,
     col=rgb(t(as.matrix(col2rgb(brewer.pal(9,"BuGn")[6]))),
             alpha=150,maxColorValue=255),
     border=rgb(t(as.matrix(col2rgb(brewer.pal(9,"BuGn")[6]))),
                alpha=150,maxColorValue=255),
     add=TRUE)
plot(ReuAgri,
     col=rgb(t(as.matrix(col2rgb(brewer.pal(8,"Accent")[1]))),
             alpha=150,maxColorValue=255),
     border=rgb(t(as.matrix(col2rgb(brewer.pal(8,"Accent")[1]))),
                alpha=150,maxColorValue=255),
     add=TRUE)
plot(ReuDep$geometry,col="transparent",lwd=4,add=TRUE)
#export to .pdf 20 x 18 inches

#par(op)
#for both map side by side, export to .pdf 40 x 18 inches


##############################################################################/
#END
##############################################################################/