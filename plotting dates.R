

dates = read.csv('Documents/insight/dates.csv',header=F)
head(dates)
names(dates) = c('id','date')


plot(dates$date)
#table(dates$date)


min(dates$date)
true_date = as.POSIXlt(strptime(dates$date, "%Y-%m-%dT%H:%M:%SZ"))
plot(true_date)
head(true_date)

plot(true_date,rep(1,dim(dates)[1]))



days = round(true_date,"day")
days[1]


days2 = as.character(days)
days3 = table(days2)
max(days3)
length(days3)
days_of_interest = as.POSIXlt(strptime(labels(days3)$days2, "%Y-%m-%d"))

plot(days_of_interest,days3,type='p',ylim=c(0,max(days3)),cex=.5)

p = plot(days3,ylab='Number of comments')

date_df = data.frame(days3)
head(date_df)

plot(date_df$Freq~date_df$days2,type='l')
segments(date_df$days2,date_df$Freq,date_df$days2,rep(0,dim(date_df)[1]))

plot(as.Date(date_df$days2),date_df$Freq,xaxt='n',pch=19,cex=.4,axes=F,xlab='',ylab='Number of comments submitted')
segments(as.Date(date_df$days2),date_df$Freq,as.Date(date_df$days2),rep(0,dim(date_df)[1]))
axis.Date(1, at=seq(min(as.Date(date_df$days2)),max(as.Date(date_df$days2)),'months'))
axis(2)
?axis
max(date_df$Freq)

#abline(v=mean(true_date))


range(true_date)
mean(true_date)

date_date = as.Date(true_date)


names(days_of_interest)

strptime(labels(days3)$days2, "%Y-%m-%d")
class(days)
days[3]
length(days)
days[2]
