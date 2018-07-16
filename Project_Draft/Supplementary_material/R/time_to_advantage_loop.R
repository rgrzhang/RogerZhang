library(deSolve)
## Vector Field for SIR model
series <- c(0.05,0.1,0.15,0.2,0.25,0.3,0.35,0.4,0.45,0.5,0.55,0.6,0.65,0.7,0.75,0.8,0.85,0.9,0.95,1)
for (i in series) {
  SIR.vector.field <- function(t, vars, parms) {
    with(as.list(c(parms, vars)), {
      dS <- mu*(1-p) -gamma*R_1*S*V-gamma*R_0*S*I -mu*S# dS/dt
      dV <- mu*p-gamma*V-mu*V # variolated cases
      dI <- gamma*R_1*S*V + gamma*R_0*S*I-gamma*I-mu*I #normally infected cases
      dM <- 0.01*gamma*V+0.3*gamma*I # disease induced mortality
      dR <- 0.99*gamma*V+0.7*gamma*I-mu*R #dR/dt
      dN <- 0.3*gamma*0.000936466
      
      vec.fld <- c(dS=dS, dV=dV, dI=dI, dM=dM, dR=dR, dN=dN)
      return(list(vec.fld)) # ode() requires a list
    })
  }
  
  draw.soln <- function(ic=c(S=1/4.5,V=0,I=0.000936466,M=0.00000002,R=0,N=0.00000001), tmax=1,
                        times=seq(0,tmax,by=tmax/500),
                        func, parms, ... ) {
    soln <- ode(ic, times, func, parms)
    
    return(invisible(as.data.frame(soln)))
  }
  
  ## Plot solutions of the SIR model
  plot_pvals <- function( tmax=4.5, # end time for numerical integration of the ODE
                          V0=0, I0=0.000936466, S0=1/4.5, R0=0, M0=0.00000002, N0=0.00000001, # initial conditions
                          vary_p=c(0,0.1,0.2,0.4,0.6,0.8,1),  # p values to use
                          ylim=c(0,1), 
                          ... ) {
    ## draw box for plot:
    plot(0,0,xlim=c(0,tmax),ylim=ylim,
         type="n",main="Normally Infected",xlab="Time (years)",ylab="I",las=1)
  }
  
  mydiff <- draw.soln(func=SIR.vector.field,
                      parms=c(R_0=4.5,R_1=2.5,gamma=1/(22/365),p=i,mu=1/50))
  time <- 0
  while (mydiff[501,5]>mydiff[501,7]) {
    draw.soln <- function(ic=c(S=mydiff[501,2],V=mydiff[501,3],I=mydiff[501,4],M=mydiff[501,5],R=mydiff[501,6],N=mydiff[501,7]), tmax=1,
                          times=seq(0,tmax,by=tmax/500),
                          func, parms, ... ) {
      soln <- ode(ic, times, func, parms)
      
      return(invisible(as.data.frame(soln)))
    }
    
    ## Plot solutions of the SIR model
    plot_pvals <- function( tmax=4.5, # end time for numerical integration of the ODE
                            V0=mydiff[501,3], I0=mydiff[501,4], S0=mydiff[501,2], R0=mydiff[501,6], M0=mydiff[501,5], N0=mydiff[501,7], # initial conditions
                            vary_p=c(0,0.1,0.2,0.4,0.6,0.8,1),  # p values to use
                            ylim=c(0,1), 
                            ... ) {
      ## draw box for plot:
      plot(0,0,xlim=c(0,tmax),ylim=ylim,
           type="n",main="Normally Infected",xlab="Time (years)",ylab="I",las=1)
    }
    
    mydiff <- draw.soln(func=SIR.vector.field,
                        parms=c(R_0=4.5,R_1=2.5,gamma=1/(22/365),p=i,mu=1/50))
    time <- time + 1
  }
  
  step <- 1
  while (mydiff[step,5]>mydiff[step,7]) {
    step <- step + 1
    time <- time + 0.002
  }
  print(time)
}
