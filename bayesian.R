library(scales)

# read in comment rate data
data = read.csv('Documents/insight/comment_rate_data_forR.csv')

mean_rate = mean(data$comment_rate)
mean_rate

# mean_rate = alpha / beta

variance = var(data$comment_rate)
variance

mean_households = mean(data$Individual_lives_in_household_with_Internet_use_1)
mean_households

b = mean_rate/(variance - (mean_rate/mean_households))

a = mean_rate*(mean_rate/(variance - (mean_rate/mean_households)))


hist(data$comment_rate,breaks=20,freq = F)
lines(seq(from = 0.25, to = 3, by=.1),
      dgamma(x = seq(from = 0.25, to = 3, by = .1),
      shape = a, rate = b),lwd=2,col='red')


post_means = (a + data$comments)/(b + data$Individual_lives_in_household_with_Internet_use_1)
post_means


mod = lm(post_means~data$comment_rate)
summary(mod)


plot(post_means,data$comment_rate,pch=19,xlim=c(0,3),ylim=c(0,3),axes=F,xlab='Posterior predictions',ylab='Observed comment rates', col=alpha('black',.5),cex=2,asp=1)
axis(1,at = seq(0,3,.5))
axis(2,las=1,at=seq(0,3,.5))
abline(a = 0,b=1)
abline(mod,col='blue')
text(post_means-.1,data$comment_rate+.1,labels=data$state,adj=c(1,0),cex=.6)



plot(mod)
hist(post_means)

data$comments
a
b

post_vars = (a + data$comments)/((b + data$Individual_lives_in_household_with_Internet_use_1)^2)
post_vars
plot

