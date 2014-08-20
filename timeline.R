



data = read.csv('Documents/insight/raw_metadata.csv')

state_totals = table(data$state)

head(data)
plot(data$date[1:5])

summary(data)
class(data$date[1])

#as.date(data$date)

?date
strptime(data$date[1], "%Y-%m-%d %H:%M:%S")
strptime(data$date[1], "%Y-%m-%d %H:%M:%S")

true_date = as.POSIXlt(strptime(data$date, "%Y-%m-%dT%H:%M:%SZ"))
plot(true_date,rep(1,dim(data)[1]))
dim(data)


days = round(true_date,"day")
days[1]
table(days)
length(days)
class(days)

days2 = as.character(days)
days3 = table(days2)
max(days3)
length(days3)
days_of_interest = as.POSIXlt(strptime(labels(days3)$days2, "%Y-%m-%d"))
plot(days_of_interest,days3,type='p',ylim=c(0,max(days3)),cex=.5)

plot(days_of_interest,days3)

p = plot(days3,ylab='Number of comments')
abline()
names(p)
p

