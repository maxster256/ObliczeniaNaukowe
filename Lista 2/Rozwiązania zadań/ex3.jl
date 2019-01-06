# Lista 2, zadanie 3.
# Paweł Narolski, 236685

"""
Function generates the Hilbert matrix  A of size n,
A (i, j) = 1 / (i + j - 1)
Inputs:
	n: size of matrix A, n>=1
Usage: hilb (10)
(C) Paweł Zieliński
"""
function hilb(n::Int)
        if n < 1
         error("size n should be >= 1")
        end
        return [1 / (i + j - 1) for i in 1:n, j in 1:n]
end

"""
Function generates a random square matrix A of size n with
a given condition number c.
Inputs:
	n: size of matrix A, n>1
	c: condition of matrix A, c>= 1.0
Usage: matcond (10, 100.0)
(C) Paweł Zieliński
"""
function matcond(n::Int, c::Float64)
        if n < 2
         error("size n should be > 1")
        end
        if c< 1.0
         error("condition number  c of a matrix  should be >= 1.0")
        end
        (U,S,V)=svd(rand(n,n))
        return U*diagm(linspace(1.0,c,n))*V'
end

"""
Tests two different methods of calculating the result of Ax = b formula
for the generated Hilbert matrix:
        - gaussian elimination
        - inversion (x = A^(-1) * b)
where i is the size of the matrix
"""
function test_hilbert_matrix(i)
        A = hilb(i)
        x = ones(Float64, i)
        b = A * x

        result = A \ b
        inversed_result = inv(A) * b

        println("[$i x $i] matrix (cond: $(cond(A)), rank: $(rank(A)))")
        println("- Gaussian elimination relative error : $(norm(result - x) / norm(x))")
        println("- inv(A) * b relative error: $(norm(inversed_result - x) / norm(x))")
        # println("$i & $(norm(result - x) / norm(x)) & $(norm(inversed_result - x) / norm(x)) & $(cond(A)) \\\\")
end

"""
Tests two different methods of calculating the result of Ax = b formula
for the randomly-generated matrix
        - gaussian elimination
        - inversion (x = A^(-1) * b)
where n is the size of the matrix and c is cond() of the matrix
"""
function test_random_matrix(n, c)
        A = matcond(n, c)
        x = ones(Float64, n)
        b = A * x

        result = A \ b
        inversed_result = inv(A) * b

        println("[$n x $n] matrix (cond: c, rank: $(rank(A)))")
        println("- Gaussian elimination relative error : $(norm(result - x) / norm(x))")
        println("- inv(A) * b relative error: $(norm(inversed_result - x) / norm(x))")
        # println("$n & $(norm(result - x) / norm(x)) & $(norm(inversed_result - x) / norm(x)) & $c \\\\")
end

println("Test the Hilbert matrices: ")
for i in 1:20
        test_hilbert_matrix(i)
end

println("\nTest the randomly-generated matrices: ")
for n in [5, 10, 20]
        for c in [1.0, 10.0, 10.0^3, 10.0^7, 10.0^12, 10.0^16]
                test_random_matrix(n, c)
        end
end
