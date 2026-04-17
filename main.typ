// Set document properties.
#set page(paper: "us-letter")
#set heading(numbering: "1.")
#set math.equation(numbering: "(1)")
// #show math.equation.where(block: true): set align(left)

// Notes
/*
Three core modes: markup, code initiated by #, and math initiated by $ $.

If the math expression inside the $ $ delimiters is surrounded by spaces then the expression is typeset in display (block) mode.
Otherwise, the expression is typeset in line mode.

The @preview namespace on the import statement refers to the namespace for community contributed packages.

Labels are enclosed in angle brackets, e.g. <sec:my_section>, and referenced using the @ notation, e.g. @sec:my_section.

The show statement works like a CSS rule with a selector followed by styling.
The show keyword followed by a selector and style are called a show rule.
A show rule with a blank selector applies the styling every element in the document from the point of invocation.
When a function is used as a show rule style, it is applied to each matching element, in a manner analogous to the visitor pattern.

The let statement allows you to introduce a variable and assign a value to it or define a function.

Content may be placed in square brackets following a function call. This construct is called a trailing content block.

*/

// Imports
#import "@preview/theorion:0.3.3":*

// Apply the show-theorion function to all elements in the document.
#show : show-theorion

#let title = [A detailed explanation of Euler's solution to the Basel problem]
#align(center, text(18pt)[#title])

// Contents if I need it later.
// #outline()

// #align(horizon, heading(numbering: none)[Abstract])

// Style the abstract heading.
#show <sec:abstract>: set heading(numbering: none)
#show <sec:abstract>: set align(horizon)


= Abstract <sec:abstract>
This paper gives a detailed account of Euler's proof of the statement posed in the Basel problem.

#pagebreak()

= Introduction

The Basel problem, originally posed by Italian mathematician Pietro Mengoli in his _Novae quadraturae arithmeticae_, published in 1650,
asks for the value of the sum of the reciprocals of the squares of the natural numbers:

$ sum_(n=1)^oo 1/n^2 $

In 1734, Euler in his paper _De summis serierum reciprocarum_, showed that the series is equal to $pi^2/6$.

Why is this sum interesting? Well, the harmonic series $sum_(n=1)^oo 1/n$ diverges, but very slowly.
All smaller series converge and all larger ones diverge, so the harmonic series can be viewed as the boundary between convergence and divergence.
The sum in the Basel problem, i.e. the sum of reciprocal squares, is essentially an integer step smaller than the harmonic series.
On it's face, the sum of reciprocal squares seems straightforward to compute, but as we have seen,
the Basel problem remained unsolved for over eighty years.
It stood as a long term challenge and it's solution is considered a significant result in number theory.

#pagebreak()

= Proof

The theorem to be proven is:

#theorem(title: "Basel Problem")[$ sum_(n=1)^oo 1/n^2 = pi^2/6 $]<thm:basel_problem>

The $sin$ function can be formally defined analytically as a Maclaurin series:

$ sin x = x - x^3/3! + x^5/5! - x^7/7! + #sym.dots.h.c $ <eq:maclaurin_series_for_sin>

A polynomial function can be expressed as the product of a constant, a finite number of real linear factors, and a finite number of irreducible real quadratics.
The irreducible real quadratics appear when the polynomial has one or more non-real complex roots.
If the polynomial has all real roots, then it can be expressed as the product of a constant and a finite number real linear factors only. \
For example, the polynomial function $f(x) = 2x^2 - 14x + 24$, which has real roots 3 and 4, may be expressed as $f(x) = 2(x-3)(x-4)$.
In the polynomial case, the constant is simply the leading coefficient, i.e. the coefficient of the highest degree term.
In the case of a power series, since there are infinitely many terms, there is no highest degree term and thus no leading coefficient.
However, the constant is still part of the factorization; it just has to be determined independently.

Since the Maclaurin series for $sin$ is a power series, essentially an _infinite polynomial_, Euler reasoned that it could be
expressed as the product of a constant and infinitely many linear factors.
This step was initially thought to be unjustified, but was later confirmed to be sound with the appearance Weierstrass's factorization theorem.\

Since $sin x$ is zero _only_ at $x=0, plus.minus pi, plus.minus 2pi, plus.minus 3pi, #sym.dots$, these values are the roots of the Maclaurin series.
Note that since the roots have the form $plus.minus k pi$ for all $k in NN$ and are thus all real,
the series can be expressed as the product of a constant $c$ and real linear factors of the form $(x plus.minus k pi)$.

$ sin x = c (x-0)(x-pi)(x+pi)(x-2pi)(x+2pi)(x-3pi)(x+3pi) #sym.dots.h.c $
$ sin x = c x(x-pi)(x+pi)(x-2pi)(x+2pi)(x-3pi)(x+3pi) #sym.dots.h.c $
$ (sin x)/x = c (x-pi)(x+pi)(x-2pi)(x+2pi)(x-3pi)(x+3pi) #sym.dots.h.c $
$ (sin x)/x = c (x^2 - pi^2)(x^2 - 4pi^2)(x^2 - 9pi^2 ) #sym.dots.h.c wide "Difference of squares" $ <eq:diff_of_squares>

The next step is to determine the value of the constant $c$.\
Now, $(sin x)/x$ is undefined at $x=0$, but we can take the limit of both sides as x goes to zero:

$ lim_(x->0) (sin x)/x = lim_(x->0) c (x^2 - pi^2)(x^2 - 4pi^2)(x^2 - 9pi^2 ) #sym.dots.h.c $

