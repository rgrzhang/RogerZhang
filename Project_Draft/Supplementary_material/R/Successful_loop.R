library(deSolve)
## Vector Field for SIR model
series <- c(0.05,0.1,0.15,0.2,0.25,0.3,0.35,0.4,0.45,0.5,0.55,0.6,0.65,0.7,0.75,0.8,0.85,0.9,0.95,1)
for (i in series) {
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
  
  draw.soln <- function(ic=c(S=1/4.5,V=0,I=0.000936466,M=0,R=0), tmax=1,
                        times=seq(0,tmax,by=tmax/500),
                        func, parms, ... ) {
    soln <- ode(ic, times, func, parms)
    
    return(invisible(as.data.frame(soln)))
  }
  
  ## Plot solutions of the SIR model
  plot_pvals <- function( tmax=4.5, # end time for numerical integration of the ODE
                          V0=0, I0=0.000936466, S0=1/4.5, R0=0, M0=0, # initial conditions
                          vary_r=c(0,0.1,0.2,0.4,0.6,0.8,1),  # p values to use
                          ylim=c(0,1), 
                          ... ) {
    ## draw box for plot:
    plot(0,0,xlim=c(1,tmax),ylim=ylim,
         type="n",main="Normally Infected",xlab="Time (years)",ylab="I",las=1)
  }
  mysoln <- draw.soln(func=SIR.vector.field,
                      parms=c(R_0=4.5,gamma=1/(22/365),r=i,mu=1/50))
  time <- 0
  while (mysoln[501,4]>0.000001) {
    draw.soln <- function(ic=c(S=mysoln[501,2],V=mysoln[501,3],I=mysoln[501,4],M=mysoln[501,5],R=mysoln[501,6]), tmax=1,
                          times=seq(0,tmax,by=tmax/500),
                          func, parms, ... ) {
      soln <- ode(ic, times, func, parms)
      
      return(invisible(as.data.frame(soln)))
    }
    
    ## Plot solutions of the SIR model
    plot_pvals <- function( tmax=4.5, # end time for numerical integration of the ODE
                            V0=mysoln[501,3], I0=mysoln[501,4], S0=mysoln[501,2], R0=mysoln[501,6], M0=mysoln[501,5], # initial conditions
                            vary_r=c(0,0.1,0.2,0.4,0.6,0.8,1),  # p values to use
                            ylim=c(0,1), 
                            ... ) {
      ## draw box for plot:
      plot(0,0,xlim=c(0,tmax),ylim=ylim,
           type="n",main="Normally Infected",xlab="Time (years)",ylab="I",las=1)
    }
    mysoln <- draw.soln(func=SIR.vector.field,
                        parms=c(R_0=4.5,gamma=1/(22/365),r=i,mu=1/50))
    time <- 1+time  
  }
  
  step <- 1
  while (mysoln[step,4]>0.000001) {
    step <- step + 1
    time <- time + 0.002
  }
  print(time)
}
