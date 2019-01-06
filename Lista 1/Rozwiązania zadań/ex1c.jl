# Paweł Narolski
# 236685

# Zadanie 1c.
"""
Calculates the maximum value for given float arithmetic.
    I - arithmetic
"""
function calculate_max(I)
    max = 1

    while !isinf(2*max)
        max = I(2*max)
    end

    max = I((2-eps(I))*max)
    return max
end

println("max for Float16: ", calculate_max(Float16), " vs. ", realmax(Float16))
println("max for Float32: ", calculate_max(Float32), " vs. ", realmax(Float32))
println("max for Float64: ", calculate_max(Float64), " vs. ", realmax(Float64))
