##############################################################################/
##############################################################################/
#Diversity analyses
##############################################################################/
##############################################################################/

#loading the data, packages and functions
source("bemG_load_data.R")


##############################################################################/
#preparing the data set for within species diversity analysis####
##############################################################################/

#we first remove the 'hybride' from the data set, so we can study each 
#species distinctively
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
alleles(bemAde)


##############################################################################/
#Analysis of the MED species####
##############################################################################/

MedAde<-bemAde[bemAde@other$species=="MED-Q"]
#we remove population with less than 4 individuals
MedAde<-MedAde[MedAde$pop %in% 
                 names(summary(MedAde)$n.by.pop)[summary(MedAde)$n.by.pop>4]]
#turning the ind file into a pop file
popMedAde<-genind2genpop(MedAde,process.other=TRUE)

#testing the effect of environment within the geographic level
withGeo<-test.within(genind2hierfstat(MedAde)[,-c(1)],
                     within=hier(MedAde)[,1],
                     test.lev=hier(MedAde)[,2],
                     1000)
withGeo$p.val #it seems that there is an effect of the environment
#F-statistic with two levels
varcomp.glob(levels=hier(MedAde),
             loci=genind2hierfstat(MedAde)[,-c(1)])
basic.stats(genind2hierfstat(MedAde))
#Global F-stat (Weir & Cockerman 1984)
wc(genind2hierfstat(MedAde))
#pairwise F-stat (Weir & Cockerman 1984)
pairwise.WCfst(genind2hierfstat(MedAde))
Meddivtab<-poppr(MedAde)[-4,c(1:3)]
Meddivtab<-data.frame(Meddivtab,
                      "Missing"=unlist(lapply(seppop(MedAde),
                        function(e) summary(e)$NA.perc)),
                      "Ho"=unlist(lapply(seppop(MedAde),
                        function(e) mean(summary(e)$Hobs,na.rm=TRUE))),
                      "He"=Hs(MedAde),
                      "Na"=summary(MedAde)$pop.n.all,
                      "Ar"=colMeans(allelic.richness(MedAde)$Ar),
                      "species"="MED-Q")

#finding the location with several populations (ie several environments)
sevenvir<-names(rowSums(
  table(MedAde@strata$pop_geo,
        MedAde@strata$pop_geo_env)!=0))[
          rowSums(table(MedAde@strata$pop_geo,
                        MedAde@strata$pop_geo_env)!=0)>1]
subMedAde<-MedAde[MedAde$strata$pop_geo %in% sevenvir]
pairwise.WCfst(genind2hierfstat(subMedAde))

#computing Fst but grouping individuals by other strate
setPop(MedAde)<- ~environment
#Global F-stat (Weir & Cockerman 1984)
wc(genind2hierfstat(MedAde))
#pairwise F-stat (Weir & Cockerman 1984)
pairwise.WCfst(genind2hierfstat(MedAde))
poppr(MedAde)
summary(MedAde)

setPop(MedAde)<- ~host_plant
#Global F-stat (Weir & Cockerman 1984)
wc(genind2hierfstat(MedAde))
#pairwise F-stat (Weir & Cockerman 1984)
pairwise.WCfst(genind2hierfstat(MedAde))
poppr(MedAde)
summary(MedAde)


##############################################################################/
#Analysis of the MEAM1 species####
##############################################################################/

MeaMAde<-bemAde[bemAde@other$species=="MEAM1"]
#we remove population with less than 4 individuals
MeaMAde<-MeaMAde[MeaMAde$pop %in% 
          names(summary(MeaMAde)$n.by.pop)[summary(MeaMAde)$n.by.pop>4]]
#turning the ind file into a pop file
popMeaMAde<-genind2genpop(MeaMAde,process.other=TRUE)

#testing the effect of environment within the geographic level
withGeo<-test.within(genind2hierfstat(MeaMAde)[,-c(1)],
                     within=hier(MeaMAde)[,1],
                     test.lev=hier(MeaMAde)[,2],
                     1000)
withGeo$p.val #it seems that there is an effect of the environment
#F-statistic with two levels
varcomp.glob(levels=hier(MeaMAde),
             loci=genind2hierfstat(MeaMAde)[,-c(1)])
basic.stats(genind2hierfstat(MeaMAde))
#Global F-stat (Weir & Cockerman 1984)
wc(genind2hierfstat(MeaMAde))
#pairwise F-stat (Weir & Cockerman 1984)
pairwise.WCfst(genind2hierfstat(MeaMAde))
MeaMdivtab<-poppr(MeaMAde)[-35,c(1:3)]
MeaMdivtab<-data.frame(MeaMdivtab,
                       "Missing"=unlist(lapply(seppop(MeaMAde),
                        function(e) summary(e)$NA.perc)),
                       "Ho"=unlist(lapply(seppop(MeaMAde),
                        function(e) mean(summary(e)$Hobs,na.rm=TRUE))),
                       "He"=Hs(MeaMAde),
                       "Na"=summary(MeaMAde)$pop.n.all,
                       "Ar"=colMeans(allelic.richness(MeaMAde)$Ar),
                       "species"="MEAM1")

