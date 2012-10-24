def gaussian(mean, stddev)
  rho = Math.sqrt(-2 * Math.log(1 - rand))
  scale = stddev * rho
  return (mean + scale)
end
def rnorm(x,mean=0,std=1)
  dist=[]
  x.times{dist << gaussian(mean,std)}
  dist
end

# using ruby
time{ 10000.times{ rnorm(200) }}
# using R function
time{ 10000.times{ $rsruby.rnorm(200) }}
# using R loop
time{ $rsruby.slowrnorm(200,10000) }
# using efficient R
time{ $rsruby.fastrnorm(200,10000) }

