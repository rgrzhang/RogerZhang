library(deSolve)
## Vector Field for SIR model
SIR.vector.field <- function(t, vars, parms) {
  ##SIR.vector.field <- function(t, vars=c(S=S,I=I,R=R,Q=Q,X=X), parms=c(R_0=R_0,gamma=gamma,delta=delta,mu=mu,p=p)) {
    with(as.list(c(parms, vars)), {
    ## Summary: In intensional infection cases, I divided the infected further into normally infected and intensionally infected. 
    ##          While the normally infected cases are the real casualties.
    dS <- mu -gamma*R_0*S*(I_N+I_T) -p*S -mu*S# dS/dt
    dQ <- gamma*R_0*S*(I_N+I_T)+p*S + mu*p # cumulative cases
    dX <- gamma*R_0*S*I_N #cumulative normally infected cases
    dI_T <- p*S+gamma*R_0*S*I_T - gamma*I_T-mu*I_T # intensional infected cases, and cases which is infected by them
    dI_N <- gamma*R_0*S*I_N - gamma*I_N-mu*I_N # Normally infected cases
    dR <- gamma*(I_T+I_N)-mu*R #dR/dt
    
    dS_v <- mu-gamma*R_0*S_v*V -p*(S_v) - mu*(S_v)
    dV <- gamma*R_0*S_v*V - gamma*V-mu*V # Prevalence of vaccination
    dV_c <- gamma*R_0*S_v*V #cumulative infected cases with normal vaccination
    vec.fld <- c(dS=dS, dI_N=dI_N,dI_T=dI_T, dR=dR, dQ=dQ, dX=dX, dV=dV,dV_c=dV_c,dS_v=dS_v)
    return(list(vec.fld)) # ode() requires a list
  })
}

draw.soln <- function(ic=c(S=1,I_T=0,I_N=0,R=0,Q=0,X=0,V=0,V_c=0), tmax=1,
                      times=seq(0,tmax,by=tmax/500),
                      func, parms, doPlot=TRUE, ... ) {
  soln <- ode(ic, times, func, parms)
  if (doPlot) lines(times, soln[,"I_T"], lwd=1,...)
  
  return(invisible(as.data.frame(soln)))
}

## initial conditions:
I_T0 <- 0.0005
I_N0 <- 0.0005
S0 <- 0.55 ##1 - (I_T0+I_N0)
R0 <- 1 - (I_T0+I_N0) - S0
V0 <- 0.001
Q0 <- I_T0+I_N0
X0 <- Q0
V_c0 <- V0
S_v0 <- 1 - V_c0
## draw solutions for several values of parameter R_0:
##vary_p <- c(0,0.1,0.2,0.5,0.8)
vary_p <- seq(0,0.0001,length=5)

## set parameter values
R_0 <- 1.8
gamma <- 365/200 # two week mean infectious period will lead to trouble. So I chose 1 for now
delta <- 0
mu <- 1/50 # 50 year mean lifetime
epsilon <- mu/(gamma+mu)

## Plot solutions of the SIR model
tmax <- 2400 # end time for numerical integration of the ODE
## run one simulation to get sensible ylim
out <- draw.soln(ic=c(S=S0,I_N=I_N0,I_T=I_T0,R=R0,Q=Q0,X=X0,V=V0,V_c=V_c0,S_v=S_v0), tmax=tmax,
            func=SIR.vector.field,
            parms=c(R_0=R_0,gamma=gamma,delta=delta,mu=mu,p=0),
            doPlot=FALSE
            )
ymin <- min(out[["I_N"]],na.rm=TRUE)
ymax <- max(out[["I_N"]],na.rm=TRUE)
## draw box for plot:
plot(0,0,xlim=c(0,tmax),ylim=c(0,ymax),
     type="n",main="Normally infected cases (Intensionally infect proportion of S)",xlab="Time (t)",ylab="I_N",las=1)

legend("top", bty="n", title="Parameters",
       legend=c(paste0("R_0 = ",R_0),
                paste0("gamma = ",gamma),
                paste0("delta = ", delta),
                paste0("mu = ", mu)))
                                                   
for (i in 1:length(vary_p)) {
  draw.soln(ic=c(S=S0,I_N=I_N0,I_T=I_T0,R=R0,Q=Q0,X=X0,V=V0,V_c=V_c0,S_v=S_v0), tmax=tmax,
            func=SIR.vector.field,
            parms=c(R_0=R_0,gamma=gamma,delta=delta,mu=mu,p=vary_p[i]),
            col=i,
            lty=i # use a different line style for each solution
  )
}
legend("topright",legend=vary_p,col=1:length(vary_p),lty=1:length(vary_p),
       title="p",bty="n")

Ieqm <- epsilon*(1-1/R_0)
abline(h=Ieqm,col="cyan")
