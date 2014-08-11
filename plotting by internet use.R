

data = read.csv('Documents/insight/usage_by_state.csv')

data2 = read.csv('Documents/insight/percapita_table.csv')


data
data2

x = merge(data,data2)
dim(data)
dim(data2)

names(x)

barplot(x$percapita)
barplot(x$comments/x$Total.3.years.and.older)

barplot(x$comments/x$Individual.lives.in.household.with.Internet.use.1)


plot(x$Individual.lives.in.household.with.Internet.use.1,x$comments)
plot(x$Individual.accesses.the.Internet.from.some.location.2,x$comments)
plot(x$Individual.accesses.the.Internet.from.home,x$comments)

per_household = x$comments/x$Individual.lives.in.household.with.Internet.use.1


y = barplot(sort(per_household,decreasing = F),names.arg = x$state[order(per_household,decreasing = F)],las=1,cex.names = .5,horiz = T,xlab='Number of comments per thousand households with internet access')
abline(v=median(per_household),lty=3)
text(.4,8,'Median comment\nrate = 0.363',adj=c(0,1))
plot(y)
