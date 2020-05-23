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

bemAde<-df2genind(bemipop[,c(12:22)],ploidy=2,ncode=3,NA.char="0",
                  ind.names=bemipop$whitefly_ID,
                  loc.names=colnames(bemipop)[12:22],
                  pop=bemipop$pop_geo_env,
                  strata=bemipop[,c(3,4,8,9)])
bemAde@other$latlong<-bemipop[,c(6,7)]
bemAde@other$species<-bemipop[,c(2)]
bemAde@other$kdr<-bemipop[,c(23)]
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

#STRUCTURE-like graphic
compoplot(dapcbemAde,lab=NA)
#the scatter plot
scatter(dapcbemAde,xax=1,yax=2,posi.da="topright")
#a scatter plot but instead of using dapc group for grp, we use the species
scatter(dapcbemAde,xax=1,yax=2,grp=bemAde@other$species,
        posi.da="topright")
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