The limit of the left side is simply 1, i.e. $lim_(x->0) (sin x)/x = 1$, which can be verified through a simple application of L'Hospital.
Thus, we have:

$ 1 = c (- pi^2)(- 4pi^2)(- 9pi^2) #sym.dots.h.c $
$ c = 1 / ((- pi^2)(- 4pi^2)(- 9pi^2) #sym.dots.h.c) $
$ c = (1 / (- pi^2)) (1 / (- 4pi^2)) (1 / (- 9pi^2)) #sym.dots.h.c $

#pagebreak()

Pairing each factor of $c$ with its matching difference of squares factor from @eq:diff_of_squares, we get:

$ (sin x)/x = (1 / (- pi^2))(x^2 - pi^2) (1 / (- 4pi^2))(x^2 - 4pi^2) (1 / (- 9pi^2))(x^2 - 9pi^2 ) #sym.dots.h.c $
$ (sin x)/x = (1-x^2/(pi^2)) (1-x^2/(4pi^2)) (1-x^2/(9pi^2)) #sym.dots.h.c $ <eq:weierstrass>

As a brief aside, we should note that @eq:weierstrass is essentially equivalent to Weierstrass's factorization of $sin x$.

$ sin x = x product_(n=1)^oo [1-x^2/(n^2 pi^2)] wide "Weierstrass factorization" $

Indeed, we could have used Weierstrass as our starting point for the proof.
However, since we are following Euler's development of the argument, we chose to begin with the Maclaurin series.

If we progressively FOIL a number of factors of the infinite product on the right-hand side of @eq:weierstrass from left to right we get:

$ (1-x^2/(pi^2)) (1-x^2/(4pi^2)) (1-x^2/(9pi^2)) $
$ (1-x^2/(pi^2) - x^2/(4pi^2) + x^4/(4pi^4)) (1-x^2/(9pi^2)) $
$ (1-x^2/(pi^2) - x^2/(4pi^2) + x^4/(4pi^4) - x^2/(9pi^2) + x^4/(9pi^4) + x^4/(36pi^4) - x^6/(36pi^6)) $

We can regroup this expression so that the matching terms are adjacent.

$ 1-x^2/(pi^2) - x^2/(4pi^2) - x^2/(9pi^2) + x^4/(4pi^4) + x^4/(9pi^4) + x^4/(36pi^4) - x^6/(36pi^6) $
$ 1 - (x^2/(pi^2) + x^2/(4pi^2) + x^2/(9pi^2)) + (x^4/(4pi^4) + x^4/(9pi^4) + x^4/(36pi^4)) - (x^6/(36pi^6)) $
$ 1 - x^2/pi^2(1/1 + 1/4 + 1/9) + x^4/pi^4(1/4 + 1/9 + 1/36) - x^6/pi^6(1/36) $

Continuing this process indefinitely, we end up with a sum of the form:

$
1 -
x^2/pi^2(1/1 + 1/4 + 1/9 + #sym.dots.h.c) +
x^4/pi^4(1/4 + 1/9 + 1/36 + #sym.dots.h.c) -
x^6/pi^6(1/36 + 1/49 + 1/64 + #sym.dots.h.c) +
#sym.dots.h.c
$

We'll set $S_2, S_4, "and" S_6$ equal to the sums in the $x^2, x^4, "and" x^6$ terms respectively.\
We'll set $C_2, C_4, "and" C_6$ equal to the coefficients of the $x^2, x^4, "and" x^6$ terms respectively,\
such that $C_2 = 1/pi^2 S_2, C_4 = 1/pi^4 S_6, "and" C_6 =  1/pi^6 S_6$.

#pagebreak()

The $S_2$ factor of the $C_2$ coefficient is the sum of reciprocal squares that we're aiming to compute.

$ S_2 = sum_(n=1)^oo 1/n^2 $

The $S_4$ and $S_6$ sums are more complicated, involving double and triple sums respectively,
but since $S_2$ is the sum we're interested in, we won't need these.

Rewriting the full expression using the coefficients $C_2, C_4, "and" C_6$ defined earlier, we have:

$
1 -
x^2 C_2 +
x^4 C_4 -
x^6 C_6 +
#sym.dots.h.c
$

This sum is equal to $(sin x)/x$, so we have:

$
(sin x)/x =
1 -
x^2 C_2 +
x^4 C_4 -
x^6 C_6 +
#sym.dots.h.c
$ <eq:sum_of_sums>

Recalling the Maclaurin series for sin from @eq:maclaurin_series_for_sin and dividing both sides by $x$ we get:

$ (sin x)/x = 1 - x^2/3! + x^4/5! - x^6/7! + #sym.dots.h.c $ <eq:maclaurin_series_for_sin_over_x>

Equating the coefficients of the $x^2$ terms from @eq:sum_of_sums and @eq:maclaurin_series_for_sin_over_x we get:

$ C_2 = 1/3! $

Rewriting $C_2$ and $S_2$, we get:

$ 1/pi^2 S_2 = 1/3! $
$ 1/pi^2 sum_(n=1)^oo 1/n^2 = 1/3! $
$ sum_(n=1)^oo 1/n^2 = pi^2/3! $

This concludes the proof.

= Using Euler's approach to prove a similar theorem

It is instructive to consider the previous approach applied to the $X^4$ terms in order to prove the following theorem:

#theorem(title: "Something else")[$ sum_(m=1)^oo sum_(n=m+1)^oo 1/(m^2n^2) = pi^4/120 $]<thm:sum_of_product_of_squares>


= Conclusion

We essentially equated the coefficients of specific terms from two different representations of the $(sin x)/x$ function.
