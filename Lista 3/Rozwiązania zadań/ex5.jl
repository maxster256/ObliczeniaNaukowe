# Lista 3, zadanie 5.
# Paweł Narolski, 236685

# include("nonlinear.jl")
using nonlinear

f(x) = e^x - 3*x

# Bisection method
println("Bisection method:")
(r,v,it,err) = nonlinear.mbisekcji(f, 0.0, 1.0, 0.5*10^-5.0, 0.5*10^-5.0)
println("[0, 1] - r: $(r), v: $(v), it: $(it), err: $(err)")

(r,v,it,err) = nonlinear.mbisekcji(f, 1.0, 2.0, 0.5*10^-5.0, 0.5*10^-5.0)
println("[1, 2] - r: $(r), v: $(v), it: $(it), err: $(err)")
