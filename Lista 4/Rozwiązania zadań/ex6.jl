# Lista 4, zadanie 6.
# Paweł Narolski, 236685

using Interpolate

# Draws the f(x) = abs(x)
rysujNnfx(x->abs(x), -1.0, 1.0, 5)
rysujNnfx(x->abs(x), -1.0, 1.0, 10)
rysujNnfx(x->abs(x), -1.0, 1.0, 15)

# Draws the g(x) = 1/(1 + x^2)
rysujNnfx(x->1/(1+x^2), -5.0, 5.0, 5)
rysujNnfx(x->1/(1+x^2), -5.0, 5.0, 10)
rysujNnfx(x->1/(1+x^2), -5.0, 5.0, 15)
