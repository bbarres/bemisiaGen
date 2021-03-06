##############################################################################/
##############################################################################/
#Plotting the structure graph
##############################################################################/
##############################################################################/

#loading the data, packages and functions
source("bemG_load_data.R")


##############################################################################/
#Bemisia BMS: final plot for the combine runs by pop geo then environment####
##############################################################################/

#preparing the dataset
temp<-bemipop[bemipop$species!="MED-Q",]
temp<-as.data.table(temp)
#reorder environment by decreasing anthropization
temp$environment<-factor(temp$environment,
                         levels(temp$environment)[c(2,4,1,3)])
levels(temp$environment)<-c("Greenhouse","Open field",
                            "Field surroundings","Non-cultivated")
#reorder geographical population by increasing order
temp$pop_geo<-factor(temp$pop_geo,
                     levels(temp$pop_geo)[c(1,12,23,34,37:41,
                                            2:11,13:22,24:33,35,36)])
temp$species2=temp$species
temp<-spread(temp,species2,species2)
temp$Hybride<-as.character(temp$Hybride)
temp$Hybride<-ifelse(is.na(temp$Hybride),0,1)
temp$MEAM1<-as.character(temp$MEAM1)
temp$MEAM1<-ifelse(is.na(temp$MEAM1),0,1)
temp$IO<-as.character(temp$IO)
temp$IO<-ifelse(is.na(temp$IO),0,1)
#preparing data mut L925I
temp$mut_L925I<-as.character(temp$mut_L925I)
temp$mut_L925I[is.na(temp$mut_L925I)]<-"miss"
temp<-spread(temp,mut_L925I,mut_L925I)
temp$`I925/I925`<-ifelse(is.na(temp$`I925/I925`),0,1)
temp$`L925/I925`<-ifelse(is.na(temp$`L925/I925`),0,1)
temp$`L925/L925`<-ifelse(is.na(temp$`L925/L925`),0,1)
temp$miss<-ifelse(is.na(temp$miss),0,1)
#reordering the dataset
setorder(temp,pop_geo,environment,-MeIo_clust1)
head(temp)

poptiquet<-names(table(temp$pop_geo))
effpop<-as.numeric(table(temp$pop_geo))

temp2<-as.data.frame(table(temp$environment,temp$pop_geo))
temp2<-temp2[temp2$Freq!=0,]
temp2$cumu<-cumsum(temp2$Freq)
temp2$Var2b<-temp2$Var2[c(1,1:(length(temp2$Var2)-1))]
temp2$decal<-cumsum(ifelse(temp2$Var2==temp2$Var2b,0,5))

layout(matrix(c(1,1,1,2,3),5,1,byrow=TRUE))
#plotting pop = geographic pop, subpop = environment within pop
#pick a set of colors
coloor<-c(brewer.pal(8,"Dark2")[2],brewer.pal(9,"Blues")[9])
op<-par(mar=c(0.1,1.1,0.1,0),oma=c(3,1.2,5,0))
structplot(t(temp[,c("MeIo_clust1","MeIo_clust2")]),
           coloor,effpop,poptiquet,spacepop=5,
           mef=c(0,0,1,0,0),colbord=NA,angl=0)
mtext("Genetic\nassignment",side=2,line=-10,cex=1.5,las=1)
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
     rep(par("usr")[4]+0.050,length(temp2$cumu)),labels=temp2$Var1,
     srt=25,xpd=NA,pos=4,cex=1.2)

#pick a set of colors for hybrid status
coloor<-c("orchid3","snow3","snow3","snow3")
structplot(t(temp[,c("Hybride","IO","MEAM1")]),
           coloor,effpop,poptiquet,spacepop=5,
           mef=c(0,0,1,0,0),colbord=NA,angl=0)
mtext("Hybrid",side=2,line=-10,cex=1.5,las=1)
rect(c(0,temp2$cumu)[1:length(temp2$cumu)]+temp2$decal,
     rep(0,length(temp2$cumu)),
     temp2$cumu+temp2$decal,
     rep(1,length(temp2$cumu)),
     lwd=2)

#pick a set of colors for the kdr genotype
coloor<-c(brewer.pal(9,"YlOrRd")[c(8,6)],brewer.pal(9,"Greens")[5],"white")
structplot(t(temp[,c("I925/I925","L925/I925","L925/L925","miss")]),
           coloor,effpop,poptiquet,spacepop=5,cexpop=1.5,distxax=0.1,
           mef=c(0,0,1,1,0),colbord=NA,angl=0)
