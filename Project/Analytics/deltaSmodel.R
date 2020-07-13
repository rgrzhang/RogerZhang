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
  lines(times, soln[,"Q"], col=vary_delta[i], lwd=3,... )
}

## Plot solutions of the SIR model
tmax <- 100 # end time for numerical integration of the ODE
## draw box for plot:
plot(0,0,xlim=c(0,tmax),ylim=c(0,1),
     type="n",xlab="Time (t)",ylab="Prevalence (I)",las=1)
## initial conditions:
I0 <- 0.001
S0 <- 1 - I0
R0 <- 1 - I0 - S0
Q0 <- I0

## draw solutions for several values of parameter R_0:
vary_delta <- c(0.1,0.3,0.5,0.8,1)
for (i in 1:length(vary_delta)) {
  draw.soln(ic=c(S=S0,I=I0,R=R0,Q=Q0), tmax=tmax,
            func=SIR.vector.field,
            parms=c(R_0=2,gamma=1/4,delta=vary_delta[i],mu=0.3,sigma=0.03),
            lty=i # use a different line style for each solution
  )
}
legend("topright",legend=vary_delta,col=vary_delta,lty=1:6)



  
                             