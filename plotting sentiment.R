

blob = read.csv('Documents/insight/sentiments_by_states.csv')
head(blob)
names(blob)=c('score','state')

blob = blob[blob$state!=" ",]
blob = blob[blob$state!="GU",]
blob = blob[blob$state!="VI",]
blob = blob[blob$state!="MH",]
blob = blob[blob$state!="MP",]
blob = blob[blob$state!="PW",]
blob = blob[blob$state!="VI",]

boxplot(blob$score[blob$state!='' && blob$state!='GU' && blob$state!='MH']~blob$state[blob$state!='' && blob$state!='GU' && blob$state!='MH'],ylim=c(-5,5),)


dim(blob)
levels(blob$state)

t.test(blob$score)

medians = by(blob$score,INDICES = blob$state,FUN = median)
means = by(blob$score,INDICES = blob$state,FUN = mean)

plot(means)

barplot(sort(means[2:length(means)]),cex.names = .4)

mean(blob$score)


plot(density(blob$score,bw = .25),lwd=2)

plot(density(blob$score,bw = .25),lwd=2,xlim=c(-2,2))
abline(v=mean_sentiment$mean_sentiment[mean_sentiment$state=='CA'],col='blue',lwd=3)

boxplot(blob$score[blob$state=='CA'])
boxplot(blob$score[blob$state=='CA'],ylim=c(-2,2))



mod = lm(blob$score~blob$state)
anova(mod)

votes = read.csv('Documents/insight/2012_electoral_votes.csv')

mean_sentiment = data.frame(as.vector(means),levels(blob$state))
names(mean_sentiment) = c('mean_sentiment','state')

political = merge(votes,mean_sentiment)

barplot(political$mean_sentiment)



party = political$Electoral.Vote.of.each.State==political$Barack.Obama..of.Illinois
party_code = as.numeric(party)+1
party_color = c("red", "blue")[party_code]
par(mar=c(4,4,1,1))
barplot(sort(political$mean_sentiment,decreasing = T),names.arg = political$state[order(political$mean_sentiment,decreasing = T)],col=party_color[order(political$mean_sentiment,decreasing = T)],xlim=c(-.08,.27),border = NA,horiz = T,las=1,cex.axis = .6,xlab='Average Sentiment of all comments\n(combined score of all words in each comment)',cex.names = .7)

barplot(sort(political$mean_sentiment,decreasing = T),names.arg = political$state[order(political$mean_sentiment,decreasing = T)],xlim=c(-.08,.27),border = NA,horiz = T,las=1,cex.axis = .6,xlab='Average Sentiment of all comments\n(combined score of all words in each comment)',cex.names = .7)

#axis(1,)

blob$state[which(blob$score<=(-4))]
min(blob$score)
boxplot(blob$score~blob$state,ylim=c(-5,5))

plot(density(blob$score,bw = .5),xlim=c(-2,2))

min(political$mean_sentiment)
max(political$mean_sentiment)

abline(v=political$mean_sentiment[political$state=='NY'])
abline(v=political$mean_sentiment[political$state=='CA'])

lines(density(blob$score[blob$state=='NY'],bw=.5))

lines(density(blob$score[blob$state=='SC'],bw=.5))

boxplot(blob$score[blob$state=='NY'],blob$score[blob$state!='NY'],ylim=c(-4,4))

x = t.test(blob$score[blob$state=='NY'],blob$score[blob$state!='NY'])
t.test(blob$score[blob$state=='NY'])$conf.int

plot(density(blob$score),xlim=c(-2,2))
lines(density(blob$score[blob$state=='NY']),col='red')




reps = political$state[political$Electoral!=political$Barack]
dems = political$state[political$Electoral==political$Barack]
reps
dems
head(political)


blob$state[blob$score==min(blob$score)]
which(blob$score<(-2))-1