mtext("kdr1 genotype",side=2,line=-10,cex=1.5,las=1)
rect(c(0,temp2$cumu)[1:length(temp2$cumu)]+temp2$decal,
     rep(0,length(temp2$cumu)),
     temp2$cumu+temp2$decal,
     rep(1,length(temp2$cumu)),
     lwd=2)
par(op)

#export to pdf 40 x 4 inches


##############################################################################/
#Bemisia BMS: plot for the combine runs by environment different lines####
##############################################################################/

#preparing the dataset
temp<-bemipop[bemipop$species!="MED-Q",]
temp<-as.data.table(temp)
#reorder environment by decreasing anthropization
temp$environment<-factor(temp$environment,
                         levels(temp$environment)[c(2,4,1,3)])
#reorder geographical population by increasing order
temp$pop_geo<-factor(temp$pop_geo,
                     levels(temp$pop_geo)[c(1,12,23,34,37:41,
                                            2:11,13:22,24:33,35,36)])
temp$species2=temp$species
temp<-spread(temp,species2,species2)
temp$Hybride<-as.character(temp$Hybride)
temp$Hybride<-ifelse(is.na(temp$Hybride),0,1)
temp$MEAM1<-as.character(temp$MEAM1)
temp$MEAM1<-ifelse(is.na(temp$MEAM1),0,1)
temp$IO<-as.character(temp$IO)
temp$IO<-ifelse(is.na(temp$IO),0,1)
#preparing data mut L925I
temp$mut_L925I<-as.character(temp$mut_L925I)
temp$mut_L925I[is.na(temp$mut_L925I)]<-"miss"
temp<-spread(temp,mut_L925I,mut_L925I)
temp$`I925/I925`<-ifelse(is.na(temp$`I925/I925`),0,1)
temp$`L925/I925`<-ifelse(is.na(temp$`L925/I925`),0,1)
temp$`L925/L925`<-ifelse(is.na(temp$`L925/L925`),0,1)
temp$miss<-ifelse(is.na(temp$miss),0,1)
#reordering the dataset
setorder(temp,environment,pop_geo,-MeIo_clust1)
head(temp)

layout(matrix(c(1,1,1,1,1,1,1,1,1,1,1,1,2,2,2,2,3,3,3,3,
                0,0,0,0,0,0,0,0,
                4,4,0,0,4,4,0,0,4,4,0,0,5,5,0,0,6,6,0,0,
                0,0,0,0,0,0,0,0,
                7,7,7,0,7,7,7,0,7,7,7,0,8,8,8,0,9,9,9,0,
                0,0,0,0,0,0,0,0,
                10,0,0,0,10,0,0,0,10,0,0,0,11,0,0,0,12,
                0,0,0),26,4,byrow=TRUE),
       widths=c(267,70,66,98))
op<-par(mar=c(0.5,6,0.1,0),oma=c(5,0,5,0))

#Greenhouse
sstemp<-temp[temp$environment=="Greenhouse",]
sstemp<-drop.levels(sstemp,reorder=FALSE)
coloor<-c(brewer.pal(8,"Dark2")[2],brewer.pal(9,"Blues")[9])
poptiquet<-names(table(sstemp$pop_geo))
effpop<-as.numeric(table(sstemp$pop_geo))
structplot(t(sstemp[,c("MeIo_clust1","MeIo_clust2")]),
           coloor,effpop,poptiquet,spacepop=0,
           mef=c(0,1,1,0,0),colbord=NA,angl=0)
mtext("Greenhouse (n=501)",side=3,xpd=TRUE,cex=1.7,line=0.5)
mtext("Genetic\nassignment",side=2,line=-3,cex=1,las=1)
#pick a set of colors for hybrid status
coloor<-c("orchid3","snow3","snow3","snow3")
structplot(t(sstemp[,c("Hybride","IO","MEAM1")]),
           coloor,effpop,poptiquet,spacepop=0,
           mef=c(0,1,1,0,0),colbord=NA,angl=0)
mtext("Hybrid",side=2,line=-3,cex=1,las=1)
#pick a set of colors for kdr genotype
coloor<-c(brewer.pal(6,"YlOrRd")[c(6,4)],brewer.pal(9,"Greens")[4],"white")
structplot(t(sstemp[,c("I925/I925","L925/I925","L925/L925","miss")]),
           coloor,effpop,poptiquet,spacepop=0,cexpop=1.5,distxax=0.25,
           mef=c(0,1,1,1,0),colbord=NA,angl=0)
mtext("kdr1 genotype",side=2,line=-3,cex=1,las=1)

