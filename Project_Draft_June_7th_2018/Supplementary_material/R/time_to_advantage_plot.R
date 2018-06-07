library(ggplot2)
ggplot(data=Advantage_time,mapping=aes(x=p,y=Time_to_advantage))+
  geom_line()+
  geom_point()