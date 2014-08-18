


states = read.csv('Documents/insight/state_ids.csv',header=F)
dupes = read.csv('Documents/insight/duplication_status.csv',header=F)

dim(states)
dim(dupes)
head(dupes)
head(states)

duplication = table(states$V2,dupes$V2)
duplication_rate = duplication[,1]/(duplication[,2]+duplication[,1])
barplot(sort(duplication_rate),cex.names = .4)
totals = duplication[,2]+duplication[,1]
names(duplication_rate)
plot(duplication_rate~log(totals),type='n')
text(log(totals),duplication_rate,labels=names(duplication_rate),cex=.6)


votes = read.csv('Documents/insight/2012_electoral_votes.csv')

#mean_sentiment = data.frame(as.vector(means),levels(blob$state))
#names(mean_sentiment) = c('mean_sentiment','state')
duplication_rate_df = data.frame(duplication_rate,names(duplication_rate))
names(duplication_rate_df)[2]='state'
political = merge(votes,duplication_rate_df)
political

names(political)

barplot(sort(duplication_rate),cex.names = .4)





totals_df = data.frame(totals,names(totals))
names(totals_df)[2]='state'
political = merge(political,totals_df)

party = political$Electoral.Vote.of.each.State==political$Barack.Obama..of.Illinois
party_code = as.numeric(party)+1
party_color = c("red", "blue")[party_code]


barplot(sort(political$duplication_rate,decreasing = F),names.arg = political$state[order(political$duplication_rate,decreasing = F)],las=1,horiz=T,xlab='Proportion of comments that are duplicates',border = NA)
barplot(sort(political$duplication_rate,decreasing = F),names.arg = political$state[order(political$duplication_rate,decreasing = F)],las=1,col=party_color[order(political$duplication_rate,decreasing = T)],horiz=T,xlab='Proportion of comments that are duplicates',border=NA)




library(scales)
plot(political$duplication_rate~(political$totals),ylim=c(.4,.75),las=1,pch=19,cex=3.5,col=alpha(party_color,.5),xlab='Number of comments submitted',ylab='Proportion of duplicate comments')
text((political$totals),political$duplication_rate,labels=political$state,cex=.8,col='white',font=2)


names(political)

political$duplication_rate[political$state=='NY']


