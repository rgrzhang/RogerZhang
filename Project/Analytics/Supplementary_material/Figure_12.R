library(ggplot2)
library(deSolve)
## Vector Field for SIR model
SIR.vector.field <- function(t, vars, parms) {
  with(as.list(c(parms, vars)), {
    dS <- mu -gamma*R_0*S*(V+I) -r*S-mu*S# dS/dt
    dV <- gamma*R_0*S*V + r*S-gamma*V-mu*V # variolated cases
    dI <- gamma*R_0*S*I-gamma*I-mu*I #normally infected cases
    
    vec.fld <- c(dS=dS, dV=dV, dI=dI)
    return(list(vec.fld)) # ode() requires a list
  })
}

draw.soln <- function(ic=c(S=S,V=V,I=I), tmax=3,
                      times=seq(0,tmax,by=tmax/500),
                      func, parms, ... ) {
  soln <- ode(ic, times, func, parms)
  
  return(invisible(as.data.frame(soln)))
}
df_W <- list() # made a list store runs in loops
runs <- 1000 # assign number of loops

for (i in 1:runs){
  S <- runif(1, 0, 1)
  S
  V<- runif(1,0,1-S)
  V
  I<-1-S-V
  
  mydiff <- draw.soln(func=SIR.vector.field,
                      parms=c(R_0=4.5,gamma=1/(22/365),r=2,mu=1/50))
  Df <- mydiff
  Shat <- 1/4.5-2*2/(1/(22/365)+1/50)/(4.5*(-(2/(1/(22/365)+1/50)+11/9136-11*4.5/9136)+2*2/(1/(22/365)+1/50)+((2/(1/(22/365)+1/50)+11/9136-11*4.5/9136)^2+4*4.5*11/9136*2/(1/(22/365)+1/50))^(0.5)))
  Vhat <- (-(2/(1/(22/365)+1/50)+11/9136-11*4.5/9136)+((2/(1/(22/365)+1/50)+11/9136-11*4.5/9136)^2+4*4.5*11/9136*2/(1/(22/365)+1/50))^(0.5))/(9)
  Df$dS <- Df$S-Shat
  Df$dV <- Df$V-Vhat
  Df$W <-log10((Df$dS^2 + Df$dV^2 + Df$I^2)^(1/2))
  
  df_W[[i]] <- data.frame(time=Df$time, W=Df$W, runNum = rep(i, length(Df$time)))
}

df_W <- rlist::list.rbind(df_W)


# ggplot(data = Df,mapping = aes(x=time,y=Distance))+
#   geom_line(aes(x=time,y=W))+
#   ylim(0,1)

ggplot(data = df_W,mapping = aes(x=years,y=Distance))+
  geom_line(aes(x=time, y=W, colour = factor(runNum)))+
  theme(legend.position = "none")+
  labs(title="Distance between dynamics of the system to the EE")+
  ylab("log(Distance)")

