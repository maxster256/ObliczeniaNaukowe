# Paweł Narolski
# 236685

# Zadanie 6.
"""
Computes the f(x) = sqrt(x^2 + 1) - 1 in Float64 arithmetic
    x - parameter
"""
function compute_a(x)
    return Float64(sqrt(x^2 + 1) - 1)
end

"""
Computes the f(x) = x^2 / (sqrt(x^2 + 1) + 1) in Float64 arithmetic
    x - parameter
"""
function compute_b(x)
    return Float64(x^2 / (sqrt(x^2 + 1) + 1))
end

for i in 1:25
    x = Float64(1/8^i)
    println("\{", i, "\} \⁠& ", compute_a(x), " \& ", compute_b(x), " \\\\")
end
