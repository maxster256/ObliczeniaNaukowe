# Lista 4, zadanie 2.
# Paweł Narolski, 236685

"""
Calculates the value of polynomial in a given point in Newton's form using the Horner's algorithm.
Input:
    a - vector with nodes
    fdiff - vector of differential quotients
    x - point where we are calculating the values
Returns
    nt - value of polynomial in t
"""
function warNewton(a::Vector{Float64}, fdiff::Vector{Float64}, x::Float64)
    n = length(fdiff)
    nt = fdiff[n]

    for i = n-1:-1:1
        nt = fdiff[i] + (x - a[i]) * nt
    end

    return nt
end
