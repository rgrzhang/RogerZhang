library(phaseR)
FHN <- function(t, y, parameters) {
  p <- parameters
  dy <- numeric(2)
  dy[1] <- 11/9136*(1-p)-4.5*y[1]*y[2]-11/9136*y[1]
  dy[2] <- 4.5*y[1]*y[2]+11/9136*p-y[2]   
  return(list(dy))
}

phasePlot <- function(FHN, p=0.2){
  FHN.flowField  <- flowField(FHN, x.lim = c(0, 0.4), 
                              y.lim = c(0, 0.02),
                              xlab="S", ylab="I",
                              main=paste0("p=", p),
                              parameters = p, 
                              points = 15, add = FALSE)  
  FHN.nullclines <- nullclines(FHN, x.lim = c(0, 0.4), 
                               y.lim = c(0, 0.02),
                               parameters = p, 
                               points = 500)  
  y0 <- matrix(c(1/4.5,0.000936466), 
               ncol = 2, nrow = 1, 
               byrow = TRUE)  
  FHN.trajectory <- trajectory(FHN, y0 = y0, t.end = 500, 
                               parameters = p)
}

op <- par(mfrow=c(2,2))
phasePlot(FHN, p= 0)
phasePlot(FHN, p=0.2)
phasePlot(FHN, p=0.5)
phasePlot(FHN, p=0.8)
par(op)