#Open field
sstemp<-temp[temp$environment=="Open_field",]
sstemp<-drop.levels(sstemp,reorder=FALSE)
coloor<-c(brewer.pal(8,"Dark2")[2],brewer.pal(9,"Blues")[9])
poptiquet<-names(table(sstemp$pop_geo))
effpop<-as.numeric(table(sstemp$pop_geo))
par(mar=c(0.5,7.4,0.1,0))
structplot(t(sstemp[,c("MeIo_clust1","MeIo_clust2")]),
           coloor,effpop,poptiquet,spacepop=0,
           mef=c(0,1,1,0,0),colbord=NA,angl=0)
mtext("Open field (n=337)",side=3,xpd=TRUE,cex=1.7,line=0.5)
mtext("Genetic\nassignment",side=2,line=-1.5,cex=1,las=1)
#pick a set of colors for hybrid status
coloor<-c("orchid3","snow3","snow3","snow3")
structplot(t(sstemp[,c("Hybride","IO","MEAM1")]),
           coloor,effpop,poptiquet,spacepop=0,
           mef=c(0,1,1,0,0),colbord=NA,angl=0)
mtext("Hybrid",side=2,line=-1.5,cex=1,las=1)
#pick a set of colors for kdr genotype
coloor<-c(brewer.pal(6,"YlOrRd")[c(6,4)],brewer.pal(9,"Greens")[4],"white")
structplot(t(sstemp[,c("I925/I925","L925/I925","L925/L925","miss")]),
           coloor,effpop,poptiquet,spacepop=0,cexpop=1.5,distxax=0.25,
           mef=c(0,1,1,1,0),colbord=NA,angl=0)
mtext("kdr1 genotype",side=2,line=-1.5,cex=1,las=1)

#Field surroundings
sstemp<-temp[temp$environment=="Field_surroundings",]
sstemp<-drop.levels(sstemp,reorder=FALSE)
coloor<-c(brewer.pal(8,"Dark2")[2],brewer.pal(9,"Blues")[9])
poptiquet<-names(table(sstemp$pop_geo))
effpop<-as.numeric(table(sstemp$pop_geo))
par(mar=c(0.5,6.7,0.1,0))
structplot(t(sstemp[,c("MeIo_clust1","MeIo_clust2")]),
           coloor,effpop,poptiquet,spacepop=0,
           mef=c(0,1,1,0,0),colbord=NA,angl=0)
mtext("Field surroundings (n=403)",side=3,xpd=TRUE,cex=1.7,line=0.5)
mtext("Genetic\nassignment",side=2,line=-2,cex=1,las=1)
#pick a set of colors for hybrid status
coloor<-c("orchid3","snow3","snow3","snow3")
structplot(t(sstemp[,c("Hybride","IO","MEAM1")]),
           coloor,effpop,poptiquet,spacepop=0,
           mef=c(0,1,1,0,0),colbord=NA,angl=0)
mtext("Hybrid",side=2,line=-2,cex=1,las=1)
#pick a set of colors for kdr genotype
coloor<-c(brewer.pal(6,"YlOrRd")[c(6,4)],brewer.pal(9,"Greens")[4],"white")
structplot(t(sstemp[,c("I925/I925","L925/I925","L925/L925","miss")]),
           coloor,effpop,poptiquet,spacepop=0,cexpop=1.5,distxax=0.25,
           mef=c(0,1,1,1,0),colbord=NA,angl=0)
mtext("kdr1 genotype",side=2,line=-2,cex=1,las=1)

#Non-cultivated
sstemp<-temp[temp$environment=="Non-cultivated",]
sstemp<-drop.levels(sstemp,reorder=FALSE)
coloor<-c(brewer.pal(8,"Dark2")[2],brewer.pal(9,"Blues")[9])
poptiquet<-names(table(sstemp$pop_geo))
effpop<-as.numeric(table(sstemp$pop_geo))
par(mar=c(0.5,8,0.1,0))
structplot(t(sstemp[,c("MeIo_clust1","MeIo_clust2")]),
           coloor,effpop,poptiquet,spacepop=0,
           mef=c(0,1,1,0,0),colbord=NA,angl=0)
mtext("Non-cultivated (n=267)",side=3,xpd=TRUE,cex=1.7,line=0.5)
mtext("Genetic\nassignment",side=2,line=-0.9,cex=1,las=1)
#pick a set of colors for hybrid status
coloor<-c("orchid3","snow3","snow3","snow3")
structplot(t(sstemp[,c("Hybride","IO","MEAM1")]),
           coloor,effpop,poptiquet,spacepop=0,
           mef=c(0,1,1,0,0),colbord=NA,angl=0)