#finding the location with several populations (ie several environments)
sevenvir<-names(rowSums(
  table(MeaMAde@strata$pop_geo,
        MeaMAde@strata$pop_geo_env)!=0))[
          rowSums(table(MeaMAde@strata$pop_geo,
                        MeaMAde@strata$pop_geo_env)!=0)>1]
subMeaMAde<-MeaMAde[MeaMAde$strata$pop_geo %in% sevenvir]
pairwise.WCfst(genind2hierfstat(subMeaMAde))

#computing Fst but grouping individuals by other strate
setPop(MeaMAde)<- ~environment
#Global F-stat (Weir & Cockerman 1984)
wc(genind2hierfstat(MeaMAde))
#pairwise F-stat (Weir & Cockerman 1984)
pairwise.WCfst(genind2hierfstat(MeaMAde))
poppr(MeaMAde)
summary(MeaMAde)

setPop(MeaMAde)<- ~host_plant
#Global F-stat (Weir & Cockerman 1984)
wc(genind2hierfstat(MeaMAde))
#pairwise F-stat (Weir & Cockerman 1984)
pairwise.WCfst(genind2hierfstat(MeaMAde))
poppr(MeaMAde)
summary(MeaMAde)


##############################################################################/
#Analysis of the IO species####
##############################################################################/

IoAde<-bemAde[bemAde@other$species=="IO"]
#we remove population with less than 4 individuals
IoAde<-IoAde[IoAde$pop %in% 
                   names(summary(IoAde)$n.by.pop)[summary(IoAde)$n.by.pop>4]]
#turning the ind file into a pop file
popIoAde<-genind2genpop(IoAde,process.other=TRUE)

#testing the effect of environment within the geographic level
withGeo<-test.within(genind2hierfstat(IoAde)[,-c(1)],
                     within=hier(IoAde)[,1],
                     test.lev=hier(IoAde)[,2],
                     1000)
withGeo$p.val #it seems that there is no effect of the environment
#F-statistic with two levels
varcomp.glob(levels=hier(IoAde),
             loci=genind2hierfstat(IoAde)[,-c(1)])
basic.stats(genind2hierfstat(IoAde))
#Global F-stat (Weir & Cockerman 1984)
wc(genind2hierfstat(IoAde))
#pairwise F-stat (Weir & Cockerman 1984)
pairwise.WCfst(genind2hierfstat(IoAde))
Iodivtab<-poppr(IoAde)[-22,c(1:3)]
Iodivtab<-data.frame(Iodivtab,
                     "Missing"=unlist(lapply(seppop(IoAde),
                      function(e) summary(e)$NA.perc)),
                     "Ho"=unlist(lapply(seppop(IoAde),
                      function(e) mean(summary(e)$Hobs,na.rm=TRUE))),
                     "He"=Hs(IoAde),
                     "Na"=summary(IoAde)$pop.n.all,
                     "Ar"=colMeans(allelic.richness(IoAde)$Ar),
                     "species"="IO")

#finding the location with several populations (ie several environments)
sevenvir<-names(rowSums(
  table(IoAde@strata$pop_geo,
        IoAde@strata$pop_geo_env)!=0))[
          rowSums(table(IoAde@strata$pop_geo,
                        IoAde@strata$pop_geo_env)!=0)>1]
subIoAde<-IoAde[IoAde$strata$pop_geo %in% sevenvir]
pairwise.WCfst(genind2hierfstat(subIoAde))

#computing Fst but grouping individuals by other strate
setPop(IoAde)<- ~environment
#Global F-stat (Weir & Cockerman 1984)
wc(genind2hierfstat(IoAde))
#pairwise F-stat (Weir & Cockerman 1984)
pairwise.WCfst(genind2hierfstat(IoAde))
poppr(IoAde)
summary(IoAde)

setPop(IoAde)<- ~host_plant
#Global F-stat (Weir & Cockerman 1984)
wc(genind2hierfstat(IoAde))
#pairwise F-stat (Weir & Cockerman 1984)
pairwise.WCfst(genind2hierfstat(IoAde))
poppr(IoAde)
summary(IoAde)


##############################################################################/
#Concatenate a diversity file for all species (with pop with >4 ind)####
##############################################################################/

diversiSpec<-rbind(Meddivtab,MeaMdivtab,Iodivtab)
write.table(diversiSpec,file="output/diversiSpec.txt",
            sep="\t",quote=FALSE,row.names=FALSE)


##############################################################################/
#END
##############################################################################/