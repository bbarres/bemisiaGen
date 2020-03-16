##############################################################################/
##############################################################################/
#Plotting the structure graph
##############################################################################/
##############################################################################/



##############################################################################/
#Bemisia Q: plot a list of 100 STRUCTURE output files for each K####
##############################################################################/

coloor <- c("chartreuse4","firebrick","khaki2","darkorange","royalblue4")
effpop<-c(2,4,1,17,1,9,20)
poptiquet<-c("8","32","33","34","47","56","320")
#now we can plot the 100 runs on the same figure
#for K=2
op<-par(mfrow=c(100,1),mar=c(0,0,0,0),oma=c(1,0,3,0))
for (i in 1:100){
  j<-as.numeric(K2_reporder[i])
  temp<-K2_100runs[[j]]
  structplot(t(temp),coloor,effpop,poptiquet,spacepop=1,
             leg_y="K=2",cexy=1.2,mef=c(0,0,0,0,0),colbord=NA,
             distxax=0.15,angl=0,cexpop=1.5)
}
title(main="K=2",cex.main=2.5,outer=TRUE)
par(op)
#export pdf 25 x 12

#for K=3
op<-par(mfrow=c(100,1),mar=c(0,0,0,0),oma=c(1,0,3,0))
for (i in 1:100){
  j<-as.numeric(K3_reporder[i])
  temp<-K3_100runs[[j]]
  structplot(t(temp),coloor,effpop,poptiquet,spacepop=1,
             leg_y="K=3",cexy=1.2,mef=c(0,0,0,0,0),colbord=NA,
             distxax=0.15,angl=0,cexpop=1.5)
}
title(main="K=3",cex.main=2.5,outer=TRUE)
par(op)
#export pdf 25 x 12

#for K=4
op<-par(mfrow=c(100,1),mar=c(0,0,0,0),oma=c(1,0,3,0))
for (i in 1:100){
  j<-as.numeric(K4_reporder[i])
  temp<-K4_100runs[[j]]
  structplot(t(temp),coloor,effpop,poptiquet,spacepop=1,
             leg_y="K=4",cexy=1.2,mef=c(0,0,0,0,0),colbord=NA,
             distxax=0.15,angl=0,cexpop=1.5)
}
title(main="K=4",cex.main=2.5,outer=TRUE)
par(op)
#export pdf 25 x 12


##############################################################################/
#Bemisia BMS: plot a list of 100 STRUCTURE output files for each K####
##############################################################################/



##############################################################################/
#END
##############################################################################/