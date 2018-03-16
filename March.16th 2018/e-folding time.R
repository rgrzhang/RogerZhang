library(ggplot2)
P = seq (0,1, by=0.01)

R__0=15/(1+1/80)
mu=1/80
epsilon=mu/(1+mu)
r=((R__0*epsilon*P-epsilon)/(1-R__0*P)+(1-R__0*P)/(R__0-1))
plot(x=P,y=1/r)