mtext("Hybrid",side=2,line=-0.9,cex=1,las=1)
#pick a set of colors for kdr genotype
coloor<-c(brewer.pal(9,"YlOrRd")[c(8,6)],brewer.pal(9,"Greens")[5],"white")
structplot(t(sstemp[,c("I925/I925","L925/I925","L925/L925","miss")]),
           coloor,effpop,poptiquet,spacepop=0,cexpop=1.5,distxax=0.25,
           mef=c(0,1,1,1,0),colbord=NA,angl=0)
mtext("kdr1 genotype",side=2,line=-0.9,cex=1,las=1)

par(op)

#export to pdf 15 x 10 inches


##############################################################################/
#Bemisia MED: final plot for the combine runs by environment####
##############################################################################/

#preparing the dataset
temp<-bemipop[bemipop$species=="MED-Q",]
temp<-as.data.table(temp)
#reorder environment by decreasing anthropization
temp$environment<-factor(temp$environment,
                         levels(temp$environment)[c(2,4,1,3)])
temp$pop_geo<-factor(temp$pop_geo,
                     levels(temp$pop_geo)[c(1,12,23,34,37:41,
                                            2:11,13:22,24:33,35,36)])
temp$species2=temp$species
temp<-spread(temp,species2,species2)
temp$`MED-Q`<-as.character(temp$`MED-Q`)
temp$`MED-Q`<-ifelse(is.na(temp$`MED-Q`),0,1)
#preparing data mut L925I
temp$mut_L925I<-as.character(temp$mut_L925I)
temp$mut_L925I[is.na(temp$mut_L925I)]<-"miss"
temp<-spread(temp,mut_L925I,mut_L925I)
temp$`I925/I925`<-ifelse(is.na(temp$`I925/I925`),0,1)
temp$`L925/I925`<-ifelse(is.na(temp$`L925/I925`),0,1)
temp$`L925/L925`<-ifelse(is.na(temp$`L925/L925`),0,1)
temp$miss<-ifelse(is.na(temp$miss),0,1)
#preparing data mut T929V
temp$mut_T929V<-as.character(temp$mut_T929V)
temp$mut_T929V[is.na(temp$mut_T929V)]<-"miss2"
temp<-spread(temp,mut_T929V,mut_T929V)
temp$`V929/V929`<-ifelse(is.na(temp$`V929/V929`),0,1)
temp$`T929/V929`<-ifelse(is.na(temp$`T929/V929`),0,1)
temp$`T929/T929`<-ifelse(is.na(temp$`T929/T929`),0,1)
temp$miss2<-ifelse(is.na(temp$miss2),0,1)
#creating new variable to order the individuals according to the clustering
temp$clumaj<-c("Med_clust1","Med_clust2","Med_clust3")[apply(
        temp[,c("Med_clust1","Med_clust2","Med_clust3")],
        1,function(x) which(x==max(x)))]
temp$cluMax<-apply(temp[,c("Med_clust1","Med_clust2","Med_clust3")],1,max)
#reordering the dataset
setorder(temp,environment,pop_geo,-species,clumaj,-cluMax)
head(temp)

poptiquet<-names(table(temp$environment))
effpop<-as.numeric(table(temp$environment))

temp2<-as.data.frame(table(temp$pop_geo,temp$environment))
temp2<-temp2[temp2$Freq!=0,]
temp2$cumu<-cumsum(temp2$Freq)
temp2$Var2b<-temp2$Var2[c(1,1:(length(temp2$Var2)-1))]
temp2$decal<-cumsum(ifelse(temp2$Var2==temp2$Var2b,0,2))
temp2$id1<-paste(temp2$Var1,temp2$Var2)
temp3<-as.data.table(table(temp$pop_geo,temp$environment))
temp3<-temp3[temp3$N!=0,]
temp3$id2<-paste(temp3$V1,temp3$V2)
temp2<-merge(temp2,temp3,by.x="id1",by.y="id2",sort=FALSE)

layout(matrix(c(1,1,1,2,3),5,1,byrow=TRUE))
#plotting pop = geographic pop, subpop = environment within pop
#pick a set of colors
coloor<-c(brewer.pal(9,"RdPu")[9],
          brewer.pal(8,"Dark2")[4],
          brewer.pal(11,"PiYG")[9])
