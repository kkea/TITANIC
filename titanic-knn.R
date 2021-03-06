library(class)
train<-read.csv('titanic/train.csv',header=T)
test<-read.csv('titanic/test.csv',header=T)
train1<-subset(train,select=-c(PassengerId,Name))
train1[is.na(train1)]=median(train1$Age,na.rm=T)
for (i in 1:10) {train1[,i]=as.numeric(train1[,i])}
test1<-subset(test,select=-c(PassengerId,Name))
test1[is.na(test1)]=median(test1$Age,na.rm=T)
for (i in 1:10) {test1[,i]=as.numeric(test1[,i])}
set.seed(1)
errRatio<-vector()
for(i in 1:30){
  Knnfit<-knn(train=train1[,-1],test=test1[,-1],cl=train1[,1],k=i,prob=F)
  CT<-table(test1[,1],Knnfit)
  errRatio<-c(errRatio,(1-sum(diag(CT))/sum(CT))*100)
}
