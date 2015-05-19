# exploring contiguity of scaffolds in old and new maps
# (plots with a lot of drop-downs indicate a lot of scaffold breaking up)
# in this case, new map is worse than the old map

#setwd("~/Documents/MapBased_GBRrad/")

map=read.table("oldMap.tab",sep="\t")
mapn=read.table("newMap.tab",sep="\t")
names(map)=c("amCon","ambp","lg","map","adSc","adbp")
names(mapn)=c("amCon","ambp","lg","map","adSc","adbp")
par(mfrow=c(3,5))
l=9
for (l in levels(as.factor(map$lg))) {
	lg1=subset(map,lg==l)
	lg1n=subset(mapn,lg==l)
	lg1$adSc=factor(lg1$adSc,levels=as.character(unique(lg1$adSc)))
	lg1n$adSc=factor(lg1n$adSc,levels=as.character(unique(lg1n$adSc)))
	colfun=colorRampPalette(rep(c("red","royalblue","gold")))
	cols=colfun(length(levels(lg1$adSc)))
	colsn=colfun(length(levels(lg1n$adSc)))
	lg1$mscaled=(lg1$map-min(lg1$map))/(max(lg1$map)-min(lg1$map))
	lg1n$mscaled=(lg1n$map-min(lg1n$map))/(max(lg1n$map)-min(lg1n$map))
	lg1$sscaled=as.numeric(lg1$adSc)/max(as.numeric(lg1$adSc))
	lg1n$sscaled=as.numeric(lg1n$adSc)/max(as.numeric(lg1n$adSc))
	
	plot(lg1n$sscaled[order(lg1n$map)]~lg1n$mscaled[order(lg1n$map)],lg1n,type="l",col="hotpink",main=paste("LG",l),mgp=c(2.2,1,0),xlab="scaled map pos",ylab="scaled scaffold #")
	lines(lg1$sscaled[order(lg1$map)]~lg1$mscaled[order(lg1$map)],lg1,type="l",col="royalblue")
	legend("topleft",c("old","new"),lty=1,col=c("royalblue","hotpink"),bty="n")
}
