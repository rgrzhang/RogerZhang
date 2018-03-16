library(ggplot2)
t = seq (0,1, by=0.01)

R__0=4/(1+1/80)
mu=1/80
epsilon=mu/(1+mu)
r=((R__0*epsilon*x-epsilon)/(1-R__0*x)+(1-R__0*x)/(R__0-1))
plot(x=t,y=1/r)