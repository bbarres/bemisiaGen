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

#in order to extract the coordinates of the sampled populations we use the
#genetic dataset
bemipop<-bemipop[bemipop$species!="Hybride",]
bemipop<-drop.levels(bemipop)

bemAde<-df2genind(bemipop[,c(12:22)],ploidy=2,ncode=3,NA.char="0",
                  ind.names=bemipop$whitefly_ID,
                  loc.names=colnames(bemipop)[12:22],
                  pop=bemipop$pop_geo_env,
                  strata=bemipop[,c(3,4,8,9)])
bemAde@other$latlong<-bemipop[,c(6,7)]
bemAde@other$species<-bemipop[,c(2)]
hier(bemAde)<- ~pop_geo/environment

#MED populations
MedAde<-bemAde[bemAde@other$species=="MED-Q"]
#we remove population with less than 4 individuals
MedAde<-MedAde[MedAde$pop %in% 
               names(summary(MedAde)$n.by.pop)[summary(MedAde)$n.by.pop>4]]
#turning the ind file into a pop file
popMedAde<-genind2genpop(MedAde,process.other=TRUE)

#MEAM populations
MeaMAde<-bemAde[bemAde@other$species=="MEAM1"]
#we remove population with less than 4 individuals
MeaMAde<-MeaMAde[MeaMAde$pop %in% 
                 names(summary(MeaMAde)$n.by.pop)[summary(MeaMAde)$n.by.pop>4]]
#turning the ind file into a pop file
popMeaMAde<-genind2genpop(MeaMAde,process.other=TRUE)

#IO populations
IoAde<-bemAde[bemAde@other$species=="IO"]
#we remove population with less than 4 individuals
IoAde<-IoAde[IoAde$pop %in% 
             names(summary(IoAde)$n.by.pop)[summary(IoAde)$n.by.pop>4]]
#turning the ind file into a pop file
popIoAde<-genind2genpop(IoAde,process.other=TRUE)



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
#IO distance matrices for Isolation by distance testing####
##############################################################################/

#creating the IO spatial object
popIo<-st_as_sf(x=popIoAde@other$latlong,
                row.names=row.names(popIoAde@other$latlong),
                coords=c("longitude","latitude"),
                crs=4326)
popIo<-st_transform(popIo,2975)
#adding a small amount of jitter so there are no overlapping point
popIo<-st_jitter(popIo,amount=1)
#same data but under the 'ppp' format
PPPpopIo<-as(as(popIo,"Spatial"),"ppp")

#matrix of the projected coordinates
coorMat<-st_coordinates(popIo)
row.names(coorMat)<-row.names(popIoAde@other$latlong)
#euclidean distances matrix, in kms
IOmat<-vegdist(coorMat,method="euclidean")/1000
#computing the minimum spanning tree
treeIo<-spantree(IOmat)
#distance through the minimum spanning tree
cophIOmat<-cophenetic(treeIo)
#correlation between euclidean and cophenetic distances
plot(cophIOmat~IOmat)
#export the data matrices
IOmat<-as.matrix(IOmat)
IOmat[upper.tri(IOmat,diag=TRUE)]<-""
write.table(IOmat,file="output/IOmat.txt",sep="\t",quote=FALSE)
cophIOmat<-as.matrix(cophIOmat)
cophIOmat[upper.tri(cophIOmat,diag=TRUE)]<-""
write.table(cophIOmat,file="output/cophIOmat.txt",sep="\t",quote=FALSE)

#map with an additionnal layer for the minimum spanning network
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
lines(treeIo,st_coordinates(popIo),lwd=3,col=grey(0.4))
plot(popIo,col="red",pch=19,add=TRUE)


##############################################################################/
#MEAM distance matrices for Isolation by distance testing####
##############################################################################/

#creating the MEAM spatial object
popMeam<-st_as_sf(x=popMeaMAde@other$latlong,
                row.names=row.names(popMeaMAde@other$latlong),
                coords=c("longitude","latitude"),
                crs=4326)
popMeam<-st_transform(popMeam,2975)
#adding a small amount of jitter so there are no overlapping point
popMeam<-st_jitter(popMeam,amount=1)
#same data but under the 'ppp' format
PPPpopMeam<-as(as(popMeam,"Spatial"),"ppp")

#matrix of the projected coordinates
coorMat<-st_coordinates(popMeam)
row.names(coorMat)<-row.names(popMeaMAde@other$latlong)
#euclidean distances matrix, in kms
MEAMmat<-vegdist(coorMat,method="euclidean")/1000
#computing the minimum spanning tree
treeMeam<-spantree(MEAMmat)
#distance through the minimum spanning tree
cophMEAMmat<-cophenetic(treeMeam)
#correlation between euclidean and cophenetic distances
plot(cophMEAMmat~MEAMmat)
#export the data matrices
MEAMmat<-as.matrix(MEAMmat)
MEAMmat[upper.tri(MEAMmat,diag=TRUE)]<-""
#exporting the distance matrix
write.table(MEAMmat,file="output/MEAMmat.txt",sep="\t",quote=FALSE)
cophMEAMmat<-as.matrix(cophMEAMmat)
cophMEAMmat[upper.tri(cophMEAMmat,diag=TRUE)]<-""
#exporting the cophenetic distance matrix
write.table(cophMEAMmat,file="output/cophMEAMmat.txt",sep="\t",quote=FALSE)


#######additional codes for other type of networks
temp2<-delaunay(PPPpopMeam)
plot(temp2,col="red",lwd=1,lty=2,add=TRUE)

temp2<-spatgraph(PPPpopMeam,"gabriel")
plot(temp2,as.data.frame(PPPpopMeam),add=TRUE)
temp2<-spatgraph(PPPpopMeam,"RNG")
plot(temp2,as.data.frame(PPPpopMeam),col="red",lwd=3,add=TRUE)
temp2<-spatgraph(PPPpopMeam,"knn",par=5)
plot(temp2,as.data.frame(PPPpopMeam),col="red",lwd=3,add=TRUE)
temp2<-spatgraph(PPPpopMeam,"geometric",par=200)
plot(temp2,as.data.frame(PPPpopMeam),col="red",lwd=3,add=TRUE)

#shortest path in a network (from package igraph)
shortest_paths(temp2)



#map with an additional layer for the minimum spanning network
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
lines(treeMeam,st_coordinates(popMeam),lwd=5,
      col=brewer.pal(9,"Purples")[8])
plot(popMeam,col="darkblue",pch=19,cex=6,add=TRUE)
#export to .pdf 20 x 18 inches


##############################################################################/
#END
##############################################################################/