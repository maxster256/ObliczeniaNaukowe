# Paweł Narolski
# 236685

"""
Finds the smallest number in Float64 arithmetic which incorrectly solves
the equation
    x * 1/x == 1
"""
function findfalsenum()
    iterations = 1
    x = 1 + eps(Float64)

    while Float64(x * Float64(1/x)) == 1
        x += eps(Float64)
        iterations += 1
    end

    println("Iterations: ", iterations)
    return x
end

print(findfalsenum())
