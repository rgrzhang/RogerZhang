library(deSolve)
## Vector Field for SIR model
SIR.vector.field <- function(t, vars, parms) {
  with(as.list(c(parms, vars)), {
    dS <- mu -gamma*R_0*S*(V+I) -r*S-mu*S# dS/dt
    dV <- gamma*R_0*S*V +r*S-gamma*V-mu*V # variolated cases
    dI <- gamma*R_0*S*I-gamma*I-mu*I #normally infected cases
    dM <- 0.01*gamma*V+0.3*gamma*I # disease induced mortality
    dR <- 0.99*gamma*V+0.7*gamma*I-mu*R #dR/dt
    
    vec.fld <- c(dS=dS, dV=dV, dI=dI, dM=dM, dR=dR)
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
tmax <- 5000 # end time for numerical integration of the ODE
## draw box for plot:
plot(0,0,xlim=c(0,tmax),ylim=c(0,0.06),
     type="n",main="Mortality counts",xlab="Time (t)",ylab="M",las=1)
## initial conditions:
V0 <- 0
I0 <- 0.001
S0 <- 1 - I0
R0 <- 0
M0 <- 0
## draw solutions for several values of parameter R_0:
vary_r <- c(1/90,1/75,1/60,1/45,1/30)

for (i in 1:length(vary_r)) {
  draw.soln(ic=c(S=S0,V=V0,I=I0,M=M0,R=R0), tmax=tmax,
            func=SIR.vector.field,
            parms=c(R_0=4.5,gamma=1/22,r=vary_r[i],mu=0.0000548),
            col=i,
            lty=i # use a different line style for each solution
  )
}
legend("topright",legend=vary_r,col=1:length(vary_r),lty=1:length(vary_r))
