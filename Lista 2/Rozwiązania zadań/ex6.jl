# Lista 2, zadanie 6.
# Paweł Narolski, 236685

function log_squared_function(x, c, I)
    results = I[x]

    for n in 1:40
        x = I(x^(2.0) + c)
        push!(results, x)
    end

    return results
end

"""
Prints out the results of calculation for given
    - c
    - x0
"""
function res_for_data(c, x)

    result = log_squared_function(x, c, Float64)
    # println(result)
    println("\nResults for c = $c, x = $x")

    for value in result
        # println("c = $(c), x0 = $x, result = $value")
        println("$(c) & $x & $value \\\\")
    end
end

"""
Prints out the results of calculatons for pairs:
    - c = -2, x0 = 1.99999999999999
    - c = -1, x0 = 0.75
    - c = -1, x0 = 0.25
"""
function res_for_pairs()
    r1 = log_squared_function(1.99999999999999, -2, Float64)
    r2 = log_squared_function(0.75, -1, Float64)
    r3 = log_squared_function(0.25, -1, Float64)

    for i in 2:41
        println("$(i-1) & $(r1[i]) & $(r2[i]) & $(r3[i])")
    end
end

c = Float64[-2, -1]
x1 = Float64[1, 2, 1.99999999999999]
x2 = [1, -1, 0.75, 0.25]

# Print out the results for the desired pair of c, x0
res_for_data(-2, 1.99999999999999)

res_for_pairs()
