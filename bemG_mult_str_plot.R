##############################################################################/
##############################################################################/
#Plotting the structure graph
##############################################################################/
##############################################################################/

#loading the data, packages and functions
source("bemG_load_data.R")


##############################################################################/
#Bemisia BMS: final plot for the combine runs by pop geo + geo enviro####
##############################################################################/

#preparing the dataset
temp<-bemipop[bemipop$species!="MED-Q",]
temp<-as.data.table(temp)
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
setorder(temp,pop_geo,pop_geo_env,-species)
head(temp)

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

layout(matrix(c(1,1,1,2,3),5,1,byrow=TRUE))
#plotting pop = geographic pop, subpop = environment within pop
#pick a set of colors
coloor<-brewer.pal(8,"Dark2")[1:2]
op<-par(mar=c(0.1,1.1,0.1,0),oma=c(3,0,5,0))
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
     rep(par("usr")[4]+0.050,length(temp2$cumu)),labels=temp2$V2,
     srt=25,xpd=NA,pos=4,cex=1.2)

#plotting pop = geographic pop, subpop = environment within pop
#pick a set of colors, color based on ppt
coloor<-c("#217821","#8feA8f", #MEAM1
          "#00aad4","#80e5ff", #IO
          "#ff2a2a","#ff8080", #Hybride
          "#8d5fd3","#e5d5ff", #MED-Q
          "white")
structplot(t(temp[,c("Hybride","IO","MEAM1")]),
           coloor[c(6,4,2,9)],effpop,poptiquet,spacepop=5,
           mef=c(0,0,1,0,0),colbord=NA,angl=0)
mtext("Species",side=2,line=-10,cex=1.5,las=1)
rect(c(0,temp2$cumu)[1:length(temp2$cumu)]+temp2$decal,
     rep(0,length(temp2$cumu)),
     temp2$cumu+temp2$decal,
     rep(1,length(temp2$cumu)),
     lwd=2)

#plotting pop = geographic pop, subpop = environment within pop
#pick a set of colors, color based on ppt
coloor<-c(brewer.pal(9,"Set1")[c(1,5,3)],"white")
structplot(t(temp[,c("I925/I925","L925/I925","L925/L925","miss")]),
           coloor,effpop,poptiquet,spacepop=5,cexpop=1.5,distxax=0.1,
           mef=c(0,0,1,1,0),colbord=NA,angl=0)
mtext("kdr\ngenotype",side=2,line=-10,cex=1.5,las=1)
rect(c(0,temp2$cumu)[1:length(temp2$cumu)]+temp2$decal,
     rep(0,length(temp2$cumu)),
     temp2$cumu+temp2$decal,
     rep(1,length(temp2$cumu)),
     lwd=2)
par(op)

#export to .pdf 40 x 4 inches


##############################################################################/
#Bemisia BMS: final plot for the combine runs by environment####
##############################################################################/

#preparing the dataset
temp<-bemipop[bemipop$species!="MED-Q",]
temp<-as.data.table(temp)
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
setorder(temp,environment,pop_geo,-species)
head(temp)

poptiquet<-names(table(temp$environment))
effpop<-as.numeric(table(temp$environment))

temp2<-as.data.frame(table(temp$pop_geo,temp$environment))
temp2<-temp2[temp2$Freq!=0,]
temp2$cumu<-cumsum(temp2$Freq)
temp2$Var2b<-temp2$Var2[c(1,1:(length(temp2$Var2)-1))]
temp2$decal<-cumsum(ifelse(temp2$Var2==temp2$Var2b,0,5))
temp2$id1<-paste(temp2$Var1,temp2$Var2)
temp3<-as.data.table(table(temp$pop_geo,temp$environment))
temp3<-temp3[temp3$N!=0,]
temp3$id2<-paste(temp3$V1,temp3$V2)
temp2<-merge(temp2,temp3,by.x="id1",by.y="id2",sort=FALSE)

layout(matrix(c(1,1,1,2,3),5,1,byrow=TRUE))
#plotting pop = geographic pop, subpop = environment within pop
#pick a set of colors
coloor<-brewer.pal(8,"Dark2")[1:2]
op<-par(mar=c(0.1,1.1,0.1,0),oma=c(3,0,5,0))
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
     srt=0,xpd=NA,pos=4,cex=1.2)

#plotting pop = geographic pop, subpop = environment within pop
#pick a set of colors, color based on ppt
coloor<-c("#217821","#8feA8f", #MEAM1
          "#00aad4","#80e5ff", #IO
          "#ff2a2a","#ff8080", #Hybride
          "#8d5fd3","#e5d5ff", #MED-Q
          "white")
structplot(t(temp[,c("Hybride","IO","MEAM1")]),
           coloor[c(6,4,2,9)],effpop,poptiquet,spacepop=5,
           mef=c(0,0,1,0,0),colbord=NA,angl=0)
mtext("Species",side=2,line=-10,cex=1.5,las=1)
rect(c(0,temp2$cumu)[1:length(temp2$cumu)]+temp2$decal,
     rep(0,length(temp2$cumu)),
     temp2$cumu+temp2$decal,
     rep(1,length(temp2$cumu)),
     lwd=2)

#plotting pop = geographic pop, subpop = environment within pop
#pick a set of colors, color based on ppt
coloor<-c(brewer.pal(9,"Set1")[c(1,5,3)],"white")
structplot(t(temp[,c("I925/I925","L925/I925","L925/L925","miss")]),
           coloor,effpop,poptiquet,spacepop=5,cexpop=1.5,distxax=0.1,
           mef=c(0,0,1,1,0),colbord=NA,angl=0)
