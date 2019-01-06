# Lista 3, zadanie 2.
# Paweł Narolski, 236685

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
