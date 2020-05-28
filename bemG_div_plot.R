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


##############################################################################/
#END
##############################################################################/