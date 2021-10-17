##############################################################################/
##############################################################################/
#Loading packages, data and functions
##############################################################################/
##############################################################################/

#loading the  necessary libraries
library(adegenet)
library(classInt)
library(data.table)
library(diveRsity)
library(elevatr)
library(gdata)
library(hierfstat)
library(igraph)
library(maptools)
library(plotrix)
library(PopGenReport)
library(poppr)
library(RColorBrewer)
library(rgdal)
library(rgeos)
library(sf)
library(spatstat)
library(spatgraphs)
library(tanaka)
library(tidyr)
library(vegan)

#loading the functions
source("bemG_strplot_fun.R")


##############################################################################/
#Loading "classical" data tables####
##############################################################################/

#microsatellite markers data table
bemipop<-read.table("data/bem_genepop.txt",header=TRUE,sep="\t",
                    stringsAsFactors=TRUE)

#diversity indices data table
bemidiv<-read.table("data/bem_diversiSpec.txt",header=TRUE,sep="\t",
                    stringsAsFactors=TRUE)

#pairwise Fst between populations
bemPairFst<-read.table("data/bem_pairWiseFST.txt",header=TRUE,sep="\t",
                       stringsAsFactors=TRUE)

#kdr mutation distribution by species
kdrDistr<-read.table("data/barplotkdr.txt",
                     header=TRUE,sep="\t",dec=",",
                     stringsAsFactors=TRUE)


##############################################################################/
#Bemisia Q: plot a list of 100 STRUCTURE output files for each K####
##############################################################################/

#Usually, you run STRUCTURE several times for the same K values. After that, 
#you can reorganize the output file such as the labels of the different group 
#in the different run match (using CLUMPP for example). Here we import the 
#output file of CLUMPAK (http://clumpak.tau.ac.il/index.html) and then we plot 
#all the repetitions in the same graph. 
#The clumpack output files need some minor edition in prior to the 
#importation: we turn the separator from space into tab

#for K=2, import the 50 run datafile (50 q matrix)
Q_K2_50runs<-read.table("data/50runs/Q_bemigen_K2.indfile",header=FALSE,
                        blank.lines.skip=TRUE,sep="\t",
                        stringsAsFactors=TRUE)
#import the column order for the best CLUMPP "permutation"
Q_K2_colorder<-read.table("data/50runs/Q_bemigen_K2.colorder",header=FALSE,
                          blank.lines.skip=TRUE,sep="\t",
                          stringsAsFactors=TRUE)
#then we split the dataframe in as many repetition that has been made
#by the number of individuals (here 54)
Q_K2_50runs<-split(Q_K2_50runs[,-c(1:5)],rep(1:50,each=54))
#reordering the columns so that the different repetition colorization fit
for (i in 1:50){
  Q_K2_50runs[[i]]<-Q_K2_50runs[[i]][as.numeric(Q_K2_colorder[i,])]
}
#importing the order of the run so that the different repetition 
#corresponding to the same clustering solution followed each other
K2_reporderQ<-read.table("data/50runs/Q_bemigen_K2.runorder",header=FALSE,
                         blank.lines.skip=TRUE,sep="\t",
                         stringsAsFactors=TRUE)+1

#for K=3, import the 50 run datafile (50 q matrix)
Q_K3_50runs<-read.table("data/50runs/Q_bemigen_K3.indfile",header=FALSE,
                        blank.lines.skip=TRUE,sep="\t",
                        stringsAsFactors=TRUE)
#import the column order for the best CLUMPP "permutation"
Q_K3_colorder<-read.table("data/50runs/Q_bemigen_K3.colorder",header=FALSE,
                          blank.lines.skip=TRUE,sep="\t",
                          stringsAsFactors=TRUE)
#then we split the dataframe in as many repetition that has been made
#by the number of individuals (here 54)
Q_K3_50runs<-split(Q_K3_50runs[,-c(1:5)],rep(1:50,each=54))
#reordering the columns so that the different repetition colorization fit
for (i in 1:50){
  Q_K3_50runs[[i]]<-Q_K3_50runs[[i]][as.numeric(Q_K3_colorder[i,])]
}
#importing the order of the run so that the different repetition 
#corresponding to the same clustering solution followed each other
K3_reporderQ<-read.table("data/50runs/Q_bemigen_K3.runorder",header=FALSE,
                         blank.lines.skip=TRUE,sep="\t",
                         stringsAsFactors=TRUE)+1

