# Lista 3, zadanie 1.
# Paweł Narolski, 236685

"""
Solves the formula f(x) = 0 using the bisection method.
    f - f(x) given as anonymous function
    a, b - starting range
    delta, epsilon - accuracy of computations
"""
function mbisekcji(f, a::Float64, b::Float64, delta::Float64, epsilon::Float64)
    u = f(a)
    v = f(b)
    e = b - a

    iterations = 0

    # print("a=$a, b=$b, u=$u, v=$v")

    if sign(u) == sign(v)
        # If function does not change its' sign in [a, b] return error
        return NaN, NaN, NaN, 1
    end

    while e > epsilon
        iterations += 1

        e = e/2         # Half of the length of the interval
        c = a + e       # The middle point of the interval
        w = f(c)        # The value of f in middle of the interval

        # The "quit" condition
        if (abs(e) < delta || abs(w) < epsilon)
            return c, w, it, 0
        end

        if sign(w) != sign(u)
            b = c       # Set the computed middle as the end of new interval
            v = w
        else
            a = c       # Set the computed middle as the beginning
            u = w
        end
    end
end
