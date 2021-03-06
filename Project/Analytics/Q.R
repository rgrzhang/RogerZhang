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
    vec.fld <- c(dS=dS, dI=dI, dR=dR, dQ=dQ, dX=dX)
    return(list(vec.fld)) # ode() requires a list
  })
}

draw.soln <- function(ic=c(S=1,I=0,R=0,Q=0,X=0), tmax=1,
                      times=seq(0,tmax,by=tmax/500),
                      func, parms, ... ) {
  soln <- ode(ic, times, func, parms)
  lines(times, soln[,"I"], lwd=2,... )
  return(invisible(as.data.frame(soln)))
}

## Plot solutions of the SIR model
tmax <- 50 # end time for numerical integration of the ODE
## draw box for plot:
plot(0,0,xlim=c(0,tmax),ylim=c(0,0.05),
     type="n",xlab="Time (t)",ylab="I",las=1)
## initial conditions:
I0 <- 0.001
S0 <- 1 - I0
R0 <- 1 - I0 - S0
Q0 <- I0
X0 <- Q0
## draw solutions for several values of parameter R_0:
vary_p <- c(0,0.2,0.4,0.5,0.6,0.8,1)

for (i in 1:length(vary_p)) {
  draw.soln(ic=c(S=S0,I=I0,R=R0,Q=Q0,X=X0), tmax=tmax,
            func=SIR.vector.field,
            parms=c(R_0=10,gamma=1,delta=0,mu=1/80,p=vary_p[i]),
            col=i,
            lty=i # use a different line style for each solution
  )
}
legend("topright",legend=vary_p,col=1:length(vary_p),lty=1:length(vary_p))