mtext("kdr\ngenotype",side=2,line=-10,cex=1.5,las=1)
rect(c(0,temp2$cumu)[1:length(temp2$cumu)]+temp2$decal,
     rep(0,length(temp2$cumu)),
     temp2$cumu+temp2$decal,
     rep(1,length(temp2$cumu)),
     lwd=2)
par(op)

#export to .pdf 40 x 4 inches


##############################################################################/
#Bemisia BMS: final plot for the combine runs by species####
##############################################################################/

#preparing the dataset
temp<-bemipop[bemipop$species!="MED-Q",]
temp<-as.data.table(temp)
#preparing data environment
temp$environment<-as.character(temp$environment)
temp<-spread(temp,environment,environment)
temp$Field_surroundings<-ifelse(is.na(temp$Field_surroundings),0,1)
temp$Greenhouse<-ifelse(is.na(temp$Greenhouse),0,1)
temp$`Non-cultivated`<-ifelse(is.na(temp$`Non-cultivated`),0,1)
temp$Open_field<-ifelse(is.na(temp$Open_field),0,1)
#preparing data mut L925I
temp$mut_L925I<-as.character(temp$mut_L925I)
temp$mut_L925I[is.na(temp$mut_L925I)]<-"miss"
temp<-spread(temp,mut_L925I,mut_L925I)
temp$`I925/I925`<-ifelse(is.na(temp$`I925/I925`),0,1)
temp$`L925/I925`<-ifelse(is.na(temp$`L925/I925`),0,1)
temp$`L925/L925`<-ifelse(is.na(temp$`L925/L925`),0,1)
temp$miss<-ifelse(is.na(temp$miss),0,1)
#reordering the dataset
setorder(temp,-species,pop_geo,-MeIo_clust1)
head(temp)

poptiquet<-names(table(temp$species))
effpop<-as.numeric(table(temp$species))[3:1]

temp2<-as.data.frame(table(temp$pop_geo,temp$species)[,c(3:1)])
temp2<-temp2[temp2$Freq!=0,]
temp2$cumu<-cumsum(temp2$Freq)
temp2$Var2b<-temp2$Var2[c(1,1:(length(temp2$Var2)-1))]
temp2$decal<-cumsum(ifelse(temp2$Var2==temp2$Var2b,0,5))
temp2$id1<-paste(temp2$Var1,temp2$Var2)
temp3<-as.data.table(table(temp$pop_geo,temp$species)[,c(3:1)])
temp3<-temp3[temp3$N!=0,]
temp3$id2<-paste(temp3$V1,temp3$V2)
temp2<-merge(temp2,temp3,by.x="id1",by.y="id2",sort=FALSE)

layout(matrix(c(1,1,1,2,3),5,1,byrow=TRUE))
#plotting pop = geographic pop, subpop = environment within pop
#pick a set of colors
coloor<-brewer.pal(8,"Dark2")[1:2]
op<-par(mar=c(0.1,1.1,0.1,0),oma=c(3,0,5,0))
structplot(t(temp[,c("MeIo_clust1","MeIo_clust2")]),
           coloor,effpop,poptiquet,spacepop=5,
           mef=c(0,1,1,0,0),colbord=NA,angl=0)
mtext("Genetic\nassignment",side=2,line=-10,cex=1.5,las=1)
rect(c(0,temp2$cumu)[1:length(temp2$cumu)]+temp2$decal,
     rep(0,length(temp2$cumu)),
     temp2$cumu+temp2$decal,
     rep(1,length(temp2$cumu)),
     lwd=0.5)
# axis(3,at=c(0,temp2$cumu)[1:length(temp2$cumu)]+temp2$decal+
#        (temp2$cumu-c(0,temp2$cumu)[1:length(temp2$cumu)])/2,
#      labels=FALSE,pos=1,lwd.ticks=0.5,lwd=0)
# text(c(0,temp2$cumu)[1:length(temp2$cumu)]+temp2$decal+
#        (temp2$cumu-c(0,temp2$cumu)[1:length(temp2$cumu)])/2-4,
#      rep(par("usr")[4]+0.050,length(temp2$cumu)),labels=temp2$Var1,
#      srt=90,xpd=NA,pos=4,cex=0.2)

#plotting pop = geographic pop, subpop = environment within pop
#pick a set of colors, color based on ppt
coloor<-coloor<-brewer.pal(8,"Dark2")[3:6]
structplot(t(temp[,c("Field_surroundings","Greenhouse",
                     "Non-cultivated","Open_field")]),
           coloor,effpop,poptiquet,spacepop=5,
           mef=c(0,1,1,0,0),colbord=NA,angl=0)
mtext("Environment",side=2,line=-10,cex=1.5,las=1)
rect(c(0,temp2$cumu)[1:length(temp2$cumu)]+temp2$decal,
     rep(0,length(temp2$cumu)),
     temp2$cumu+temp2$decal,
     rep(1,length(temp2$cumu)),
     lwd=0.5)

#plotting pop = geographic pop, subpop = environment within pop
#pick a set of colors, color based on ppt
coloor<-c(brewer.pal(9,"Set1")[c(1,5,3)],"white")
structplot(t(temp[,c("I925/I925","L925/I925","L925/L925","miss")]),
           coloor,effpop,poptiquet[3:1],spacepop=5,cexpop=1.5,distxax=0.1,
           mef=c(0,1,1,1,0),colbord=NA,angl=0)
mtext("kdr\ngenotype",side=2,line=-10,cex=1.5,las=1)
rect(c(0,temp2$cumu)[1:length(temp2$cumu)]+temp2$decal,
     rep(0,length(temp2$cumu)),
     temp2$cumu+temp2$decal,
     rep(1,length(temp2$cumu)),
     lwd=0.5)
par(op)

#export to .pdf 40 x 4 inches





##############################################################################/
#END
##############################################################################/