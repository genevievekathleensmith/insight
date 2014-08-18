census = {"01":["Alabama",21830,266],"02":["Alaska",29932,1140],"04":["Arizona",25307,247],"05":["Arkansas",21529,201],"06":["California",25971,104],"08":["Colorado",29237,430],"09":["Connecticut",31920,247],"10":["Delaware",28405,921],"11":["District of Columbia",38014,1708],"12":["Florida",23387,172],"13":["Georgia",24682,253],"15":["Hawaii",29786,621],"16":["Idaho",22166,317],"17":["Illinois",27301,120],"18":["Indiana",24801,269],"19":["Iowa",26717,254],"20":["Kansas",26299,284],"21":["Kentucky",21871,186],"22":["Louisiana",22416,215],"23":["Maine",24367,496],"24":["Maryland",34564,457],"25":["Massachusetts",31016,231],"26":["Michigan",23938,206],"27":["Minnesota",30094,193],"28":["Mississippi",20206,292],"29":["Missouri",23933,251],"30":["Montana",23536,553],"31":["Nebraska",26450,308],"32":["Nevada",26328,314],"33":["New Hampshire",30651,420],"34":["New Jersey",32158,208],"35":["New Mexico",22775,364],"36":["New York",28449,247],"37":["North Carolina",23946,258],"38":["North Dakota",29326,721],"39":["Ohio",24778,170],"40":["Oklahoma",23460,298],"41":["Oregon",24445,303],"42":["Pennsylvania",25874,144],"44":["Rhode Island",26840,524],"45":["South Carolina",22451,260],"46":["South Dakota",25866,439],"47":["Tennessee",22570,265],"48":["Texas",25227,122],"49":["Utah",25043,402],"50":["Vermont",26323,492],"51":["Virginia",30322,193],"53":["Washington",29109,337],"54":["West Virginia",21494,268],"55":["Wisconsin",26668,179],"56":["Wyoming",26778,725]}


library(ggplot2)
x = data.frame(region=tolower(rownames(state.x77)), 
               income=state.x77[,"Income"], 
               stringsAsFactors=F)

head(x)



states_map <- map_data("state")
ggplot(x, aes(map_id = region)) + 
  geom_map(aes(fill = income), map = states_map) +
  scale_fill_gradientn(colours=c("blue","green","yellow","red")) + 
  expand_limits(x = states_map$long, y = states_map$lat)




blob = read.csv('Documents/insight/blob.csv')
names(blob)=c('score','state')
blob = blob[blob$state!=" ",]
blob = blob[blob$state!="GU",]
blob = blob[blob$state!="VI",]
blob = blob[blob$state!="MH",]
blob = blob[blob$state!="MP",]
blob = blob[blob$state!="PW",]
blob = blob[blob$state!="VI",]

means = by(blob$score,INDICES = blob$state,FUN = mean)
mean_sentiment = data.frame(as.vector(means),levels(blob$state))
names(mean_sentiment) = c('mean_sentiment','state')
votes = read.csv('Documents/insight/2012_electoral_votes.csv')
political = merge(votes,mean_sentiment)



x = data.frame(region=tolower(rownames(state.x77)), 
               income=state.x77[,"Income"], 
               stringsAsFactors=F)
head(x)
