# Paweł Narolski
# 236685

"""
Checks the spacing of bits in given float arithmetic defined by delta.
    delta - the "distance" between each number
"""
function check_spacing(delta)
    for k in 1:10
        println("\\texttt{", bits(Float64(1 + k*delta)), "} \\\\")
    end
end

println("For [1, 2]:")
check_spacing(Float64((1/2)^(52)))

println("For [1/2, 1]:")
check_spacing(Float64((1/2)^(53)))

println("For [2, 4]:")
check_spacing(Float64((1/2)^(51)))
