# Lista 2, zadanie 1.
# Paweł Narolski, 236685

x1 = Float32[2.718281828, -3.141592654, 1.414213562, 0.5772156649, 0.3010299957]
y1 = Float32[1486.2497, 878366.9879, -22.37492, 4773714.647, 0.000185049]

x2 = Float64[2.718281828, -3.141592654, 1.414213562, 0.5772156649, 0.3010299957]
y2 = Float64[1486.2497, 878366.9879, -22.37492, 4773714.647, 0.000185049]

# Data with changed x4, x5 for comparison
x3 = Float32[2.718281828, -3.141592654, 1.414213562, 0.577215664, 0.301029995]
y3 = Float32[1486.2497, 878366.9879, -22.37492, 4773714.647, 0.000185049]

x4 = Float64[2.718281828, -3.141592654, 1.414213562, 0.577215664, 0.301029995]
y4 = Float64[1486.2497, 878366.9879, -22.37492, 4773714.647, 0.000185049]

"""
Calculates the scalar in normal order
"""
function a_scalar(x, y, n)
    sum = 0
    for i in 1:n
        sum += x[i] * y[i]
    end
    return sum
end

"""
Calcuates the scalar in reverse order
"""
function b_scalar(x, y, n)
    sum = 0
    for i in n:-1:1
        sum += x[i] * y[i]
    end
    return sum
end

"""
Calculates the scalar according to what's been said on the lecture:
- s1: add all the non-negative numbers from the largest to the smallest
- s2: add all the negative numbers from the smallest to the largest
- add s1 + s2
"""
function c_scalar(x, y, n, I)
    s1 = I[]
    s2 = I[]

    for i in 1:n
        # Calculate the partial sum
        partial = x[i] * y[i]

        # Move the result to positive or negative arrays accordingly to result
        if partial >= 0
            push!(s1, partial)
        else
            push!(s2, partial)
        end
    end

    # Sort arrays according to the instruction
    sort!(s1, rev=true)
    sort!(s2, rev=true)

    # Calculate partial sums and total sum
    partial_positive = 0
    partial_negative = 0

    for i in s1
        partial_positive += i
    end

    for i in s2
        partial_negative += i
    end

    result = partial_positive + partial_negative

    return result
end

"""
Calculates the scalar from the smallest to the largest
(previous method in reverse)
"""
function d_scalar(x, y, n, I)
    s1 = I[]
    s2 = I[]

    for i in 1:n
        # Calculate the partial sum
        partial = x[i] * y[i]

        # Move the result to positive or negative arrays accordingly to result
        if partial >= 0
            push!(s1, partial)
        else
            push!(s2, partial)
        end
    end

    # Sort arrays according to the instruction
    sort!(s1)
    sort!(s2)

    # Calculate partial sums and total sum
    partial_positive = 0
    partial_negative = 0

    for i in s1
        partial_positive += i
    end

    for i in s2
        partial_negative += i
    end

    result = partial_positive + partial_negative

    return result
end

"""
Performs tests for given vectors in a given precision.
    x, y - vectors
    n - length of vector
    I - precision (Float32, Float64)
"""
function perform_tests(x, y, n, I)
    println(a_scalar(x, y, n))
    println(b_scalar(x, y, n))
    println(c_scalar(x, y, n, I))
    println(d_scalar(x, y, n, I))
end

println("Tests for Float32 before changing values:")
perform_tests(x1, y1, 5, Float32)

println("Tests for Float32 after changing values:")
perform_tests(x3, y3, 5, Float32)

println("Tests for Float64 before changing values:")
perform_tests(x2, y2, 5, Float64)

println("Tests for Float64 after changing values:")
perform_tests(x4, y4, 5, Float64)
