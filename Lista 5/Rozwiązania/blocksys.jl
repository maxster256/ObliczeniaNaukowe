# Lista 5
# blocksys module
# Paweł Narolski, 236685

__precompile__()

module blocksys
    """
    Creates a sparse matrix based on data given in the file.
        file - filename or path to file to read from
    """
    function load_matrix(file :: String)
        open(file) do f
            line = split(readline(f))

            # Read the size of matrix A
            n = parse(Int64, line[1])

            # Read the size of matrix Ak, Bk, Ck
            l = parse(Int64, line[2])

            # Declare empty sparse matrix of size n by n
            A = spzeros(Float64, n, n)

            while !eof(f)
                line = split(readline(f))

                # Read the indexes from file
                i = parse(Int64, line[1])
                j = parse(Int64, line[2])

                # Read the value for given indexes
                value = parse(Float64, line[3])
                A[i, j] = value
            end
            return A, n, l
        end
    end

    """
    Creates the right-side vector based on data in input file.
        file - filename or path to file from read from
    """
    function load_vector(file::String)
        open(file) do f
            line = readline(f)

            # Get the size of vector
            n = parse(Int64, line)

            # Create the vector's representation
            b = Vector{Float64}(n)

            # Store current index of vector
            i = 1

            while !eof(f)
                line = readline(f)
                b[i] = parse(Float64, line)
                i += 1
            end
            return b
        end
    end

	"""
	Computes right-side vector b, where b = Ax for given
		A - sparse matrix
		n - size of A
		l - size of block of A
	x = (1, ..., 1)^T
	Returns
		b - computed right-side vector
	"""
	function compute_b(A::SparseMatrixCSC{Float64, Int64}, n::Int64, l::Int64)
		# Identity matrix
		x = ones(Float64, n)

		# Stores computed right-side vector
		b = zeros(Float64, n)

		#  Number of blocks
		v = Int64(n / l)

		for block in 1 : v
			# Go through each of the blocks
			for i in (block - 1) * l + 1 : block * l
				# Stores value computed for each row of right-side vector
				sum = 0

				if block == 1
					for j in 1 : block * l
						sum += A[i, j] * x[j]
					end
				else
					for j in (block - 1) * l : block * l
						sum += A[i, j] * x[j]
					end
				end

				if block != v
					sum += A[i, i + l] * x[i + l]
				end

				b[i] = sum
			end
		end
		return b
	end

	"""
	Saves the computed solutions vector x to given path or filename:
		file - path or filename
		x - solutons vector x
		n - size of x
		write_err - true if needs to write relative error
	"""
	function save_results(file::String, x::Array{Float64}, n::Int64, write_err::Bool)
		open(file, "w") do f
			if write_err
				relative_err = norm(ones(n) - x) / norm(x)
				println(f, relative_err)
			end
			for index in 1 : n
				println(f, x[index])
			end
		end
	end

    """
    Performs the gaussian elimination for a given
        A - (sparse) matrix
        b - right-side vector
    where
        n - matrix size
        l - size of the block
    Returns
        X - upper-triangular matrix
    """
    function gauss(A::SparseMatrixCSC{Float64, Int64}, b::Vector{Float64}, n::Int64, l::Int64, LU::Bool)

        for pivot in 1 : n - 1
            # Calculate the indexes of last column and block where calculations should be performed for the sparse matrix
            last_col = min(pivot + l, n)
            last_row = Int(min(n, l + l * floor(pivot / l)))

            for block in pivot + 1 : last_row
                z = A[block, pivot] / A[pivot, pivot]

				if LU
					# Store the L matrix inside of A
					A[block, pivot] = z
				else
					# Zero out values under diagonal
					A[block, pivot] = 0
				end

                for col in pivot + 1 : last_col
                    A[block, col] -= z * A[pivot, col]
                end

                # NOTE: Kincaid p. 166
				if !LU
					# Transform the right-side vector
                	b[block] -= z * b[pivot]
				end
            end
        end
    end

	"""
	Solves the Ax = b equation for a given
		A - upper-triangular matrix received after performing the gaussian elimination
		b - right-side vector
	where
		n - matrix size
		l - size of the block
	returns
		x - solutions vector
	"""
	function solve_ut(A::SparseMatrixCSC{Float64, Int64}, b::Vector{Float64}, n::Int64, l::Int64)
		# Solves the received upper-triangular matrix
        x = zeros(n)

        for block in n : -1 : 1
            sum = 0
            last_col = min(n, block + l)

            for col in block + 1 : last_col
                sum += A[block, col] * x[col]
            end

            x[block] = (b[block] - sum) / A[block, block]
        end

        return x
	end

	function solve_lt(A::SparseMatrixCSC{Float64, Int64}, b::Vector{Float64}, n::Int64, l::Int64)
		x = zeros(n)

		for i in 1 : n
			sum = 0

			for j in Int(max(1, floor((i - 1) / l) * l)) : i - 1
				sum += A[i, j] * x[j]
			end

			x[i] = (b[i] - sum) / A[i, i]
		end
		return x
	end

	"""
	Computes the result of Ax = b equation for a given
		A - sparse matrix
		b - right-side vector
		n - size of A
		l - size of block of A
	using the gaussian elimination method.
	Returns
		x - vector of solutions.
	"""
	function compute_gauss(A::SparseMatrixCSC{Float64, Int64}, b::Vector{Float64}, n::Int64, l::Int64)
		# Perform gaussian elimination
		gauss(A, b, n, l, false)

		# Solve the Ax = b equation for upper-triangular form of A matrix received after gaussian elimination
		return solve_ut(A, b, n, l)
	end

    """
    Performs the pivoted gaussian elimination for a given
        A - (sparse) matrix
        b - right-side vector
    where
        n - matrix size
        l - size of the block
		LU - True if performing LU decomposition
    Returns
        X - upper-triangular matrix
    """
    function pivoted_gauss(A::SparseMatrixCSC{Float64, Int64}, b::Vector{Float64}, n::Int64, l::Int64, LU::Bool)
        # Declares the permutation vector storing the position of block in matrix (used instead of performing swaps)
        perm = collect(1 : n)

        for pivot in 1 : n - 1

            last_row = Int(min(l + l * floor(pivot / l), n))
			last_col = Int(min(2 * l + l * floor(pivot / l), n))

            for block in pivot + 1 : last_row
				# Find the max value in the column
				max_index = pivot
				max = abs(A[perm[pivot], pivot])

				for i in block : last_row
					abs_val = abs(A[perm[i], pivot])

					if abs_val > max
						# Save the new maximum
						max_index, max = i, abs_val
					end
				end

				# Perform the swap of chosen "main element"
				perm[pivot], perm[max_index] = perm[max_index], perm[pivot]

				# Compute the value of elimination multiplier
				z = A[perm[block], pivot] / A[perm[pivot], pivot]

				if LU
					# Store the values of L matrix inside of A
					A[perm[block], pivot] = z
				else
					# If we're just performing the gaussian elimination, zero out values
					A[perm[block], pivot] = 0
				end

				for col in pivot + 1 : last_col
					# Perform the reduction
					A[perm[block], col] -= z * A[perm[pivot], col]
				end


				if !LU
					# Transform the right-side vector
					b[perm[block]] -= z * b[perm[pivot]]
				end
			end
		end
		if LU
			# Return the permutation vector used for solving the equation
			return perm
		end
	end

	"""
	Computes the result of Ax = b equation for a given
		A - sparse matrix
		b - right-side vector
		n - size of A
		l - size of block of A
	using the pivoted gaussian elimination method.
	Returns
		x - vector of solutions.
	"""
	function compute_pivoted_gauss(A::SparseMatrixCSC{Float64, Int64}, b::Vector{Float64}, n::Int64, l::Int64)
		# Perform gaussian elimination
		pivoted_gauss(A, b, n, l, false)

		# Solve the Ax = b equation for upper-triangular form of A matrix received after gaussian elimination
		return solve_ut(A, b, n, l)
	end

	"""
	Performs the LU decompositon of given
		A - matrix on which to perform the decomposition
		b - right-side vector
	where
		n - size of A
		l - size of the block of A
	Returns
		A - after LU decomposition.
	"""
	function LU(A::SparseMatrixCSC{Float64, Int64}, b::Vector{Float64}, n::Int64, l::Int64)
		# Perform gaussian elimination without solving the upper-triangular matrix
		return gauss(A, b, n, l, true)
	end

	"""
	Performs the pivoted LU decompositon of given
		A - matrix on which to perform the decomposition
		b - right-side vector
	where
		n - size of A
		l - size of the block of A
	Returns
		A - after LU decomposition.
	"""
	function pivoted_LU(A::SparseMatrixCSC{Float64, Int64}, b::Vector{Float64}, n::Int64, l::Int64)
		# Perform gaussian elimination without solving the upper-triangular matrix
		return pivoted_gauss(A, b, n, l, true)
	end

	"""
	Solves the Ax = b equation using the previously computed LU breakdown.
		A - combined L and U matrices
		b - right-side vector
		n - size of A
		l - size of block of A
	Returns
		x - vector of results of Ax = b equation
	"""
	function solve_LU(A::SparseMatrixCSC{Float64, Int64}, b::Vector{Float64}, n::Int64, l::Int64)
		# Perform the forward substitution
		y = solve_lt(A, b, n, l)
		# Perform the backward substitution
		x = solve_ut(A, b, n, l)

		return x
	end

	"""
	Solves the Ax = b equation using the previously computed pivoted LU breakdown.
		A - combined L and U matrices
		b - right-side vector
		n - size of A
		l - size of block of A
	Returns
		x - vector of results of Ax = b equation
	"""
	function solve_pivoted_LU(A::SparseMatrixCSC{Float64, Int64}, b::Vector{Float64}, n::Int64, l::Int64, perm)
		bperm = zeros(n)
		for i in 1 : n
			bperm[i] = b[perm[i]]
		end

		# Perform the forward substitution
		y = solve_lt(A, bperm, n, l)
		# Perform the backward substitution
		# TODO: CHECK IF B OR BPERM
		x = solve_ut(A, b, n, l)

		return x
	end

	"""
	Performs the LU decomposition of
		A - sparse matrix
	and computes the solutions of Ax = b equation,
	where
		b - right-side vector
		n - size of A
		l - size of block of A
	Returns
		x - vector of solutions
	"""
	function compute_LU(A::SparseMatrixCSC{Float64, Int64}, b::Vector{Float64}, n::Int64, l::Int64)
		LU(A, b, n, l)
		return solve_LU(A, b, n, l)
	end

	"""
	Performs the pivoted LU decomposition of
		A - sparse matrix
	and computes the solutions of Ax = b equation,
	where
		b - right-side vector
		n - size of A
		l - size of block of A
	Returns
		x - vector of solutions
	"""
	function compute_pivoted_LU(A::SparseMatrixCSC{Float64, Int64}, b::Vector{Float64}, n::Int64, l::Int64)
		perm = pivoted_LU(A, b, n, l)
		return solve_pivoted_LU(A, b, n, l, perm)

	end

	"""
	Performs the gaussian elimination, solves Ax = b and saves results, where
		file - filename or path for the results to be saved to
		A - sparse matrix
		b - right-side vector
		n - size of A
		l - size of block of A
	"""
	function compute_save_gauss(file::String, A::SparseMatrixCSC{Float64, Int64}, b::Vector{Float64}, n::Int64, l::Int64, pivoted::Bool, save_error::Bool)
		result = NaN

		if !pivoted
			result = compute_gauss(A, b, n, l)
		else
			result = compute_pivoted_gauss(A, b, n, l)
		end

		save_results(file, result, n, save_error)
	end

	"""
	Performs the gaussian elimination, solves Ax = b and saves results, where
		file - filename or path for the results to be saved to
		A - sparse matrix
		n - size of A
		l - size of block of A
	"""
	function compute_save_gauss(file::String, A::SparseMatrixCSC{Float64, Int64}, n::Int64, l::Int64, pivoted::Bool, save_error::Bool)
		result = NaN
		b = compute_b(A, n, l)

		if !pivoted
			result = compute_gauss(A, b, n, l)
		else
			result = compute_pivoted_gauss(A, b, n, l)
		end

		save_results(file, result, n, save_error)
	end

	"""
	Performs the LU decomposition, solves Ax = b and saves results, where
		file - filename or path for the results to be saved to
		A - sparse matrix
		b - right-side vector
		n - size of A
		l - size of block of A
	"""
	function compute_save_lu(file::String, A::SparseMatrixCSC{Float64, Int64}, b::Vector{Float64}, n::Int64, l::Int64, pivoted::Bool, save_error::Bool)
		result = NaN

		if !pivoted
			result = compute_LU(A, b, n, l)
		else
			result = compute_pivoted_LU(A, b, n, l)
		end

		save_results(file, result, n, save_error)
	end

	"""
	Performs the LU decomposition, solves Ax = b and saves results, where
		file - filename or path for the results to be saved to
		A - sparse matrix
		n - size of A
		l - size of block of A
	"""
	function compute_save_lu(file::String, A::SparseMatrixCSC{Float64, Int64}, n::Int64, l::Int64, pivoted::Bool, save_error::Bool)
		result = NaN
		b = compute_b(A, n, l)

		if !pivoted
			result = compute_LU(A, b, n, l)
		else
			result = compute_pivoted_LU(A, b, n, l)
		end

		save_results(file, result, n, save_error)
	end

end
