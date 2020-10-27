##############################################################################/
##############################################################################/
#DAPC analyses
##############################################################################/
##############################################################################/

#loading the data, packages and functions
source("bemG_load_data.R")


##############################################################################/
#preparing the dataset for DAPC analyses####
##############################################################################/

bemipop2<-bemipop[order(bemipop$species,decreasing=TRUE),]
bemAde<-df2genind(bemipop2[,c(12:22)],ploidy=2,ncode=3,NA.char="0",
                  ind.names=bemipop2$whitefly_ID,
                  loc.names=colnames(bemipop2)[12:22],
                  pop=bemipop2$pop_geo_env,
                  strata=bemipop2[,c(3,4,8,9)])
bemAde@other$latlong<-bemipop2[,c(6,7)]
bemAde@other$species<-bemipop2[,c(2)]
bemAde@other$kdr<-bemipop2[,c(23)]
hier(bemAde)<- ~pop_geo/environment


##############################################################################/
#DAPC analyses####
##############################################################################/

#determination of the number of clusters
clustbemAde<-find.clusters(bemAde,max.n.clust=35)
#with 40 PCs, we lost nearly no information
clustbemAde<-find.clusters(bemAde,n.pca=40,max.n.clust=35) #chose 4 clusters
#which individuals in which clusters per population
table(pop(bemAde),clustbemAde$grp)
#DAPC by itself, first we try to optimized the number of principal component 
#(PCs) to retain to perform the analysis
dapcbemAde<-dapc(bemAde,clustbemAde$grp,n.da=5,n.pca=100)
temp<-optim.a.score(dapcbemAde)
dapcbemAde<-dapc(bemAde,clustbemAde$grp,n.da=5,n.pca=30)
temp<-optim.a.score(dapcbemAde) #based on this result, we finaly chose 7 PCs
dapcbemAde<-dapc(bemAde,clustbemAde$grp,n.da=7,n.pca=7)


##############################################################################/
#DAPC figures####
##############################################################################/

colove<-brewer.pal(8,"Dark2")[c(1,2,3,4)]
colove2<-brewer.pal(8,"Set1")[c(1,2,3,4)]
colove3<-brewer.pal(8,"Set2")[c(1,2,3)]
colove4<-c(rgb(col2rgb(colove2)[1,1],col2rgb(colove2)[2,1],
               col2rgb(colove2)[3,1],alpha=0.1,max=255),
           rgb(col2rgb(colove2)[1,2],col2rgb(colove2)[2,2],
               col2rgb(colove2)[3,2],alpha=0.1,max=255),
           rgb(col2rgb(colove2)[1,3],col2rgb(colove2)[2,3],
               col2rgb(colove2)[3,3],alpha=0.1,max=255),
           rgb(col2rgb(colove2)[1,4],col2rgb(colove2)[2,4],
               col2rgb(colove2)[3,4],alpha=0.1,max=255))
colove5<-c("#d7191c","#2b83ba","#abdda4","#c2a5cf")

#STRUCTURE-like graphic
compoplot(dapcbemAde,lab=NA)

op<-par(mfrow=c(2,2))
#the scatter plot
scatter(dapcbemAde,xax=1,yax=2,posi.da="topright",col=colove,
        scree.pca=FALSE,scree.da=FALSE,cex=2.5,cstar=1,solid=0.6,
        cellipse=1.5,axesell=TRUE,pch=20)
#a scatter plot but instead of using dapc group for grp, we use the species
scatter(dapcbemAde,xax=1,yax=2,posi.da="topright",col=colove2,
        scree.pca=FALSE,scree.da=FALSE,cex=2.5,cstar=1,solid=0.6,
        cellipse=1.5,axesell=TRUE,pch=20,
        grp=bemAde@other$species)
#same thing but instead of dapc group, we use the kdr genotype
scatter(dapcbemAde,xax=1,yax=2,posi.da="topright",col=colove3,
        scree.pca=FALSE,scree.da=FALSE,cex=2.5,cstar=1,solid=0.6,
        cellipse=1.5,axesell=TRUE,pch=20,
        grp=bemAde@other$kdr)
par(op)

#export to .pdf 10 x 10 inches


#the graph use for the article
colove5<-c("#d7191c","#2b83ba","#abdda4","#c2a5cf")
clustbemAde<-find.clusters(bemAde,n.pca=40,max.n.clust=35) #pick 7 clusters
dapcbemAde<-dapc(bemAde,clustbemAde$grp,n.da=5,n.pca=20)
#a scatter plot but instead of using dapc group for grp, we use the species
scatter(dapcbemAde,xax=1,yax=2,posi.da="bottomright",col=colove5,
        scree.pca=TRUE,scree.da=TRUE,cex=1.5,cstar=0,solid=1,
        cellipse=1.5,axesell=TRUE,pch=c(15,1,2,18),
        grp=bemAde@other$species,
        label=c("Hybride","IO","MEAM1","MED"))

#export to .pdf 7 x 7 inches


#same thing but instead of dapc group, we use sampling environment
scatter(dapcbemAde,xax=1,yax=2,grp=bemAde@strata$environment,
        posi.da="topright")
#same thing but instead of dapc group, we use host plant
scatter(dapcbemAde,xax=1,yax=2,grp=bemAde@strata$host_plant,
        posi.da="topright")
#same thing but instead of dapc group, we use the kdr genotype
scatter(dapcbemAde,xax=1,yax=2,grp=bemAde@other$kdr,
        posi.da="topright")


##############################################################################/
#END
##############################################################################/