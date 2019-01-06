# Lista 2, zadanie 2.
# Paweł Narolski, 236685

using SymPy

x = Sym("x")
l = limit((e^x)*log(1+e^(-x)), x, oo)
print(l)
