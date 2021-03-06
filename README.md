# RogerZhang

github repo is at https://github.com/rgrzhang/RogerZhang

## 2 Feb 2018

### David's suggestions

- for fixed `R0`, draw curves with varying `delta` so that we can see the effect of `delta`

- if you can't get peak prevalence and final size analytically, you can certainly do it numerically
    - plot peak prevalence as a function of `delta` for fixed `R0` with `R0` varying in different panels
    - similarly plot final size (`Q(t)` for `t` large enough that we are close to the final size; e.g., stop if `I<1e-6`) as a function of `delta` for fixed `R0` with `R0` varying in different panels
    
## 8 Feb 2018

### Roger's progress

- I plotted I using `delta` = (0.1,0.3,0.5,0.8) with fixed `R0`.
    - Clearly a larger delta value is going to give a sharper slope in the early stage of epidemics. 
    - Delta being the proportion of population being intensional infected, thus we should take delta<1?
        - [DE] delta is _not_ a proportion; it is the _rate_, per susceptible, at which susceptibles are moved to the infected class (in the absense of contact with infecteds)

- Since the additional terms `delta*S` gives a continuous decrease behavior of `S`, when `I=0`, `dS/dt = -delta*S` gives an exponantial liked behavior, thus the solution of that model will asymptotically approach $S=0$, meaning final size Q(t)->1, regardless of what values of delta is.

- With the additional delta term, the value of threshold `R0` = 1 for having an epidemics has to change to a lower value.
    - The existance of this intensional infection will turn the non-spreading disease into an epidemics. Then there is no point of having this extra action.
    - For intensional infection as a method of "vaccination", we may consider this as 'S'--under intensional infection -->'R'. (considering in most cases, intensional infection still provide immunity without causing severe illness)

- Side comment: If we consider the intentional infection to be a some kind of vaccine, we may still what to consider the latency period? A normal latency period sends people form S to I, but for intension infection, those people go to R.

# Notes from David

- `1/delta` is the mean time spent in the S class, in the absense of contact with infecteds.
- you can calculate, as a function of `delta` or `1/delta`, the time until `1-R = 10^(-6)`, for example.  This can be interpretted as the time to extinction.  So you can then plot time to extintion against `delta` and conclude something about the effects of intentional infection.
- in a more elaborate version of the model, with vital dynamics, you could look at the depth of troughs between recurrent epidemics as function of `delta`.  The deeper those troughs, the higher probability of eradication.
- if you recast the model as a stochastic process (using the Gillespie algorithm, or adaptive tau) then you can actually calculate the distribution of time to extinction.
- it would be useful to keep track, not just of `Q` but the number infected by contact vs the number infected intentionally.  For that you need to have another equation, say `dQdelta/dt = - delta*S`
- another approach would be to intentionally infect only newborns, so the outflow from the dS/dt equation due to intentional infection would be -nu p where p is the proportion intentionally infected.  These individuals go into I rather than R (where they go in the normal SIR model).  That's actually a nice model to compare.  It directly addresses the question "What if we intentionally infect people when we don't yet have a vaccine?"
    - do all the standard equilibrium and stability analyses for this model and compare the endemic equilibrium proportion with what you get for vaccination.  Have a plot with `p` going from `0` to `1` on the x-axis and the endemic equilibrium of each model on the y-axis.  You can also plot the period of damped oscillations and the decay rate (or e-folding time) of damped oscillations for each of these models.

## 16 Feb 2018

- The idea of having intensional infection is to "burn out" `S` so we can protect majority of the population.
    - In some extreme cases, if `delta` is too small, say for example: when `R0`=1.5 (`Z`= 60%). But by the end of the epidemics, only 20% of population is intensionally infected, then we could expect the effect of that be small.
    - In the above example, though the suseptable is not really being burnt out, but by reducing `S` more rapidly than normal. We may call this senario a "non-competitive" case.
    - On the other hand, if we can have a large enough `delta` to force the model into a competitive behavior, then we could have a much higher impact on the normally infected cases.

