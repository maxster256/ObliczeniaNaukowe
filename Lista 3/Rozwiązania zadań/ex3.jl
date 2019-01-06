# Lista 3, zadanie 3.
# Paweł Narolski, 236685

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

    for it = 1:maxit
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
