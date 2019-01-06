# Lista 3, zadanie 6.
# Paweł Narolski, 236685

include("nonlinear.jl")
using nonlinear

f(x) = exp(1-x) - 1
pf(x) = -exp(1-x)
g(x) = x * exp(-x)
pg(x) = -exp(-x) * (x-1)

d = 10.0^(-5)
e = 10.0^(-5)
maxit = 30

# Bisection method
println("Bisection method for f(x):")
(r,v,it,err) = nonlinear.mbisekcji(f, 0.0, 2.0, d, e)
println("\$[-0.0, 2.0]\$ & $(r) & $(v) & $(it) & $(err)\\")

(r,v,it,err) = nonlinear.mbisekcji(f, -4.0, 4.0, d, e)
println("\$[-4.0, 4.0]\$ & $(r) & $(v) & $(it) & $(err)\\")

(r,v,it,err) = nonlinear.mbisekcji(f, 0.0, 1.5, d, e)
println("\$[-0.0, 1.5]\$ & $(r) & $(v) & $(it) & $(err)\\")

(r,v,it,err) = nonlinear.mbisekcji(f, -1.5, 125.0, d, e)
println("\$[-1.5, 125.0]\$ & $(r) & $(v) & $(it) & $(err)\\")
# println("[-13.75, 225.0] - r: $(r), v: $(v), it: $(it), err: $(err)")

println("\nBisection method for g(x):")
(r,v,it,err) = nonlinear.mbisekcji(g, -0.5, 0.5, d, e)
println("\$[-0.5, 0.5]\$ & $(r) & $(v) & $(it) & $(err)\\\\")

(r,v,it,err) = nonlinear.mbisekcji(g, -0.5, 0.4, d, e)
println("\$[-0.5, 0.4]\$ & $(r) & $(v) & $(it) & $(err)\\\\")

(r,v,it,err) = nonlinear.mbisekcji(g, -1.0, 5.0, d, e)
println("\$[-1.0, 5.0]\$ & $(r) & $(v) & $(it) & $(err)\\\\")

(r,v,it,err) = nonlinear.mbisekcji(g, -42.7, 13.25, d, e)
println("\$[-42.7, 13.25]\$ & $(r) & $(v) & $(it) & $(err)\\\\")
# println("[-13.75, 225.0] - r: $(r), v: $(v), it: $(it), err: $(err)")

# Newton for f(x)
println("\nNewton's metod for f(x):")
(r,v,it,err) = nonlinear.mstycznych(f, pf, 0.99, d, e, maxit)
println("0.99 & $(r) & $(v) & $(it) & $(err)\\\\")

(r,v,it,err) = nonlinear.mstycznych(f, pf, 0.5, d, e, maxit)
println("0.5 & $(r) & $(v) & $(it) & $(err)\\\\")

(r,v,it,err) = nonlinear.mstycznych(f, pf, -1.0, d, e, maxit)
println("-1.0 & $(r) & $(v) & $(it) & $(err)\\\\")

(r,v,it,err) = nonlinear.mstycznych(f, pf, -10.0, d, e, maxit)
println("-10.0 & $(r) & $(v) & $(it) & $(err)\\\\")

(r,v,it,err) = nonlinear.mstycznych(f, pf, -2.0, d, e, maxit)
println("10.0 & $(r) & $(v) & $(it) & $(err)\\\\")

# Newton for g(x)
println("\nNewton's metod for g(x):")
(r,v,it,err) = nonlinear.mstycznych(g, pg, -0.01, d, e, maxit)
println("-0.01 & $(r) & $(v) & $(it) & $(err)\\\\")

(r,v,it,err) = nonlinear.mstycznych(g, pg, -1.0, d, e, maxit)
println("-1.0 & $(r) & $(v) & $(it) & $(err)\\\\")

(r,v,it,err) = nonlinear.mstycznych(g, pg, -10.0, d, e, maxit)
println("-10.0 & $(r) & $(v) & $(it) & $(err)\\\\")

(r,v,it,err) = nonlinear.mstycznych(g, pg, -25.0, d, e, maxit)
println("-25.0 & $(r) & $(v) & $(it) & $(err)\\\\")

(r,v,it,err) = nonlinear.mstycznych(g, pg, 0.1, d, e, maxit)
println("0.1 & $(r) & $(v) & $(it) & $(err)\\\\")

(r,v,it,err) = nonlinear.mstycznych(g, pg, 1.0, d, e, maxit)
println("1.0 & $(r) & $(v) & $(it) & $(err)\\\\")


# Secant for f(x)
println("'\nSecant metod for f(x):")
(r,v,it,err) = nonlinear.msiecznych(f, 0.8, 0.99, d, e, maxit)
println("0.8 & 0.99 & $(r) & $(v) & $(it) & $(err)\\\\")

(r,v,it,err) = nonlinear.msiecznych(f, 0.0, 0.5, d, e, maxit)
println("0.0 & 0.5 & $(r) & $(v) & $(it) & $(err)\\\\")

(r,v,it,err) = nonlinear.msiecznych(f, -1.0, -0.5, d, e, maxit)
println("-1.0 & -0.5 & $(r) & $(v) & $(it) & $(err)\\\\")

(r,v,it,err) = nonlinear.msiecznych(f, -10.0, -5.5, d, e, maxit)
println("-10.0 & -5.5 & $(r) & $(v) & $(it) & $(err)\\\\")

(r,v,it,err) = nonlinear.msiecznych(f, 2.0, 1.5, d, e, maxit)
println("2.0 & 1.5 & $(r) & $(v) & $(it) & $(err)\\\\")

(r,v,it,err) = nonlinear.msiecznych(f, 3.0, 3.1, d, e, maxit)
println("3.0 & 3.1 & $(r) & $(v) & $(it) & $(err)\\\\")

(r,v,it,err) = nonlinear.msiecznych(f, 3.0, 4.0, d, e, maxit)
println("3.0 & 4.0 & $(r) & $(v) & $(it) & $(err)\\\\")


# Secant for g(x)
println("'\nSecant metod for g(x):")
(r,v,it,err) = nonlinear.msiecznych(g, -0.1, -0.01, d, e, maxit)
println("-0.1 & -0.01 & $(r) & $(v) & $(it) & $(err)\\\\")

(r,v,it,err) = nonlinear.msiecznych(g, -1.0, -0.5, d, e, maxit)
println("-1.0 & -0.5 & $(r) & $(v) & $(it) & $(err)\\\\")

(r,v,it,err) = nonlinear.msiecznych(g, -1.0, -0.9, d, e, maxit)
println("-1.0 & -0.9 & $(r) & $(v) & $(it) & $(err)\\\\")

(r,v,it,err) = nonlinear.msiecznych(g, -10.0, -6.0, d, e, maxit)
println("-10.0 & -6.0 & $(r) & $(v) & $(it) & $(err)\\\\")

(r,v,it,err) = nonlinear.msiecznych(g, 0.0, 0.5, d, e, maxit)
println("0.0 & 0.5 & $(r) & $(v) & $(it) & $(err)\\\\")

(r,v,it,err) = nonlinear.msiecznych(g, 5.0, 10.0, d, e, maxit)
println("5.0 & 10.0 & $(r) & $(v) & $(it) & $(err)\\\\")

(r,v,it,err) = nonlinear.msiecznych(g, 132.5, 132.25, d, e, maxit)
println("132.5 & 132.25 & $(r) & $(v) & $(it) & $(err)\\\\")
