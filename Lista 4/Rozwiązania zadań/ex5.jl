# Lista 4, zadanie 5.
# Paweł Narolski, 236685

using Interpolate

# Draws the f(x) = e^x
rysujNnfx(x->e^x, 0.0, 1.0, 5)
rysujNnfx(x->e^x, 0.0, 1.0, 10)
rysujNnfx(x->e^x, 0.0, 1.0, 15)

# Draws the g(x) = x^2sin(x)
rysujNnfx(x->(x^2)*sin(x), -1.0, 1.0, 5)
rysujNnfx(x->(x^2)*sin(x), -1.0, 1.0, 10)
rysujNnfx(x->(x^2)*sin(x), -1.0, 1.0, 15)
