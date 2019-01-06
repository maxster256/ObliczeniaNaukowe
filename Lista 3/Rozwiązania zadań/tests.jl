# Lista 3, testy.
# Paweł Narolski, 236685

include("nonlinear.jl")
using nonlinear

f(x) = x^2 - 16
g(x) = x^4 - 16
pf(x) = 2*x
pg(x) = 4*(x^3)

delta = 10.0^-8.0
epsilon = 10.0^-8.0
maxit = 64

println("\nTesty dla f(x) = x^2 - 16")
println("-> delta: $delta, eps: $epsilon, max iteracji: $maxit")

println("Metoda bisekcji: ")
(r,v,it,err) = nonlinear.mbisekcji(f, 2.0, 5.5, delta, epsilon)
println("r = $(r), v = $(v), #iteracji: $(it), błąd: $(err)")

println("Metoda stycznych: ")
(r,v,it,err) = nonlinear.mstycznych(f, pf, 6.0, delta, epsilon, maxit)
println("r = $(r), v = $(v), #iteracji: $(it), błąd: $(err)")

println("Metoda siecznych: ")
(r,v,it,err) = nonlinear.msiecznych(f, 1.0, 5.0, delta, epsilon, maxit)
println("r = $(r), v = $(v), #iteracji: $(it), błąd: $(err)")

println("\nTesty dla g(x) = x^4 - 16")
println("-> delta: $delta, eps: $epsilon, max iteracji: $maxit")

println("Metoda bisekcji: ")
(r,v,it,err) = nonlinear.mbisekcji(g, 2.0, 5.5, delta, epsilon)
println("r = $(r), v = $(v), #iteracji: $(it), błąd: $(err)")

println("Metoda stycznych: ")
(r,v,it,err) = nonlinear.mstycznych(g, pg, 6.0, delta, epsilon, maxit)
println("r = $(r), v = $(v), #iteracji: $(it), błąd: $(err)")

println("Metoda siecznych: ")
(r,v,it,err) = nonlinear.msiecznych(g, 1.0, 5.0, delta, epsilon, maxit)
println("r = $(r), v = $(v), #iteracji: $(it), błąd: $(err)")
