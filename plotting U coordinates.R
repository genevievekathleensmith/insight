

data1 = read.csv('Documents/insight/coordinates1.csv',header=F)
data2 = read.csv('Documents/insight/coordinates2.csv',header=F)
data3 = read.csv('Documents/insight/coordinates3.csv',header=F)

states = read.csv('Documents/insight/states.csv',header=F)
dim(data1)
names(data1)

palette(rainbow(51))
plot(data1$V1,data3$V1,col=states$V1,pch=19)

