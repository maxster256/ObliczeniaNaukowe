# Lista 3, moduł.
# Paweł Narolski, 236685

module nonlinear
export mbisekcji

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
            return c, w, iterations, 0
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

"""
Solves the formula f(x) = 0 using the Newton method.
    f, pf - f(x) and f'(x) given as anonymous functions
    x0 - starting approximation
    delta, epsilon - accuracy of computations
    maxit - maximum number of iterations
"""
function mstycznych(f, pf, x0::Float64, delta::Float64, epsilon::Float64, maxit::Int)
    v = f(x0)

    # If value of f in x0 is close to zero, return
    if abs(v) < epsilon
        return x0, v, 0, 0
    end

    # If f' is close to zero, return
    if abs(pf(x0)) < epsilon
        return NaN, NaN, NaN, 2
    end

    for it = 1:maxit
        x1 = x0 - (v/pf(x0))    # Next approximation of the solution
        v = f(x1)               # f value in next approximation

        # "End" condition
        if (abs(x1 - x0) < delta || abs(v) < epsilon)
            return x1, v, it, 0
        end

        x0 = x1                 # Set the new starting point
    end

    # Return error if result was not acheived in maxit
    return NaN, NaN, NaN, 1
end

"""
Solves the formula f(x) = 0 using the secant method.
    f - f(x) and given as anonymous function
    x0, x1 - starting approximations
    delta, epsilon - accuracy of computations
    maxit - maximum number of iterations
"""
function msiecznych(f, x0::Float64, x1::Float64, delta::Float64, epsilon::Float64, maxit::Int)
    fx0 = f(x0)
    fx1 = f(x1)

    for it=1:maxit
        if abs(fx0) > abs(fx1)
            x0, x1, = x1, x0        # Perform swaps
            fx0, fx1 = fx1, fx0     # fx0 is greater than fx1
        end

        s = (x1 - x0)/(fx1 - fx0)
        x1 = x0
        fx1 = fx0
        x0 = x0 - (fx0 * s)         # new x0 where secant meets OX
        fx0 = f(x0)                 # value of f in new x0

        # "End" condition
        if (abs(x1 - x0) < delta || abs(fx0) < epsilon)
            return x0, fx0, it, 0
        end
    end

    # Error occurs if no result found in maxit
    return NaN, NaN, NaN, 1
end


end
