slowrnorm<-function(x,count,mean=0,std=1) {
  for(i in 1:count) {
    rnorm(x)
  }
}
fastrnorm<-function(x,count,mean=0,std=1){
  data=vector(length=count)
  data=rnorm(x,mean=mean,sd=std)
  data
}