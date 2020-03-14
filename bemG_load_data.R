##############################################################################/
##############################################################################/
#Loading packages, data and functions
##############################################################################/
##############################################################################/

#loading the  necessary libraries
library(adegenet)
library(gdata)
library(RColorBrewer)

#loading the functions
source("bemG_strplot_fun.R")
source("Agra_deltaKplot_fun.R")


##############################################################################/
#plot a list of 100 STRUCTURE output files for each K####
##############################################################################/

#Usually, you run STRUCTURE several times for the same K values. After that, 
#you can reorganize the output file such as the labels of the different group 
#in the different run match (using CLUMPP for example). Here we import the 
#output file of CLUMPAK (http://clumpak.tau.ac.il/index.html) and then we plot 
#all the repetitions in the same graph  
#We first need to edit a little the output file in excel prior to the 
#importation: just keep the q matrix without any other information

#for K=2, import the 100 run datafile (100 q matrix)
K2_100runs<-read.table("data/Q_bemigen_K2.indfile",header=FALSE,
                       blank.lines.skip=TRUE,sep="\t")
#import the column order for the best CLUMPP "permutation"
K2_colorder<-read.table("data/Q_bemigen_K2.colorder",header=FALSE,
                        blank.lines.skip=TRUE,sep="\t")
#then we split the dataframe in as many repetition that has been made
#by the number of individuals (here 54)
K2_100runs<-split(K2_100runs[,-c(1:5)],rep(1:100,each=54))
#reordering the columns so that the different repetition colorization fit
for (i in 1:100){
  K2_100runs[[i]]<-K2_100runs[[i]][as.numeric(K2_colorder[i,])]
}
#importing the order of the run so that the different repetition 
#corresponding to the same clustering solution followed each other
K2_reporder<-read.table("data/Q_bemigen_K2.runorder",header=FALSE,
                        blank.lines.skip=TRUE,sep="\t")+1

coloor <- c("chartreuse4","firebrick","khaki2","darkorange","royalblue4")
effpop<-c(2,4,1,17,1,9,20)
poptiquet<-c("8","32","33","34","47","56","320")
#now we can plot the 100 runs on the same figure
op<-par(mfrow=c(100,1),mar=c(0,0,0,0),oma=c(1,0,3,0))
for (i in 1:100){
  j<-as.numeric(K2_reporder[i])
  temp<-K2_100runs[[j]]
  structplot(t(temp),coloor,effpop,poptiquet,spacepop=2,
             leg_y="K=2",cexy=1.2,mef=c(0,0,0,0,0),colbord=NA,
             distxax=0.15,angl=0,cexpop=1.5)
}
title(main="K=2",cex.main=2.5,outer=TRUE)
par(op)
#export pdf 25 x 12


##############################################################################/
#END
##############################################################################/