##############################################################################/
##############################################################################/
#Plotting the kdr frequency by species
##############################################################################/
##############################################################################/

#loading the data, packages and functions
source("bemG_load_data.R")
kdrDistr<-read.table("data/barplotkdr.txt",
                     header=TRUE,sep="\t",dec=",",
                     stringsAsFactors=TRUE)
summary(kdrDistr)


##############################################################################/
#Barplot for the distribution of the pyrethroid genotypes by species####
##############################################################################/

thecol<-c(brewer.pal(9,"YlOrRd")[c(8,6)],brewer.pal(9,"Greens")[5])
#final set of colors Hybrid/red-IO/orange-MEAM1/vert-MED/bleu
colove7<-c("#abdda4","#2b83ba","#fdae61","#d7191c")


#Figure 5-1
op<-par(mar=c(6, 5, 1, 1) + 0.1)
graf<-barplot(kdrDistr$n+0.1,ylim=c(0.1,1300),log="y",
              ylab="Number of individuals",cex.axis =1.3,cex.lab=2,
              las=1,xaxt="n",yaxt="n",bty="n",
              col=rep(thecol,4),
              border=NA,
              space=c(rep(0.1,3),1.4,rep(0.1,2),1.4,
                      rep(0.1,2),1.4,rep(0.1,2)),
              font.lab=2)
abline(h=c(1,10,100,1000),col=grey(0.8,0.8),lwd=2,lty=1)
barplot(kdrDistr$n+0.1,ylim=c(0.1,1100),log="y",
        ylab="Number of individuals",cex.axis =1.3,cex.lab=2,
        las=1,xaxt="n",yaxt="n",bty="n",
        col=rep(thecol,4),
        border=NA,
        space=c(rep(0.1,3),1.4,rep(0.1,2),1.4,
                rep(0.1,2),1.4,rep(0.1,2)),
        font.lab=2,add=TRUE)
axis(1,at=graf[c(2,5,8,11)],labels=FALSE, lwd=4)
axis(2,at=c(0.1,1,3,10,30,100,300,1000),
     labels=c(0,1,3,10,30,100,300,1000),lwd=4,las=1,font=2,cex.axis=1.1)
box(bty="l",lwd=4)
text(graf,kdrDistr$n*1.2+0.12,
     labels=as.character(kdrDistr$n),font=2)
mtext(levels(kdrDistr$species)[c(3,2,4,1)],at=graf[c(2,5,8,11)],
      line=1.5,cex=1.5,side=1)
mtext("Species", at=9.4,line=3,cex=2,side=1,
      font=2,padj=1)
legend(12,800,
       legend=c("R/R","R/S","S/S"),
       pch=15,col=thecol,bg=thecol,bty="n",cex=1.3,pt.cex=1.6,xpd=TRUE,
       ncol=1,x.intersp=1,y.intersp=0.8)
par(op)

#export to .pdf 5 x 8 inches


#Figure 5-2
op<-par(mar=c(6, 5, 1, 1) + 0.1)
graf<-barplot(kdrDistr$n,ylim=c(0,1000),
              ylab="Number of individuals",cex.axis =1.3,cex.lab=2,
              las=1,xaxt="n",yaxt="n",bty="n",
              col=rep(thecol,4),
              border=NA,
              space=c(rep(0.1,3),1.4,rep(0.1,2),1.4,
                      rep(0.1,2),1.4,rep(0.1,2)),
              font.lab=2)
abline(h=c(50,100,200,400,600,800,1000),col=grey(0.8,0.8),lwd=2,lty=1)
barplot(kdrDistr$n,ylim=c(0,1100),
        ylab="Number of individuals",cex.axis =1.3,cex.lab=2,
        las=1,xaxt="n",yaxt="n",bty="n",
        col=rep(thecol,4),
        border=NA,
        space=c(rep(0.1,3),1.4,rep(0.1,2),1.4,
                rep(0.1,2),1.4,rep(0.1,2)),
        font.lab=2,add=TRUE)
axis(1,at=graf[c(2,5,8,11)],labels=FALSE, lwd=4)
axis(2,at=c(50,100,200,400,600,800,1000),
     labels=c(50,100,200,400,600,800,1000),lwd=4,las=1,font=2,cex.axis=1.1)
box(bty="l",lwd=4)
text(graf,kdrDistr$n+15,
     labels=as.character(kdrDistr$n),font=2)
mtext(levels(kdrDistr$species)[c(3,2,4,1)],at=graf[c(2,5,8,11)],
      line=1.5,cex=1.4,side=1,font=2)
mtext("Species", at=9.4,line=3,cex=2,side=1,
      font=2,padj=1)
legend(12,800,
       legend=c("R/R","R/S","S/S"),
       pch=15,col=thecol,bg=thecol,bty="n",cex=1.3,pt.cex=1.6,xpd=TRUE,
       ncol=1,x.intersp=1,y.intersp=0.8)
par(op)

#export to .pdf 5 x 8 inches


##############################################################################/
#END
##############################################################################/