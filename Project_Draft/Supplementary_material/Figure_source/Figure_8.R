library(deSolve)
## Vector Field for SIR model
SIR.vector.field <- function(t, vars, parms) {
  with(as.list(c(parms, vars)), {
    dS <- mu*(1-p) -gamma*R_0*S*(V+I) -mu*S# dS/dt
    dV <- gamma*R_0*S*V + mu*p-gamma*V-mu*V # variolated cases
    dI <- gamma*R_0*S*I-gamma*I-mu*I #normally infected cases
    dM <- 0.2*gamma*V+0.3*gamma*I # disease induced mortality
    dR <- 0.8*gamma*V+0.7*gamma*I-mu*R #dR/dt
    
    vec.fld <- c(dS=dS, dV=dV, dI=dI, dM=dM, dR=dR)
    return(list(vec.fld)) # ode() requires a list
  })
}

draw.soln <- function(ic=c(S=1,V=0,I=0,M=0,R=0), tmax=1,
                      times=seq(0,tmax,by=tmax/500),
                      func, parms, ... ) {
  soln <- ode(ic, times, func, parms)
  lines(times, soln[,"S"], lwd=1,...)
  
  return(invisible(as.data.frame(soln)))
}

## Plot solutions of the SIR model
plot_pvals <- function( tmax=25, # end time for numerical integration of the ODE
                        V0=0.00120403, I0=0, S0=0, R0=0, M0=0, # initial conditions
                        vary_p=c(0),  # p values to use
                        ylim=c(0,1), 
                        ... ) {
  ## draw box for plot:
  plot(0,0,xlim=c(0,tmax),ylim=ylim,
       type="n",main="S as a function of time, after we stop intentional infection",xlab="Time (years)",ylab="S",las=1)
  for (i in 1:length(vary_p)) {
    draw.soln(ic=c(S=S0,V=V0,I=I0,M=M0,R=R0), tmax=tmax,
              func=SIR.vector.field,
              parms=c(R_0=4.5,gamma=1/(22/365),p=vary_p[i],mu=1/50),
              col="blue",
              lty=i # use a different line style for each solution
    )
  }
  legend("topright",legend="S after direct intentional infection stops",col="blue",lty=1:length(vary_p))
}

if (!interactive()) pdf("myplot.pdf")
plot_pvals()
plot_pvals(ylim=c(0,1))
if (!interactive()) dev.off()
abline(h=1/4.5)
text(5, 0.3, "Vaccination threshold", col = "red") 
