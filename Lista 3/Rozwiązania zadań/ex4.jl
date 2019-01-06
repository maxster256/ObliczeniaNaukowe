# Lista 3, zadanie 4.
# Paweł Narolski, 236685

include("nonlinear.jl")
using nonlinear

f(x) = sin(x) - (x/2)^2
pf(x) = cos(x) - x/2
maxit = 12

# Bisection method
println("Bisection method:")
(r,v,it,err) = nonlinear.mbisekcji(f, 1.5, 2.0, 0.5*10^-5.0, 0.5*10^-5.0)
println("r: $(r), v: $(v), it: $(it), err: $(err)")

# Newton's method
println("Newton's method:")
(r,v,it,err) = nonlinear.mstycznych(f, pf, 1.5, 0.5*10^-5.0, 0.5*10^-5.0, maxit)
println("r: $(r), v: $(v), it: $(it), err: $(err)")

# Secant method
println("Secant method:")
(r,v,it,err) = nonlinear.msiecznych(f, 1.0, 2.0, 0.5*10^-5.0, 0.5*10^-5.0, maxit)
println("r: $(r), v: $(v), it: $(it), err: $(err)")