- So, for each `R0`, there exists a threshold between competitive and non-competitive. That could related to the idea of vaccinating (1-1/R0) of S to avoid epidemics.
- I've also encountered a problem with using R. In sometimes, including now, I'm unable to plot some functions with some values of `delta`. I'm unable to plot the function where `delta`<1. I have no idea why....


## 2 Mar 2018

- Plotted again, `I` vs `t`, with introduction of intensional infection only applied on new-borns, with a proportion of `p`.
    - At this point, it is meaningless to count `Q`(cumulative infected cases) and `X`(cumulative normally infected cases) ,as they both go to infinity.
    - The effect of this method is affected by `R_0`, with a HUGE `R_0` value, i.e.20, differences in p has almost no effect.
    - I don't see an obvious oscillation...

- In normal cases, X tends to increase and eventually goes to infinity. But introduction of p still would slow down the increase, in extreme case, when p=1, it converges (make sense...)

## 15 Mar 2018

- After doing stability analysis, I showed that DFE is GAS. The EE is hard to analyze symbolically, since the complexity of the equations are almost not doable by hand.
    - However, by using P values (0, 0.2, 0.4, 0.5, 0.6, 0.8, 1), I numerically determined that EE is at least LAS. For global analysis, I may require a Lyapunov's function. But again, the length of equations are off the chart...But I believe itis likely that my system is topoligically equivalent to the original one. So EE should be GAS as well.
    - The point of bifurcation may not be `R_0`=1 as we had before.

- With the choice of `beta`=4, `gamma`=1, and `mu`=1/80, eigenvalues of Jacobian at EE all reture both negative real, except when P=0. Meaning no damped oscillation.
    - I believe with another choice of the parameters, with a higher P value, damped oscillation behavior could occur. Test was done at `beta`=10, damped oscillation behavior was observed when P = 0.2, but not for P greater than that.
    - When `beta`=10, corresponding R_0 = 9.9, this is way higher than most of known diseases.

- I am curious about whether we can obvserve periodic behavior of I indirectly from looking at S. It is hard to believe that S could be stationary while I is oscilating.

- As for the e-folding time. I plotted it. But it looks abnormal. It somehow behaves like a hyperbola.

## 23 March 2018

- Please take a look at the "computation" pdf file. I made a simple computation on the system to show if there is a damped oscillation. However I find it hard to find the eigenvalues of Jacobian.

- I also made a plot "comparision between intensional infection and vaccination". The thinner line is vaccination and thick line is intensional infection.
    - This time I made some major adjustment. I seperated the intensional infected cases and normally infected cases. It is meaningful to look at the cumulative NORMALLY infected cases only.
    - After plotting the normally infected cases and infected cases of vaccination. I indeed see a much lower proportion in normally infected cases. 
    - Generally speaking, in my model, intensional infection takes a lower proportion of treatment compare to vaccination, to control the final size. (See the graph when p=0.1, intensional infection can reach a final size and no longer growing, meaning there is almost no new cases coming in, while vaccination final size still diverge to infinity)
    - The above observation may be able to explain the benefit of intensional infection, IF the intensional infected cases can pass on to someone else and act like a vaccine that can be passed on by normal contact.

- Also, continue from last week's topic. To show I vs t graph stabilizes in the long run. I change the max time to 1000.

## 29 March 2018

