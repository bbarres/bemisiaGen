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


##############################################################################/
#Bemisia Q: plot a list of 100 STRUCTURE output files for each K####
##############################################################################/

#Usually, you run STRUCTURE several times for the same K values. After that, 
#you can reorganize the output file such as the labels of the different group 
#in the different run match (using CLUMPP for example). Here we import the 
#output file of CLUMPAK (http://clumpak.tau.ac.il/index.html) and then we plot 
#all the repetitions in the same graph  
#We first need to edit a little the output file in excel prior to the 
#importation: we turn spaces into tab, to separate the columns (easily done 
#in excel for example)

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

#for K=3, import the 100 run datafile (100 q matrix)
K3_100runs<-read.table("data/Q_bemigen_K3.indfile",header=FALSE,
                       blank.lines.skip=TRUE,sep="\t")
#import the column order for the best CLUMPP "permutation"
K3_colorder<-read.table("data/Q_bemigen_K3.colorder",header=FALSE,
                        blank.lines.skip=TRUE,sep="\t")
#then we split the dataframe in as many repetition that has been made
#by the number of individuals (here 54)
K3_100runs<-split(K3_100runs[,-c(1:5)],rep(1:100,each=54))
#reordering the columns so that the different repetition colorization fit
for (i in 1:100){
  K3_100runs[[i]]<-K3_100runs[[i]][as.numeric(K3_colorder[i,])]
}
#importing the order of the run so that the different repetition 
#corresponding to the same clustering solution followed each other
K3_reporder<-read.table("data/Q_bemigen_K3.runorder",header=FALSE,
                        blank.lines.skip=TRUE,sep="\t")+1

#for K=4, import the 100 run datafile (100 q matrix)
K4_100runs<-read.table("data/Q_bemigen_K4.indfile",header=FALSE,
                       blank.lines.skip=TRUE,sep="\t")
#import the column order for the best CLUMPP "permutation"
K4_colorder<-read.table("data/Q_bemigen_K4.colorder",header=FALSE,
                        blank.lines.skip=TRUE,sep="\t")
#then we split the dataframe in as many repetition that has been made
#by the number of individuals (here 54)
K4_100runs<-split(K4_100runs[,-c(1:5)],rep(1:100,each=54))
#reordering the columns so that the different repetition colorization fit
for (i in 1:100){
  K4_100runs[[i]]<-K4_100runs[[i]][as.numeric(K4_colorder[i,])]
}
#importing the order of the run so that the different repetition 
#corresponding to the same clustering solution followed each other
K4_reporder<-read.table("data/Q_bemigen_K4.runorder",header=FALSE,
                        blank.lines.skip=TRUE,sep="\t")+1


##############################################################################/
#Bemisia BMS: plot a list of 100 STRUCTURE output files for each K####
##############################################################################/

#Usually, you run STRUCTURE several times for the same K values. After that, 
#you can reorganize the output file such as the labels of the different group 
#in the different run match (using CLUMPP for example). Here we import the 
#output file of CLUMPAK (http://clumpak.tau.ac.il/index.html) and then we plot 
#all the repetitions in the same graph  
#We first need to edit a little the output file in excel prior to the 
#importation: we turn spaces into tab, to separate the columns (easily done 
#in excel for example)

#for K=2, import the 100 run datafile (100 q matrix)
K2_50runs<-read.table("data/BMS_bemigen_K2.indfile",header=FALSE,
                       blank.lines.skip=TRUE,sep="\t")
#import the column order for the best CLUMPP "permutation"
K2_colorder<-read.table("data/BMS_bemigen_K2.colorder",header=FALSE,
                        blank.lines.skip=TRUE,sep="\t")
#then we split the dataframe in as many repetition that has been made
#by the number of individuals (here 54)
K2_50runs<-split(K2_50runs[,-c(1:5)],rep(1:50,each=1200))
#reordering the columns so that the different repetition colorization fit
for (i in 1:50){
  K2_50runs[[i]]<-K2_50runs[[i]][as.numeric(K2_colorder[i,])]
}
#importing the order of the run so that the different repetition 
#corresponding to the same clustering solution followed each other
K2_reporder<-read.table("data/BMS_bemigen_K2.runorder",header=FALSE,
                        blank.lines.skip=TRUE,sep="\t")+1

#for K=3, import the 100 run datafile (100 q matrix)
K3_50runs<-read.table("data/BMS_bemigen_K3.indfile",header=FALSE,
                       blank.lines.skip=TRUE,sep="\t")
#import the column order for the best CLUMPP "permutation"
K3_colorder<-read.table("data/BMS_bemigen_K3.colorder",header=FALSE,
                        blank.lines.skip=TRUE,sep="\t")
#then we split the dataframe in as many repetition that has been made
#by the number of individuals (here 54)
K3_50runs<-split(K3_50runs[,-c(1:5)],rep(1:50,each=1200))
#reordering the columns so that the different repetition colorization fit
for (i in 1:50){
  K3_50runs[[i]]<-K3_50runs[[i]][as.numeric(K3_colorder[i,])]
}
#importing the order of the run so that the different repetition 
#corresponding to the same clustering solution followed each other
K3_reporder<-read.table("data/BMS_bemigen_K3.runorder",header=FALSE,
                        blank.lines.skip=TRUE,sep="\t")+1

#for K=4, import the 100 run datafile (100 q matrix)
K4_50runs<-read.table("data/BMS_bemigen_K4.indfile",header=FALSE,
                       blank.lines.skip=TRUE,sep="\t")
#import the column order for the best CLUMPP "permutation"
K4_colorder<-read.table("data/BMS_bemigen_K4.colorder",header=FALSE,
                        blank.lines.skip=TRUE,sep="\t")
#then we split the dataframe in as many repetition that has been made
#by the number of individuals (here 54)
K4_50runs<-split(K4_50runs[,-c(1:5)],rep(1:50,each=1200))
#reordering the columns so that the different repetition colorization fit
for (i in 1:50){
  K4_50runs[[i]]<-K4_50runs[[i]][as.numeric(K4_colorder[i,])]
}
#importing the order of the run so that the different repetition 
#corresponding to the same clustering solution followed each other
K4_reporder<-read.table("data/BMS_bemigen_K4.runorder",header=FALSE,
                        blank.lines.skip=TRUE,sep="\t")+1


##############################################################################/
#END
##############################################################################/