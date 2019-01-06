# Paweł Narolski
# 236685

# Zadanie 1.
"""
Calculates the machine epsilon for given float arithmetic.
    I - arithmetic
"""
function calculate_macheps(I)
    macheps = 1

    while I(1.0 + macheps/2) > 1.0
        macheps = macheps/2
    end

    return macheps
end

println("macheps for Float16: ", calculate_macheps(Float16), " vs. ", eps(Float16))
println("macheps for Float32: ", calculate_macheps(Float32), " vs. ", eps(Float32))
println("macheps for Float64: ", calculate_macheps(Float64), " vs. ", eps(Float64))
