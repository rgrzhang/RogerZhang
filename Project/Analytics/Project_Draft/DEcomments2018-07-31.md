# David's comments on `Roger_project_Draft.pdf` (of 31 July 2018)

## Introduction

- You need to cite references from the literature to support any claims you make.

## 2 Models: Intentional infect proportion of susceptible

- line 70.  This is the newborn model, not the susceptible model.

- line 77.  You didn't finish the sentence in brackets.  Also, here and elsewhere, you should always have a space before an opening bracket.

- lines 102-103.  Put `\noalign{\vspace{10pt}}` between these two equations so they are spaced out a bit more and easier to read.

- Figure 1: the `epsilon` labelling isn't working the way it should.  It would be better to use direct labelling near the peak of each curve.

- Figures 2-5: it would be better to have a single four-panel figure, with the range of `R0-1` being identical in all four panels.

- lines 150-153.  This is not correct.  I can't tell if you are confused or it is just your English.  It is already true in this simplest model that individuals who are intentionally infected cannot be naturally infected or vice versa.

- lines 177-182.  You should comment on the meaning of `R0` here.  Is it actually the basic reproduction number for this model?  If not, what is the basic reproduction number for this model?  Is it well defined?

- line 184.  "letting" --> "setting", and "solutions" --> "equilibria".

- line 187.  "equilibriums" --> "equilibria".  Also, this is a bit confusing.  You should make clear that you are setting `p=0` in your model here, hence you still have a `V` variable (which is not part of the standard SIR model).

- line 192.  "since" --> "with" or "if"

- line 197.  "the equilibrium is" --> "there is only one equilibrium"

- line 211.  You need to say you are considering `S = Shat`, and carry that through.  You are missing hats in what follows.

- line 216.  add "in equations 18a and 18b".

- line 226.  "stable" --> "locally asymptotically stable".

- line 228.  "method" --> "intervention"

- line 231.  use `\left. dM/dt \right|_{EE}` to get a large vertical bar.

- line 240-241.  "only infinitely approach the equilibrium instead of reaching it"  --> "reach the equilibrium only after infinite time".

- line 249.  "by plotting, we obtain Figure 6, we can see" --> "Figure 6 shows"

- Figure 6.  You need a title for the legend so the reader knows that you are referring to, i.e., p.

- Figure 7, and the associated discussion relating to "time to advantage" in the text.  This is _not_ clearly explained.  We need to go through this together and revise so that I can understand this when I read it.  We need to look at all of section 2.2.3, which starts on line 227 and goes to line 277.

- line 281.  You are misusing the term "technology" often.  Here "practice" would work.

- line 282.   I don't understand this line.

- line 285.  Say _why_.

- line 293.  I have no idea what you mean by "strategic evolvement".

- Figure 10.  You need to mark `1/R0` in the graph.
Also, the legend makes no sense to me here.

- line 316.  You have to say here that you assumed `p=1` in the above but that other value of `p` need to be investigated.

- line 336.  "let" --> "set"

- line 354.  You don't mean equatoin 53a.  You must have screwed up the equation labelling.

- line 363.  That implies that we always expect the EE to be _unstable_.  Does that make sense?

- line 375.  What does this model predict if the EE is unstable?

- line 377.  What does "custom" mean here?

- line 379.  What previous study?  You _must_ cite references!

# 3 Model: Intentionally infect susceptibles

- Figure 12-15 would be much better as a single four-panel figure.

- line 455.  Don't begin a new paragraph in the middle of a sentence.  You should not have  blank lines before or after equations.

- line 499.  Replace this sentence with "Thus, for any $\eta > 0$, we can conclude that the EE is locally asymptotically stable regardless of the values of the other parameters."

- lines 508-509.   Add a comment explaining why this makes sense.

- Figures 17 and 18.  You need an `x` axis label.

- lines 513-516.  I don't think I'm following your logic here.  We should talk about this paragraph and rewrite it together so that I can follow.  I will then probably want to rephrase the comments that follow in section 3.2.5 slightly.

# 4 Conclusion

- lines 524-525.  This makes no sense.  I have no idea what you are thinking.

- line 527.  Never say "Nevertheless however".  Only one of these two words can be used at the start of a sentence.

- line 542.  You don't need this information to determine mathematically whether or not obtaining such information could alter your conclusions in a significant way.  This sentence needs to be revised.   You could list this kind of investigation as something to do in future work.

- line 546.  The goal will not be to show intentional infection if more effective (you don't know that).  The goal will be to investigate whether it is more effective.

# Overall comments

- The quality of the writing is very poor.   This is not something that can be solved before you submit this finally, but you should really consider taking some English writing courses to improve your written communication skills.  This will help you a lot in life.

- Most of the conclusions are based on linear stability analyses.  It would be much better to investigate global stability as well.  This could be done quickly numerically by plotting the phase portrait for a bunch of initial conditions.  A rigorous proof would take more time and effort.



