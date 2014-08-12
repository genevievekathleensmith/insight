

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

plot(x$Total.3.years.and.older/100,x$Individual.lives.in.household.with.Internet.use.1/100,xlab='Population >3 yrs old (100 thousands)',ylab='Individuals with household internet (100 thousands)',las=1,type='n')
abline(a = 0,b = 1)
text(x$Total.3.years.and.older/100,x$Individual.lives.in.household.with.Internet.use.1/100,x$state,cex=.6)

plot(x$Individual.lives.in.household.with.Internet.use.1,x$comments)
plot(x$Individual.accesses.the.Internet.from.some.location.2,x$comments)
plot(x$Individual.accesses.the.Internet.from.home,x$comments)

per_household = x$comments/x$Individual.lives.in.household.with.Internet.use.1


barplot(sort(per_household,decreasing = F),names.arg = x$state[order(per_household,decreasing = F)],las=1,cex.names = .5,horiz = T,xlab='Number of comments per thousand households with internet access')
abline(v=median(per_household),lty=3)
text(.4,8,'Median comment\nrate = 0.363',adj=c(0,1))


write.csv(x[,c(1:5,7:9)],'Documents/insight/state_level_data.csv',row.names=F)

head(x)


votes = read.csv('Documents/insight/2012_electoral_votes.csv')
head(votes)

votes[,2]==votes[,3]

political = merge(x,votes)

boxplot(political$comments/political$Individual.lives.in.household.with.Internet.use.1~political$Electoral.Vote.of.each.State==political$Barack.Obama..of.Illinois)
plot(political$comments/political$Individual.lives.in.household.with.Internet.use.1,political$Electoral.Vote.of.each.State==political$Barack.Obama..of.Illinois, xlab='Engagement (comments per 1000 households with internet access)', ylab='Proportion of Democrat electoral college votes', las=1)

# Logistic Regression
# where F is a binary factor and 
# x1-x3 are continuous predictors 

F = as.numeric(political$Electoral.Vote.of.each.State==political$Barack.Obama..of.Illinois)
x1 = political$comments/political$Individual.lives.in.household.with.Internet.use.1

fit <- glm(F~x1,family=binomial())
summary(fit) # display results
confint(fit) # 95% CI for the coefficients
exp(coef(fit)) # exponentiated coefficients
exp(confint(fit)) # 95% CI for exponentiated coefficients
predict(fit, type="response") # predicted values
residuals(fit, type="deviance") # residuals
plot(fit)
cdplot(as.factor(F)~x1)

plot(political$comments/political$Individual.lives.in.household.with.Internet.use.1,political$Electoral.Vote.of.each.State==political$Barack.Obama..of.Illinois, xlab='Engagement (comments per 1000 households with internet access)', ylab='Proportion of Democrat electoral college votes', las=1,xlim=c(0,1.2))
lines(sort(political$comments/political$Individual.lives.in.household.with.Internet.use.1), fit$fitted.values[order(political$comments/political$Individual.lives.in.household.with.Internet.use.1)],lwd=2)


plot(density(political$comments[political$Electoral.Vote.of.each.State==political$Barack.Obama..of.Illinois]/political$Individual.lives.in.household.with.Internet.use.1[political$Electoral.Vote.of.each.State==political$Barack.Obama..of.Illinois], bw = .1), col='blue')
lines(density(political$comments[political$Electoral.Vote.of.each.State!=political$Barack.Obama..of.Illinois]/political$Individual.lives.in.household.with.Internet.use.1[political$Electoral.Vote.of.each.State!=political$Barack.Obama..of.Illinois], bw=.1), col='red')



val = political$comments/political$Individual.lives.in.household.with.Internet.use.1
median(val)

all.equal(val>median(val),political$Electoral.Vote.of.each.State==political$Barack.Obama..of.Illinois)
all.equal(val<median(val),political$Electoral.Vote.of.each.State!=political$Barack.Obama..of.Illinois)


above_med = political$state[which(val>=median(val))]
below_med = political$state[which(val<median(val))]
dem = political$state[which(political$Electoral.Vote.of.each.State==political$Barack)]
rep = political$state[which(political$Electoral.Vote.of.each.State!=political$Barack)]

intersect(above_med,dem)
setdiff(above_med,dem)


intersect(below_med,rep)
setdiff(below_med,rep)




party = as.numeric(political$Electoral.Vote.of.each.State[order(per_household,decreasing = F)]!=political$Barack.Obama..of.Illinois[order(per_household,decreasing = F)])+1
par(mar=c(4,3,1,1))
barplot(sort(per_household,decreasing = F),names.arg = x$state[order(per_household,decreasing = F)],las=1,cex.names = .75,horiz = T,xlab='Number of comments per thousand households with internet access',col = c("blue", "red")[party],border = NA)
abline(v=median(per_household),lty=3)
text(.4,8,'Median comment\nrate = 0.363',adj=c(0,1))


