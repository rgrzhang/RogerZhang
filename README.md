# RogerZhang

## 2 Feb 2018

### David's suggestions

- for fixed `R0`, draw curves with varying `delta` so that we can see the effect of `delta`

- if you can't get peak prevalence and final size analytically, you can certainly do it numerically
    - plot peak prevalence as a function of `delta` for fixed `R0` with `R0` varying in different panels
    - similarly plot final size (`Q(t)` for `t` large enough that we are close to the final size; e.g., stop if `I<1e-6`) as a function of `delta` for fixed `R0` with `R0` varying in different panels
    
## 8 Feb 2018

### Roger's progress

- I plotted I using delta = (0.1,0.3,0.5,0.8) with fixed R_0.
    - Clearly a larger delta value is going to give a sharper slope in the early stage of epidemics. 
    - Delta being the proportion of population being intensional infected, thus we should take delta<1?

- Since the additional terms delta*S gives a continuous decrease behavior of S, when I¡Ö0, dS/dt = -delta*S gives an exponantial liked behavior, thus the solution of that model will asymptotically approach S=0, meaning final size Q(t)->$\infty$, regardless of what values of delta is.

- With the additional delta term, the value of threshold R_0 = 1 for having an epidemics has to change to a lower value.
    - The existance of this intensional infection will turn the non-spreading disease into an epidemics. Then there is no point of having this extra action.
    - For intensional infection as a method of "vaccination", we may consider this as S--under intensional infection -->R. (considering in most cases, intensional infection still provide immunity without causing severe illness)

- Side comment: If we consider the intentional infection to be a some kind of vaccine, we may still what to consider the latency period? A normal latency period sends people form S to I, but for intension infection, those people go to R.

