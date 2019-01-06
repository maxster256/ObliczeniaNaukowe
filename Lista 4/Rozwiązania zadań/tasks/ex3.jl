# Lista 4, zadanie 3.
# Paweł Narolski, 236685

"""
Calculates the coefficients of the Newton's polynomial given in its' natural form.
    a - vector of nodes
    fdiff - vector of differential quotients
Returns
    coeff - vector of coefficients
"""
function naturalna(a::Vector{Float64}, fdiff::Vector{Float64})
    n = length(fdiff)
    coeff = Vector{Float64}(n)
    coeff[n] = fdiff[n]

    for i = n-1:-1:1
        # TODO: CHANGE
        p = coeff[i+1] * a[i]
        coeff[i] = fdiff[i] - p

        for k = i+1:m-1
            # TODO: CHANGE
            p = coeff[k+1] * a[i]
            coeff[k] = coeff[k] - p
        end
    end

    return coeff
end
