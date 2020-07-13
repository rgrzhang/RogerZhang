library(deSolve)
## Vector Field for SIR model
SIR.vector.field <- function(t, vars, parms) {
    with(as.list(c(parms, vars)), {
      dS <- mu*(1-p) -R_0V*gamma_V*S*V-R_0I*gamma_I*S*I-mu*S# dS/dt
      dV <- R_0V*gamma_V*S*V + mu*p-gamma_V*V-mu*V # variolated cases
      dI <- R_0I*gamma_I*S*I-gamma_I*I-mu*I #normally infected cases
      dM <- 0.01*gamma_V*V+0.3*gamma_I*I # disease induced mortality
      dR <- 0.99*gamma_V*V+0.7*gamma_I*I-mu*R #dR/dt
   
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
plot_pvals <- function( tmax=8000, # end time for numerical integration of the ODE
                       V0=0, I0=0.001, S0=1 - I0, R0=0, M0=0, # initial conditions
                       vary_p=c(0,0.2,0.4,0.6,0.8,1),  # p values to use
                       ylim=c(0,1), 
                       ... ) {
    ## draw box for plot:
    plot(0,0,xlim=c(0,tmax),ylim=ylim,
         type="n",main="Mortality counts",xlab="Time (t)",ylab="M",las=1)
    for (i in 1:length(vary_p)) {
        draw.soln(ic=c(S=S0,V=V0,I=I0,M=M0,R=R0), tmax=tmax,
            func=SIR.vector.field,
            parms=c(R_0V=2,R_0I=4.5,gamma_I=1/22,gamma_V=1/22,p=vary_p[i],mu=0.0000548),
            col=i,
            lty=i # use a different line style for each solution
            )
    }
    legend("topright",legend=vary_p,col=1:length(vary_p),lty=1:length(vary_p))
}

if (!interactive()) pdf("myplot.pdf")
plot_pvals()
plot_pvals(ylim=c(0,1))
if (!interactive()) dev.off()
