# Paweł Narolski
# 236685

# Zadanie 1b.
"""
Calculates the eta value for given float arithmetic.
    I - arithmetic
"""
function calculate_eta(I)
    eta = 1

    while I(eta/2) > 0
        eta = eta/2
    end

    return eta
end

println("eta for Float16: ", calculate_eta(Float16), " vs. ", nextfloat(Float16(0.0)))
println("eta for Float32: ", calculate_eta(Float32), " vs. ", nextfloat(Float32(0.0)))
println("eta for Float64: ", calculate_eta(Float64), " vs. ", nextfloat(Float64(0.0)))
