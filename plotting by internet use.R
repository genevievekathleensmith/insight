
data = read.csv('Documents/insight/comment_rate_data_forR.csv')


head(data)

rate = data$comments/data$Individual_lives_in_household_with_Internet_use_1

barplot(sort(rate,decreasing = T),names.arg = data$state[order(rate,decreasing = T)],cex.names = .3)


abline(h=median(rate),lty=3)
text(40,median(rate)+.3,'Median comment\nrate = 0.363',adj=c(0,1))


votes = read.csv('Documents/insight/2012_electoral_votes.csv')
head(votes)

votes[,2]==votes[,3]
votes[,2]==votes[,4]
political = merge(data[,2:5],votes)

political_rate = political$comments/political$Individual_lives_in_household_with_Internet_use_1

barplot(sort(political_rate,decreasing = T),names.arg = political$state[order(political_rate,decreasing = T)])

party = political$Electoral.Vote.of.each.State==political$Barack.Obama..of.Illinois
party_sorted = party[order(political_rate,decreasing = F)]
party_code = as.numeric(party_sorted)+1
party_color = c("red", "blue")[party_code]
barplot(sort(political_rate,decreasing = F),names.arg = political$state[order(political_rate,decreasing = F)],col=party_color,border = NA,cex.names = 1,horiz = T,las=1,cex.axis = .6,xlab='Engagement (comments per 1000 households\nwith internet access)')

barplot(sort(political_rate,decreasing = F),names.arg = political$state[order(political_rate,decreasing = F)],border = NA,cex.names = 1,horiz = T,las=1,cex.axis = .6,xlab='Engagement (comments per 1000 households\nwith internet access)')

#axis(1,)

boxplot(political$comments/political$Individual.lives.in.household.with.Internet.use.1~political$Electoral.Vote.of.each.State==political$Barack.Obama..of.Illinois)
plot(political$comments/political$Individual.lives.in.household.with.Internet.use.1,political$Electoral.Vote.of.each.State==political$Barack.Obama..of.Illinois, xlab='Engagement (comments per 1000 households with internet access)', ylab='Proportion of Democrat electoral college votes', las=1)

state_df = data.frame(sort(political_rate,decreasing = F),political$state[order(political_rate,decreasing = F)])
names(state_df) = c('rate','state')


write.csv(state_df,'Documents/insight/state_rates.csv',row.names=F)












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



val = political$comments/political$Individual_lives_in_household_with_Internet_use_1
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




party = as.numeric(political$Electoral.Vote.of.each.State[order(rate,decreasing = F)]!=political$Barack.Obama..of.Illinois[order(rate,decreasing = F)])+1
par(mar=c(4,3,1,1))
barplot(sort(rate,decreasing = F),names.arg = x$state[order(rate,decreasing = F)],las=1,cex.names = .75,horiz = T,xlab='Number of comments per thousand households with internet access',col = c("blue", "red")[party],border = NA)
abline(v=median(rate),lty=3)
text(.4,8,'Median comment\nrate = 0.363',adj=c(0,1))


