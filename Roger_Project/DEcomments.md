
# Comments on Roger Zhang's Math 790 final project

## 1. Introduction

- Good to see some interesting references to the literature.

## 2. Infection of "newborns"

- l.82.  Actually, you really can't ignore the latent period.  The reason this works is that we interpret $1/\gamma$ as the mean generation interval rather than the mean infectious period.

- l.115.  You mean "for convenience" not "for simplicity".  You aren't simplifying anything here.

- you've learned to make nice-looking plots with _Mathematica_, which is great.

- l.147.  "vaccinated" should say "variolated"

- l.151.  I don't understand this statement.  Nobody who was intentionally infected will later be naturally infected.  The motivation for the subdivision is different transmissibility and/or infectious period and/or CFP.

- l.161.  It would take too long to improve things like this, but I'll comment that this sentence should say something like "The case fatality proportion (CFP) is the proportion of infected individuals who die from the disease."  If I didn't know that, I'm not sure I could figure it out from the sentence you wrote.

- l.166.  In LaTeX, you must use pairs of single backquotes and apostrophe's to get opening and closing double quotes.

- l.219.  Equation (20) implies that the system collapses onto a two-dimensional centre manifold, so is asymptotically equivalent to a planar system.  This would make analytical work on global stability simpler.

- l.243.  Figure 3 would be more informative with a log scale vertically.
It also is not clear what you mean precisely by "random initial conditions".
How did you select your 50 initial states? [Answer: uniform in biologically meaningfully simplex.] What convinces you that you have sufficient numerical evidence to infer GAS?  [50 took about 10 seconds; would have been better to do 1000 at least.  It would also be better to use Latin hypercube sampling.]

- l.265.  This could also be deduced from the eigenvalues analytically.

- l.316.  In addition, a critical issue is that you are dealing with deterministic models only.  If you are interested in the probability of eradication, that should really be addressed with a stochastic model (though your analysis in the next section, 2.2.5, is a very reasonable start using a deterministic model).

- l.352.  Section 2.3.2.  You find for this more general model that there is a unique equilibrium, which is LAS only in the shaded region of Figure 10 (page 27).  What happens if the equilibrium is unstable?  Did you integrate the equations numerically to find out?  This is very incomplete.  We need to know what the asymptotic dynamics are in the unshaded region of the parameter space.

- l.389.  This is not a sentence.

- l.394.  No, the population is certainly not infinite.  However, it is continually replenished with new susceptibles, which is why we can't talk about final size.

## 3.  Intentional infection of susceptibles

- l.440.  There is really a bit more that needs to be said, but it is similar to analysis of the other model.

- Figure 11.  Again, log scale vertically would help a lot.  Most of the space of the plot is wasted with no discernable information.

- p.37.  You are missing axis labels on this plot.

- l.521.  Some good biological interpretation in this paragraph.

- p.38.  Figure 14 decreases with $\eta$, whereas Figure 6 (p.19) increases with $p$.  Why is this opposite?  You don't comment on this.  [Answer: Figure 14 is to be compared with Table 2 on p.18, not Figure 6 on p.19; it would have been much cleaer to use tables and figures consistently for the two models.]
	- also, why is $0<\eta<1$ a sensible range?  Does $\eta$ have to be less than 1?

- l.543.  It isn't the same.  You also have a reversal of trends, but in the opposite way.  What is going on?  I don't follow your logic in the remainder of this section.
[Answer: comparing apples and oranges; see above.]

## 4. Discussion

- l.564.  Stochastic analysis would almost certainly not be with differential equations.

- l.573.  Evolution of viruses does _not_ imply decay of immunity.  Measles continues to evolve, but not in antigenically significant ways.  That's why you retain lifelong immunity.

- l.592.  Some live vaccines do transmit, especially the oral polio vaccine.

- l.606.  It is impossible that you were using R (Version 1.1.423).  That must be the version of RStudio that you used.  The current version of R is alreay 3.5.

