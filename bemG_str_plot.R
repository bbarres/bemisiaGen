##############################################################################/
##############################################################################/
#Plotting the structure graph
##############################################################################/
##############################################################################/

#loading the data, packages and functions
source("bemG_load_data.R")


##############################################################################/
#Bemisia Q: plot a list of 50 STRUCTURE output files for each K####
##############################################################################/

coloor<-c("chartreuse4","firebrick","khaki2","darkorange","royalblue4")
effpop<-c(2,4,1,17,1,9,20)
poptiquet<-c("8","32","33","34","47","56","320")
#now we can plot the 50 runs on the same figure
#for K=2
op<-par(mfrow=c(50,1),mar=c(0,0,0,0),oma=c(1,0,3,0))
for (i in 1:50){
  j<-as.numeric(K2_reporderQ[i])
  temp<-Q_K2_50runs[[j]]
  structplot(t(temp),coloor,effpop,poptiquet,spacepop=1,
             leg_y="K=2",cexy=1.2,mef=c(0,0,0,0,0),colbord=NA,
             distxax=0.15,angl=0,cexpop=1.5)
}
title(main="K=2",cex.main=2.5,outer=TRUE)
par(op)
#export pdf 3 x 12

#for K=3
op<-par(mfrow=c(50,1),mar=c(0,0,0,0),oma=c(1,0,3,0))
for (i in 1:50){
  j<-as.numeric(K3_reporderQ[i])
  temp<-Q_K3_50runs[[j]]
  structplot(t(temp),coloor,effpop,poptiquet,spacepop=1,
             leg_y="K=3",cexy=1.2,mef=c(0,0,0,0,0),colbord=NA,
             distxax=0.15,angl=0,cexpop=1.5)
}
title(main="K=3",cex.main=2.5,outer=TRUE)
par(op)
#export pdf 3 x 12

#for K=4
op<-par(mfrow=c(50,1),mar=c(0,0,0,0),oma=c(1,0,3,0))
for (i in 1:50){
  j<-as.numeric(K4_reporderQ[i])
  temp<-Q_K4_50runs[[j]]
  structplot(t(temp),coloor,effpop,poptiquet,spacepop=1,
             leg_y="K=4",cexy=1.2,mef=c(0,0,0,0,0),colbord=NA,
             distxax=0.15,angl=0,cexpop=1.5)
}
title(main="K=4",cex.main=2.5,outer=TRUE)
par(op)
#export pdf 3 x 12


##############################################################################/
#Bemisia BMS: plot a list of 50 STRUCTURE output files for each K####
##############################################################################/

coloor<-c("chartreuse4","firebrick","khaki2","darkorange","royalblue4")
effpop<-c(31,10,28,24,26,21,22,19,23,30,30,32,30,30,26,32,31,23,28,26,31,
          59,27,31,27,32,27,28,15,31,29,4,26,35,23,16,12,12,14,24,20,26,
          32,31,12,32,31,29,32,12,32,2,32,32,32,32,12,5,17,2,29)
poptiquet<-c("1","2","4","5","6","7","8","9","10","11","12","13","14","16",
             "17","18","19","20","21","22","23","25","27","28","29","31",
             "32","33","34","36","41","42","44","45","46","47","48","49",
             "50","51","52","53","54","55","56","57","58","59","60","61",
             "62","63","64","65","66","180","320","351","352","401","402")
#now we can plot the 50 runs on the same figure

#for K=2
op<-par(mfrow=c(50,1),mar=c(0,0,0,0),oma=c(1,0,3,0))
for (i in 1:50){
  j<-as.numeric(K2_reporderBMS[i])
  temp<-BMS_K2_50runs[[j]]
  structplot(t(temp),coloor,effpop,poptiquet,spacepop=1,
             leg_y="K=2",cexy=1.2,mef=c(0,0,0,0,0),colbord=NA,
             distxax=0.15,angl=0,cexpop=1.5)
}
title(main="K=2",cex.main=2.5,outer=TRUE)
par(op)
#export pdf 84 x 12

#for K=3
op<-par(mfrow=c(50,1),mar=c(0,0,0,0),oma=c(1,0,3,0))
for (i in 1:50){
  j<-as.numeric(K3_reporderBMS[i])
  temp<-BMS_K3_50runs[[j]]
  structplot(t(temp),coloor,effpop,poptiquet,spacepop=1,
             leg_y="K=3",cexy=1.2,mef=c(0,0,0,0,0),colbord=NA,
             distxax=0.15,angl=0,cexpop=1.5)
}
title(main="K=3",cex.main=2.5,outer=TRUE)
par(op)
#export pdf 84 x 12


##############################################################################/
#Bemisia BMS: final plot for the combine runs####
##############################################################################/

#preparing the dataset
temp<-bemipop[bemipop$species!="MED-Q",]
temp<-as.data.table(temp)
setorder(temp,pop_geo,pop_geo_env,-species)
head(temp)

#color based on ppt
coloor<-c("#217821","#80e5ff","#ff2a2a","#8d5fd3")
#other set of colors
coloor<-brewer.pal(8,"Dark2")[1:2]
poptiquet<-names(table(temp$pop_geo))
effpop<-as.numeric(table(temp$pop_geo))

temp2<-as.data.frame(table(temp$pop_geo_env,temp$pop_geo))
temp2<-temp2[temp2$Freq!=0,]
temp2$cumu<-cumsum(temp2$Freq)
temp2$Var2b<-temp2$Var2[c(1,1:(length(temp2$Var2)-1))]
temp2$decal<-cumsum(ifelse(temp2$Var2==temp2$Var2b,0,5))
temp3<-as.data.table(table(temp$pop_geo_env,temp$environment))
temp3<-temp3[temp3$N!=0,]
temp2<-merge(temp2,temp3,by.x="Var1",by.y="V1",sort=FALSE)

#plotting pop = geographic pop, subpop = environment within pop
structplot(t(temp[,c("MeIo_clust1","MeIo_clust2")]),
           coloor,effpop,poptiquet,spacepop=5,
           mef=c(0,0,1,1,0),colbord=NA,angl=0)

rect(c(0,temp2$cumu)[1:length(temp2$cumu)]+temp2$decal,
     rep(0,length(temp2$cumu)),
     temp2$cumu+temp2$decal,
     rep(1,length(temp2$cumu)),
     lwd=2)

axis(3,at=c(0,temp2$cumu)[1:length(temp2$cumu)]+temp2$decal+
       (temp2$cumu-c(0,temp2$cumu)[1:length(temp2$cumu)])/2,
     labels=FALSE,pos=1,lwd.ticks=2,lwd=0)

text(c(0,temp2$cumu)[1:length(temp2$cumu)]+temp2$decal+
       (temp2$cumu-c(0,temp2$cumu)[1:length(temp2$cumu)])/2-6,
     rep(par("usr")[4]+0.020,length(temp2$cumu)),labels=temp2$V2,
     srt=25,xpd=NA,pos=4,cex=0.7)


##############################################################################/
#END
##############################################################################/