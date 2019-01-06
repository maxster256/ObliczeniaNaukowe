# Paweł Narolski
# 236685

# Zadanie 2.
"""
Calculates the Kahan equation for given float arithmetic.
    I - arithmetic
"""
function kahan(I)
    x = I(3)
    y = I(4/3)
    z = I(1)

    return I(x*(y - z) - z)
end

println("Kahan: ", kahan(Float16), " vs. ", eps(Float16))
println("Kahan: ", kahan(Float32), " vs. ", eps(Float32))
println("Kahan: ", kahan(Float64), " vs. ", eps(Float64))
