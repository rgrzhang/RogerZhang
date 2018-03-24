library(deSolve)
## Vector Field for SIR model
SIR.vector.field <- function(t, vars, parms) {
  ##SIR.vector.field <- function(t, vars=c(S=S,I=I,R=R,Q=Q,X=X), parms=c(R_0=R_0,gamma=gamma,delta=delta,mu=mu,p=p)) {
    with(as.list(c(parms, vars)), {
    dS <- mu*(1-p) -gamma*R_0*S*I -mu*S# dS/dt
    dQ <- gamma*R_0*S*I + mu*p # cumulative cases
    dX <- gamma*R_0*S*I #cumulative normally infected cases
    dI <- dQ - gamma*I-mu*I # dI/dt
    dR <- gamma*I-mu*R #dR/dt
    
    dS_v <- mu*(1-p)-gamma*R_0*S_v*V - mu*(S_v)
    dV <- gamma*R_0*S_v*V - gamma*V-mu*V # Prevalence of vaccination
    dV_c <- gamma*R_0*S_v*V #cumulative infected cases with normal vaccination
    vec.fld <- c(dS=dS, dI=dI, dR=dR, dQ=dQ, dX=dX, dV=dV,dV_c=dV_c,dS_v=dS_v)
    return(list(vec.fld)) # ode() requires a list
  })
}

draw.soln <- function(ic=c(S=1,I=0,R=0,Q=0,X=0,V=0,V_c=0), tmax=1,
                      times=seq(0,tmax,by=tmax/500),
                      func, parms, ... ) {
  soln <- ode(ic, times, func, parms)
  lines(times, soln[,"V_c"], lwd=2,...)
  lines(times, soln[,"X"], lwd=1,...)
  
  return(invisible(as.data.frame(soln)))
}

## Plot solutions of the SIR model
tmax <- 100 # end time for numerical integration of the ODE
## draw box for plot:
plot(0,0,xlim=c(0,tmax),ylim=c(1,1.5),
     type="n",main="Final Size comparison, Intensional infection and Vaccination",xlab="Time (t)",ylab="I/V",las=1)
## initial conditions:
I0 <- 0.001
S0 <- 1 - I0
R0 <- 1 - I0 - S0
V0 <- 0.001
Q0 <- I0
X0 <- Q0
V_c0 <- V0
S_v0 <- 1 - V_c0
## draw solutions for several values of parameter R_0:
vary_p <- c(0,0.1,0.2,0.5,0.8)

for (i in 1:length(vary_p)) {
  draw.soln(ic=c(S=S0,I=I0,R=R0,Q=Q0,X=X0,V=V0,V_c=V_c0,S_v=S_v0), tmax=tmax,
            func=SIR.vector.field,
            parms=c(R_0=18,gamma=1,delta=0,mu=1/80,p=vary_p[i]),
            col=i,
            lty=i # use a different line style for each solution
  )
}
legend("topright",legend=vary_p,col=1:length(vary_p),lty=1:length(vary_p))

