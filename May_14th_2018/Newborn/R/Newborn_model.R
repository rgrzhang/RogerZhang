library(deSolve)
## Vector Field for SIR model
SIR.vector.field <- function(t, vars, parms) {
    with(as.list(c(parms, vars)), {
      dS <- mu*(1-p) -gamma*R_0*S*(V+I) -mu*S# dS/dt
      dV <- gamma*R_0*S*V + mu*p-gamma*V-mu*V # variolated cases
      dI <- gamma*R_0*S*I-gamma*I-mu*I #normally infected cases
      dM <- 0.01*gamma*V+0.3*gamma*I # disease induced mortality
      dR <- 0.99*gamma*V+0.7*gamma*I-mu*R #dR/dt
   
    vec.fld <- c(dS=dS, dV=dV, dI=dI, dR=dR, dM=dM)
    return(list(vec.fld)) # ode() requires a list
  })
}

draw.soln <- function(ic=c(S=1,V=0,I=0,M=0,R=0), tmax=1,
                      times=seq(0,tmax,by=tmax/500),
                      func, parms, ... ) {
  soln <- ode(ic, times, func, parms)
  lines(times, soln[,"M"], lwd=1,...)
  
  return(invisible(as.data.frame(soln)))
}

## Plot solutions of the SIR model
tmax <- 500 # end time for numerical integration of the ODE
## draw box for plot:
plot(0,0,xlim=c(0,tmax),ylim=c(0,1),
     type="n",main="Mortality counts",xlab="Time (t)",ylab="M",las=1)
## initial conditions:
V0 <- 0
I0 <- 0.001
S0 <- 1 - I0
R0 <- 0
M0 <- 0
## draw solutions for several values of parameter R_0:
vary_p <- c(0,0.2,0.4,0.6,0.8,1)

for (i in 1:length(vary_p)) {
  draw.soln(ic=c(S=S0,V=V0,I=I0,M=M0,R=R0), tmax=tmax,
            func=SIR.vector.field,
            parms=c(R_0=4.5,gamma=1/22,p=vary_p[i],mu=0.0000548),
            col=i,
            lty=i # use a different line style for each solution
  )
}
legend("topright",legend=vary_p,col=1:length(vary_p),lty=1:length(vary_p))

