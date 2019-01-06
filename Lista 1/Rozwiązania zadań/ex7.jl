# Paweł Narolski
# 236685

"""
Defines the formula for our function
    f(x) = sin x + cos 3x
"""
function f(x)
    return sin(x) + cos(3x)
end

"""
Calculates the approximated value of the derivative of defined
    f(x)
in a given point
    x0
with provided parameter
    h
"""
function approximated_derivative(x, h)
    return (f(x + h) - f(x)) / h
end

"""
Calculates the value of the derivative of defined function
    f(x)
in a given point
    x0
"""
function derivative(x)
    return cos(x) - 3sin(3x)
end

"""
Calculates the error of the approximated value of a derivative.
"""
function err(approximated_derivative, derivative)
    return abs(derivative - approximated_derivative)
end

x = Float64(1)

for n in 0:54
    h = Float64(1/2)^n

    d = derivative(Float64(1.0))
    approx_d = approximated_derivative(Float64(1.0), h)
    e = err(d, approx_d)
    println("\{", n, "\} & ", approx_d, " & ", e, " & ", Float64(1) + h, " \\\\")
end
