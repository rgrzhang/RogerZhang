library(ggplot2)
ggplot(data=Time_to_advantage,mapping=aes(x=p,y=Time))+
  geom_line()+
  geom_point()+
  labs(y="Years")