op<-par(mar=c(0.1,8,0.1,0),oma=c(3,0,3.5,3))
structplot(t(temp[,c("Med_clust1","Med_clust2","Med_clust3")]),
           coloor,effpop[c(1,2,3)],poptiquet[c(1,2,3)],spacepop=2,
           mef=c(0,0,0,0,0),colbord=NA,angl=0)
mtext("Genetic\nassignment",side=2,line=-1,cex=1,las=1)
rect(c(0,temp2$cumu)[1:length(temp2$cumu)]+temp2$decal,
     rep(0,length(temp2$cumu)),
     temp2$cumu+temp2$decal,
     rep(1,length(temp2$cumu)),
     lwd=2)
axis(1,at=c(0,temp2$cumu)[1:length(temp2$cumu)]+temp2$decal+
       (temp2$cumu-c(0,temp2$cumu)[1:length(temp2$cumu)])/2,
     labels=FALSE,pos=0,lwd.ticks=2,lwd=0)
#adding the name of the environment on the top of the barplot
decal<-c(0,cumsum(rep(2,length(effpop[c(1,2,4)])-1)))
axis(3,at=c(0,cumsum(effpop[c(1,2,3)]))[1:length(effpop[c(1,2,3)])]+decal+
             (cumsum(effpop[c(1,2,3)])-
        c(0,cumsum(effpop[c(1,2,3)]))[1:length(effpop[c(1,2,3)])])/2,
     labels=FALSE,pos=1,lwd.ticks=2,lwd=0)
text(c(0,cumsum(effpop[c(1,2,3)]))[1:length(effpop[c(1,2,3)])]+decal+
             (cumsum(effpop[c(1,2,3)])-
        c(0,cumsum(effpop[c(1,2,3)]))[1:length(effpop[c(1,2,3)])])/2-5,
     rep(par("usr")[4]+0.1),length(effpop[c(1,2,3)]),
     labels=c("Greenhouse","Open field","     Field   \nsurroundings"),
     srt=0,xpd=NA,pos=4,cex=1.4)

#ploting the genotype of kdr1 locus
coloor<-c(brewer.pal(9,"YlOrRd")[c(8,6)],brewer.pal(9,"Greens")[5],"white")
structplot(t(temp[,c("I925/I925","L925/I925","L925/L925","miss")]),
           coloor,effpop[c(1,2,3)],poptiquet[c(1,2,3)],spacepop=2,
           cexpop=1.5,distxax=0.1,
           mef=c(0,0,0,0,0),colbord=NA,angl=0)
mtext("kdr1 genotype",side=2,line=-1,cex=1,las=1)
rect(c(0,temp2$cumu)[1:length(temp2$cumu)]+temp2$decal,
     rep(0,length(temp2$cumu)),
     temp2$cumu+temp2$decal,
     rep(1,length(temp2$cumu)),
     lwd=2)
axis(1,at=c(0,temp2$cumu)[1:length(temp2$cumu)]+temp2$decal+
             (temp2$cumu-c(0,temp2$cumu)[1:length(temp2$cumu)])/2,
     labels=FALSE,pos=0,lwd.ticks=2,lwd=0)

#plotting the genotype of kdr2 locus
coloor<-c(brewer.pal(9,"YlOrRd")[c(8,6)],brewer.pal(9,"Greens")[5],"white")
structplot(t(temp[,c("V929/V929","T929/V929","T929/T929","miss")]),
           coloor,effpop[c(1,2,3)],poptiquet[c(1,2,3)],spacepop=2,
           cexpop=1.5,distxax=0.1,
           mef=c(0,0,0,0,0),colbord=NA,angl=-10)
mtext("kdr2 genotype",side=2,line=-1,cex=1,las=1)
rect(c(0,temp2$cumu)[1:length(temp2$cumu)]+temp2$decal,
     rep(0,length(temp2$cumu)),
     temp2$cumu+temp2$decal,
     rep(1,length(temp2$cumu)),
     lwd=2)
axis(1,at=c(0,temp2$cumu)[1:length(temp2$cumu)]+temp2$decal+
             (temp2$cumu-c(0,temp2$cumu)[1:length(temp2$cumu)])/2,
     labels=FALSE,pos=0,lwd.ticks=2,lwd=0)
text(c(0,temp2$cumu)[1:length(temp2$cumu)]+temp2$decal+
             (temp2$cumu-c(0,temp2$cumu)[1:length(temp2$cumu)])/2-0,
     rep(par("usr")[3]-0.1,length(temp2$cumu)),labels=temp2$Var1,
     srt=40,xpd=NA,pos=1,cex=1.0)
par(op)

#export to .pdf 7 x 4 inches


##############################################################################/
#END
##############################################################################/