- Last time you asked me why I would be interested in cumulative normally infected cases only. 
    
    - We talked about the idea of making a choice: whether practice intensional infection (which means 100% infected), but at a lower risk of dying (in the case of diseases like smallpox), or taking the risk of being normally infected (for example 40%), but a much higher death rate.
    
    - Thus, in our model, there are 2 different kinds of infected states: I_N(Normally infected) and I_T(Intesionally infected). I'll explain why they should be completely separated.
    
    - That being said, our idea of intensional infection is much different from normal vaccination, most significantly because the ones being intensionally infected could infect others, so those ones being infected are also in the intensionally infected state, therefore can no longer being normally infected (An individual does not change state). So using your analogy, it is just like a vaccine that transmits
    
    - Thus, to see the advantage of this method over vaccination, it is necessary to do a direct comparison between final size. That should tell us, at the end of epidemics, what is the overall casualty. And of course, the real casualty in our method/model are the ones being normally infected.

    - I think there are two ways of proceeding with this idea: 1. Like I'm doing right now, we only apply intensional infection/vaccination to the new borns, with a certain proportion. We can look at the final size, when the models reach E.E. As well as looking at the I_N value at E.E.. 2. The more realistic model should be trying to infect Susceptibles, with a certain rate.

        - [DE, 1 Apr 2018] I agree that both these approaches should be investigated, but it is not clear that the second is more realistic.  It can be extremely difficult (or expensive) to identify susceptible individuals, so it might be easier and cheaper to simply "vaccinate" without regard to whether the individual has been infected previously.  If the person _was_ infected previously, they would be immune and would not suffer from the "vaccination" with live pathogen.


## 27 April 2018

- Here is my answer to why the horizontal line does not go through the asymptotical value of I when p=0

    - Since we're plotting I_T vs t, at p=0, I_T should stay at 0. For all positive time.
    - The mistake I made last time was to set initial value of I_T = 0.0005. In fact, it should be just I_T=0.
    - After making the adjustment, now I_T is constant at 0.

- The correct interpretation of this horizontal line at p=0 should be the following:

- When p=0, there is no intentional infection, thus I=I_N+I_T=I_N. Thus, the horizontal line should go through the asymptotical value of I_N at p=0, and it does.

### David's thoughts 27 Apr 2018

- your equilibrium analysis should begin by finding _all_ equilibria, include disease free.  The stability of the DFE is what determines the eradication theshold in terms of $\eta$.

- get an expression for ${\mathcal R}_0$ for the intentional infection model, which is not the same as for the stadard SIR model.  It is the ${\mathcal R}_0$ of the intensional infection model that determines the eradication threshold (and the stability of the endemic equilibrium).

- since the expression for the eigenvalues of the Jacobian are complicated, choose smallpox parameter for $\epsilon$ and ${\mathcal R}_0$ (i.e., ${\mathcal R}_0\approx4.5$ and then plot the discrimant and the real part of the eigenvalues as a function of $\eta$.  Take mean lifetime $1/\mu=50$ years, and mean infectious period $1/\gamma=22$ days.  This will give us insight about how the dynamics depend on $\eta$.  You can also show how this depends on ${\mathcal R}_0$ and $\epsilon$ by choosing different values for these in different panels.

- Think about and develop an argument for what a sensible range for $\eta$ is.

- write $\epsilon - \epsilon{\mathcal R}_0$ as $-\epsilon({\mathcal R}_0 - 1)$ because this is easy to interpret and recognize the sign.

### David's thoughts 22 May 2018

- add a different ${\mathcal R}_0$ for intentional infection (${\mathcal R}_V$) and different recovery rate $\gamma_V$
- then you can look at how various things depend on the ratio of reproduction numbers and/or ratio of recovery rates

### David's thoughts 28 May 2018

- If you start at the EE for the model without intentional infection (`p=0`) how _long_ does it take to reach equilibrium after introducting intentional infection of proportion `p` of the population (as a function of `p`)?  Answer this using simulations in which the initial state is the EE with `p=0` and simulate until the trajectory is within some distance of the EE for the new `p`.
    - let `x` be the full vector state, with `x0` being the initial state (EE for `p=0`) and `xf` being the EE for `p` that you choose
    - integrate (i.e., numerically solve) until `|x-xf|/|xf| < small`  where `small` is a number you experiment with

- from the time to reach the new equilibium and the annual death rate at the new equilibrium vs the old equilibrium, we may be able to say something useful about what infectional infection proportion `p` is optimal.

### David's thoughts 4 June 2018

- plot time to EE and time to advantage as a function of `p`
    - you can do this quickly from your table, but you need code that computes these times automatically so you can have as many values of `p` as you want in the plot

- add some discussion about how you could, in principle, exploit intentional infection to eradicate a disease
    - define eradication as `I` less than some threshold (e.g., `1e-6`)
    - set `I` to zero if `I` goes below the threshold
    - investigate whether you can cause eradication by using intentional infection for some time period and then stopping
        - if this works it will depend on the threshold being strictly positive and if `S` is sufficiently small
        - this has to work if you intentionally infect enough people: if you infect _everyone_ then you're done (provided births don't occur fast enough)

