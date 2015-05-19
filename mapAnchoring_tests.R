#setwd("~/Documents/MapBased_GBRrad/")

# comparing two versions of map-anchoring, with difference cmmb (rec.rate) parameter:

rec=read.table("mapAnchored_gatkFinal2digitifera_cmmb3.tab",sep="\t")
names(rec)=c("CHROM","POS","scaff","scoord")

recn=read.table("mapAnchored_gatkFinal2digitifera_cmmb20.tab",sep="\t")
names(recn)=c("CHROM","POS","scaff","scoord")


# evennes of marker positions (steps=clusters of markers): 
# (not such an important measure - the markers can be naturally uneven)
par(mfrow=c(3,5))
for (c in levels(rec$CHROM)) {
	c1=subset(rec,CHROM==c)
	c1n=subset(recn,CHROM==c)
	c1$sp=c1$POS/max(c1$POS)
	c1n$sp=c1n$POS/max(c1n$POS)
	c1$ord=c(1:nrow(c1))
	c1$ord=c1$ord/nrow(c1)
	c1n$ord=c(1:nrow(c1n))
	c1n$ord=c1n$ord/nrow(c1n)
	plot(sp~ord,c1n,type="l",main=c,xlab="order",ylab="position",col="hotpink",mgp=c(2.2,1,0))
	lines(sp~ord,c1,col="royalblue")
	abline(0,1,lty=3)
	legend("topleft",lty=1,c("3","20"),col=c("royalblue","hotpink"),bty="n",title="cM/Mb:")
}

# do scaffolds overlap? (if yes, reduce cmmb setting in vcf2map):
par(mfrow=c(3,5))
l="chr1"
for (l in levels(rec$CHROM)) {
	lg1=subset(rec,CHROM==l)
	lg1n=subset(recn,CHROM==l)
	lg1$scaff=factor(lg1$scaff,levels=as.character(unique(lg1$scaff)))
	lg1n$scaff =factor(lg1n$scaff,levels=as.character(unique(lg1n$scaff)))
	colfun=colorRampPalette(rep(c("red","royalblue","gold")))
	cols=colfun(length(levels(lg1$scaff)))
	colsn=colfun(length(levels(lg1n$scaff)))
	lg1$mscaled=(lg1$POS-min(lg1$POS))/(max(lg1$POS)-min(lg1$POS))
	lg1n$mscaled=(lg1n$POS-min(lg1n$POS))/(max(lg1n$POS)-min(lg1n$POS))
	lg1$sscaled=as.numeric(lg1$scaff)/max(as.numeric(lg1$scaff))
	lg1n$sscaled=as.numeric(lg1n$scaff)/max(as.numeric(lg1n$scaff))
plot(lg1n$sscaled[order(lg1n$scaff)]~lg1n$mscaled[order(lg1n$scaff)],lg1n,type="l",col="hotpink",main=l,mgp=c(2.2,1,0),xlab="scaled map pos",ylab="scaled scaffold #")
	points(lg1n$sscaled[order(lg1n$scaff)]~lg1n$mscaled[order(lg1n$scaff)],col="hotpink",cex=0.3,pch=19)
	lines(lg1$sscaled[order(lg1$scaff)]~lg1$mscaled[order(lg1$scaff)],lg1,type="l",col="royalblue")
	points(lg1$sscaled[order(lg1$scaff)]~lg1$mscaled[order(lg1$scaff)],col="royalblue",cex=0.3,pch=19)
	legend("topleft",c("3","20"),lty=1,col=c("royalblue","hotpink"),bty="n",title="cM/Mb:")
}
