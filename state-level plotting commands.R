
# read in comment rate data
data = read.csv('Documents/insight/comment_rate_data_forR.csv')

# read in sentiment data
blob = read.csv('Documents/insight/sentiments_by_states.csv')
names(blob)=c('score','state')
# calculate state-level averages for seniment
means = by(blob$score,INDICES = blob$state,FUN = mean)
# create dataframe
sentiment = data.frame(as.vector(means),levels(blob$state))
names(sentiment) = c('sentiment_score','state')
merge1 = merge(data[,c(3,8)],sentiment)

# read in duplication data
states = read.csv('Documents/insight/state_ids.csv',header=F)
dupes = read.csv('Documents/insight/duplication_status.csv',header=F)
# count number of duplicates by state
duplication = table(states$V2,dupes$V2)
# divide by total number of comments
totals = duplication[,2]+duplication[,1]
duplication_rate = duplication[,1]/(totals)
# create dataframe
duplication_rate_df = data.frame(duplication_rate,names(duplication_rate))
names(duplication_rate_df)[2]='state'

merge2 = merge(merge1,duplication_rate_df)

# read in 2012 electoral data
votes = read.csv('Documents/insight/2012_electoral_votes.csv')
party = c('republican','democrat')[(votes$Electoral.Vote.of.each.State==votes$Barack.Obama..of.Illinois)+1]
party_df = data.frame(votes$state,party)
names(party_df)[1]='state'

political = merge(merge2,party_df)
political

write.csv(political$comment_rate,'comment_rates.csv',row.names=F)

write.csv(political,'Documents/insight/state_level_summary.csv',row.names=F)

party_color = c("red", "blue")[(political$party=='democrat')+1]


library(scales)

plot(political)

plot(political$comment_rate,political$sentiment_score,
     las=1,pch=19,cex=3.5,col=alpha(party_color,.5),
     xlab='State-wide engagement rate',
     ylab='Average sentiment score across state',
     axes=F)
text(political$comment_rate,political$sentiment_score,
     labels = political$state,
     cex = .8, col='white',font=2)
axis(1)
axis(2,las=1)

plot(political$comment_rate,political$sentiment_score,
     las=1,pch=19,cex=3.5,col='grey',#alpha(party_color,.5),
     xlab='State-wide engagement rate',
     ylab='Average sentiment score across state',
     axes=F)
text(political$comment_rate,political$sentiment_score,
     labels = political$state,
     cex = .8, col='white',font=2)
axis(1)
axis(2,las=1)


plot(political$duplication_rate,political$sentiment_score,
     las=1,pch=19,cex=3*political$comment_rate,col=alpha(party_color,.5),
     xlab='State-wide duplication rate',
     ylab='Average sentiment score across state',
     axes=F)
text(political$duplication_rate,political$sentiment_score,
     labels = political$state,
     cex = .8, col='white',font=2)
axis(1)
axis(2,las=1)






dim(blob)
head(blob)
max(blob$score)
blob[which(blob$score==max(blob$score)),]

hist(blob$score,xlim=c(-2,2),breaks=10000)
mode(blob$score)

freqs = table(blob$score)
names(freqs)[freqs==max(freqs)]

which(blob$score==(-0.440086229423352),arr.ind=T)[1:10]



unique_ids = read.csv('Documents/insight/unique_ids.csv',header=F)
head(unique_ids)
dim(unique_ids)

unique_state = states$V2[unique_ids$V2]
length(table(unique_state))

length(table(states$V2))

unique_df = data.frame(table(unique_state),table(states$V2))
head(unique_df)
any(unique_df$unique_state!=unique_df$Var1)
all(unique_df$unique_state==unique_df$Var1)

unique_df$unique_portion = unique_df$Freq/unique_df$Freq.1

plot(unique_df$unique_portion)
text(c(1:60),unique_df$unique_portion,unique_df$unique_state)

plot(unique_df$unique_portion,ylim=c(.45,.65))
text(c(1:60),unique_df$unique_portion,unique_df$unique_state)


plot(1-unique_df$unique_portion,ylim=c(.35,.55))
text(c(1:60),1-unique_df$unique_portion,unique_df$unique_state)