### David's thoughts 25 June 2018

- Figure 1 in `Some_plots.pdf`:
    - label the axes
	- make another version in which $\R_0-1$ is on a log scale show it all the way to where there is no longer damped osccilation again (assuming that happens as in the normal SIR model).
    - show curves for several values of $\epsilon$
    - also show in the $\epsilon$ vs $\R_0-1$ plane, for several values of $p$

- organize your folder so that:
    - all the R scripts (or Mathematica scripts) that create the figures are in a subfolder and so the whole project can be made by anybody who has access to this full folder.
	- have a `README.md` file that explains exactly how to build the paper, i.e., exactly the steps that need to be take to make all the figures and then compile the full document.  Ideally, you want either a `Makefile` and/or a single `Rnw` file that compiles into the final document.
    - do not include superfluous files that are not used by the project; save old version _etc_ in other folders

- We need to find some historical comments about whether people who got infected from variolated individuals got "normal" or "less deadly" smallpox.  How often did they end up with a full-blown respiratory infection?  If we can't find answer to this, then we at least need comment on this.

- What is the correct formulation for smallpox and variolation?  And what is the correct formulation for a transmissible vaccine that we design?  The latter seems more like our current model, but we need to think about this carefully.

- Think in terms of telling a coherent story.  That will guide exactly what investigations you do and what plots you make.

### David's thoughts 9 July 2018

In `July9th.tex`:
- choose values of `epsilon` that cover the range so we understand all the possible dynamics: `epsilon=10^c(-4,-3,-2,-1,), 0.5`.
- always show the limit of the SIR model too (`p=0`).  Figure 4 should have `p=0`, then go on to `p>0` figures.


There are a few points to consider wrt mode of transmission of natural or variolated smallpox.  We may not want to model all the possibilities, but at least mentioning them in the Discussion (or in the motivating section earlier) in the paper would be good:
- A variolated person might scratch their scabs and then touch their face and end up with a respiratory infection (I have no idea how common this was, but it seems plausible).
- A susceptible individual could be naturally infect via the normal respiratory route either from someone who was naturally infected, or from a variolatd individual who developed a respiratory infections, or by touch the scabs of a variolated individual and then touching their face.

- It is time to stop writing little documents and work on one coherent manuscript.

### David's thoughts 16 July 2018

In `July_16th.tex`:
- make a graph with all the curves associated with the various values of `epsilon` on the same plot so we can easily see the differences
- if you can figure out to do it, then try direct labelling of the curves (which means placing the value of `epsilon` on the curve itself so you don't have to look at a legend to interpret)
- in section 2, show all the graphs going to lower `R_0`, even `10^(-10)`, for example, so you can determine whether there is eventually turnover in the curves, i.e., if we still avoid damped osillation for all `epsilon` if `R_0` if small enough.

For paper draft:
- consider doing some phase plane analysis.  For example, if you plot the phase portraits and/or direction fields for several values of `p`, then you'll find out how intentional infection affects the _global_ dynamics, even if you can't prove anything about the global dynamics.
- use your model to express an informed opinion about whether the practice of variolation in the 18th century actually made matters better or worse.  Did more or fewer people get infected?  Did more or fewer people die? (compared with what would have been expected without variolation)
- if your modelling doesn't give you satisfactory answers and you don't have time to develop it further, then comment in the Discussion section of the paper about what you think should be done in the future to do a better job of addressing these questions.
- The second approach should be a second major section of the paper, not a distinct paper.

