##############################################################################/
##############################################################################/
#Diversity indices plot
##############################################################################/
##############################################################################/

#loading the data, packages and functions
source("bemG_load_data.R")


##############################################################################/
#boxplot of some of the diversity indices by species####
##############################################################################/

#we pick a set of colors
coli3<-brewer.pal(3,"Dark2")
colove2<-brewer.pal(8,"Set1")[c(1,2,3,4)]

op<-par(mfrow=c(2,2))
boxplot(Na~species,data=bemidiv,col=coli3,las=1,
        ann=FALSE)
title(main="Number of alleles")
boxplot(Ar~species,data=bemidiv,col=coli3,las=1,
        ann=FALSE)
title(main="Allelic Richness")
boxplot(Ho~species,data=bemidiv,col=coli3,las=1,
        ann=FALSE)
title(main="Observed Heterozygosity")
plot(bemidiv$FIS[order(bemidiv$species)],las=1,ann=FALSE,cex=2,
     bg=coli3[sort(bemidiv$species)],
     pch=c(24,24,24,21)[as.numeric(bemidiv$HW[order(bemidiv$species)])])
title(main="Fis")
abline(h=0,lty=2,lwd=3,col=grey(0.5))
par(op)

#export to .pdf 8 x 9 inches

#plot for Alizée defense
boxplot(Ar~species,data=bemidiv,col=colove2[c(2,3,4)],las=1,
        ann=FALSE)
title(main="Richesse allélique")
#export to .pdf 4 x 5 inches
boxplot(pairwiseFST~species,data=bemPairFst,col="transparent",
        las=1,ann=FALSE,border="transparent",outline=FALSE)
violin_plot(bemPairFst[bemPairFst$species=="MED-Q",]$pairwiseFST,
            at=3,add=TRUE,col=colove2[4],violin_width=0.8)
violin_plot(bemPairFst[bemPairFst$species=="MEAM1",]$pairwiseFST,
            at=2,add=TRUE,col=colove2[3],violin_width=0.8)
violin_plot(bemPairFst[bemPairFst$species=="IO",]$pairwiseFST,
            at=1,add=TRUE,col=colove2[2],violin_width=0.8)
title(main="Fst par paires")
#export to .pdf 4 x 5 inches
#another possibility
boxplot(pairwiseFST~species,data=bemPairFst,col=colove2[c(2,3,4)],
        las=1,ann=FALSE)
title(main="Fst par paires")


##############################################################################/
#END
##############################################################################/