#for K=4, import the 50 run datafile (50 q matrix)
Q_K4_50runs<-read.table("data/50runs/Q_bemigen_K4.indfile",header=FALSE,
                        blank.lines.skip=TRUE,sep="\t",
                        stringsAsFactors=TRUE)
#import the column order for the best CLUMPP "permutation"
Q_K4_colorder<-read.table("data/50runs/Q_bemigen_K4.colorder",header=FALSE,
                          blank.lines.skip=TRUE,sep="\t",
                          stringsAsFactors=TRUE)
#then we split the dataframe in as many repetition that has been made
#by the number of individuals (here 54)
Q_K4_50runs<-split(Q_K4_50runs[,-c(1:5)],rep(1:50,each=54))
#reordering the columns so that the different repetition colorization fit
for (i in 1:50){
  Q_K4_50runs[[i]]<-Q_K4_50runs[[i]][as.numeric(Q_K4_colorder[i,])]
}
#importing the order of the run so that the different repetition 
#corresponding to the same clustering solution followed each other
K4_reporderQ<-read.table("data/50runs/Q_bemigen_K4.runorder",header=FALSE,
                         blank.lines.skip=TRUE,sep="\t",
                         stringsAsFactors=TRUE)+1


##############################################################################/
#Bemisia BMS: plot a list of 50 STRUCTURE output files for each K####
##############################################################################/

#Usually, you run STRUCTURE several times for the same K values. After that, 
#you can reorganize the output file such as the labels of the different group 
#in the different run match (using CLUMPP for example). Here we import the 
#output file of CLUMPAK (http://clumpak.tau.ac.il/index.html) and then we plot 
#all the repetitions in the same graph  
#We first need to edit a little the output file in excel prior to the 
#importation: we turn spaces into tab, to separate the columns (easily done 
#in excel for example)

#for K=2, import the 50 run datafile (50 q matrix)
BMS_K2_50runs<-read.table("data/50runs/BMS_bemigen_K2.indfile",header=FALSE,
                          blank.lines.skip=TRUE,sep="\t",
                          stringsAsFactors=TRUE)
#import the column order for the best CLUMPP "permutation"
BMS_K2_colorder<-read.table("data/50runs/BMS_bemigen_K2.colorder",header=FALSE,
                            blank.lines.skip=TRUE,sep="\t",
                            stringsAsFactors=TRUE)
#then we split the dataframe in as many repetition that has been made
#by the number of individuals (here 54)
BMS_K2_50runs<-split(BMS_K2_50runs[,-c(1:5)],rep(1:50,each=1509))
#reordering the columns so that the different repetition colorization fit
for (i in 1:50){
  BMS_K2_50runs[[i]]<-BMS_K2_50runs[[i]][as.numeric(BMS_K2_colorder[i,])]
}
#importing the order of the run so that the different repetition 
#corresponding to the same clustering solution followed each other
K2_reporderBMS<-read.table("data/50runs/BMS_bemigen_K2.runorder",header=FALSE,
                           blank.lines.skip=TRUE,sep="\t",
                           stringsAsFactors=TRUE)+1

#for K=3, import the 50 run datafile (50 q matrix)
BMS_K3_50runs<-read.table("data/50runs/BMS_bemigen_K3.indfile",header=FALSE,
                          blank.lines.skip=TRUE,sep="\t",
                          stringsAsFactors=TRUE)
#import the column order for the best CLUMPP "permutation"
BMS_K3_colorder<-read.table("data/50runs/BMS_bemigen_K3.colorder",header=FALSE,
                            blank.lines.skip=TRUE,sep="\t",
                            stringsAsFactors=TRUE)
#then we split the dataframe in as many repetition that has been made
#by the number of individuals (here 54)
BMS_K3_50runs<-split(BMS_K3_50runs[,-c(1:5)],rep(1:50,each=1509))
#reordering the columns so that the different repetition colorization fit
for (i in 1:50){
  BMS_K3_50runs[[i]]<-BMS_K3_50runs[[i]][as.numeric(BMS_K3_colorder[i,])]
}
#importing the order of the run so that the different repetition 
#corresponding to the same clustering solution followed each other
K3_reporderBMS<-read.table("data/50runs/BMS_bemigen_K3.runorder",header=FALSE,
                           blank.lines.skip=TRUE,sep="\t",
                           stringsAsFactors=TRUE)+1


##############################################################################/
#Writing info session for reproducibility####
##############################################################################/

sink("session_info.txt")
print(sessioninfo::session_info())
sink()
#inspired by an R gist of François Briatte: 
#https://gist.github.com/briatte/14e47fb0cfb8801f25c889edea3fcd9b


##############################################################################/
#END
##############################################################################/