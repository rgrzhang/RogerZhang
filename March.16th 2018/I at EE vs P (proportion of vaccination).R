library(ggplot2)
library(base)

ggplot(data=S_I_with_P, mapping=aes(x=P, y=I))+
  geom_line()
  