

unique_sents = read.csv("Documents/insight/unique_array.csv",header=F)
head(unique_sents)
names(unique_sents) = 'score'

non_unique_sents = read.csv("Documents/insight/non_unique_array.csv",header=F)
head(non_unique_sents)
names(non_unique_sents) = 'score'

par(mfrow=c(1,2))
par(mar=c(4,5,2,2))
hist(non_unique_sents$score, col='grey',
     breaks=400,xlim=c(-2,2.2),main='Full set of 250,000 comments',xlab='Sentiment score',las=1,axes=F,ylab='Number of comments (thousands)')
axis(1)
axis(2,at = seq(0,80000,by=10000),labels=seq(0,80,by=10),las=1)

hist(unique_sents$score, col='grey',
     breaks=400,xlim=c(-2,2.2),main='After removing templated comments',xlab='Sentiment score',las=1,axes=F,ylab='Number of comments (thousands)')
axis(1)
axis(2,at = seq(0,16000,by=2000),labels=seq(0,16,by=2),las=1)

