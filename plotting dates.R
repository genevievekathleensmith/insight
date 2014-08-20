

dates = read.csv('Documents/insight/dates.csv',header=F)
head(dates)
names(dates) = c('id','date')
blob = read.csv('Documents/insight/sentiments_by_states.csv')
head(blob)
names(blob) = c('sentiment','state')

dim(blob)
dim(dates)

full = data.frame(dates,blob)
dim(full)

true_date = as.POSIXlt(strptime(full$date, "%Y-%m-%dT%H:%M:%SZ"))
head(true_date)

hours = round(true_date,"hour")
length(table(as.character(hours)))


days = round(true_date,"day")
days2 = as.character(days)
days3 = table(days2)

date_df = data.frame(days3)

plot(as.Date(date_df$days2),date_df$Freq,xaxt='n',pch=19,cex=.4,axes=F,xlab='',ylab='Number of comments submitted',type='p')
segments(as.Date(date_df$days2),date_df$Freq,as.Date(date_df$days2),rep(0,dim(date_df)[1]))
axis.Date(1, at=seq(min(as.Date(date_df$days2)),max(as.Date(date_df$days2)),'months'))
axis(2)


days_NY = round(true_date[full$state=='NY'],"day")
days2 = as.character(days_NY)
days3 = table(days2)
NY_df = data.frame(days3)


head(NY_df)
points(as.Date(NY_df$days2),NY_df$Freq,xaxt='n',pch=19,cex=.4,axes=F,xlab='',ylab='Number of comments submitted',col='blue')
segments(as.Date(NY_df$days2),NY_df$Freq,as.Date(NY_df$days2),rep(0,dim(NY_df)[1]),col='blue')
axis.Date(1, at=seq(min(as.Date(NY_df$days2)),max(as.Date(NY_df$days2)),'months'))
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
