library(ggplot2)
ggplot(data=Susceptible_Equilibrium,mapping=aes(x=��,y=Years))+
  geom_line()+
  geom_point()+
  labs(y="Years")