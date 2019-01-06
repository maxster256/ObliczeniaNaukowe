include("blocksys.jl")
include("matrixgen.jl")

using blocksys
using matrixgen

block_size = 4
sizes = [16, 10000, 50000]
gen_sizes = [60, 300, 1000, 5000, 25000]

function compare_all()
    for size in gen_sizes
        matrixgen.blockmat(size, block_size, 25.0, "generated/$(size)/A.txt")
        A, n, l = blocksys.load_matrix("generated/$(size)/A.txt")
        b = blocksys.compute_b(A, size, block_size)
        Ap, bp = deepcopy(A), deepcopy(b)
        Al, bl = deepcopy(A), deepcopy(b)
        Alu, blu = deepcopy(A), deepcopy(b)

        gauss = @timed blocksys.compute_gauss(A, b, n, l)
        pivoted = @timed blocksys.compute_pivoted_gauss(Ap, bp, n, l)
        lu = @timed blocksys.compute_LU(Al, bl, n, l)
        pivlu = @timed blocksys.compute_pivoted_LU(Alu, blu, n, l)

        # println("Size: $size | (t) Gauss $(gauss[2]) s | (mem) Gauss: $(gauss[3]/10^6) MB | (t) pivoted: $(pivoted[2]) s | (mem) pivoted: $(pivoted[3]/10^6) MB")
        # println("Size: $size | (t) Gauss $(lu[2]) s | (mem) Gauss: $(lu[3]/2^20) MB | (t) pivoted: $(pivlu[2]) s | (mem) pivoted: $(pivlu[3]/2^20) MB")

        println("$size & $(round(gauss[2], 6)) & $(round(gauss[3]/2^20, 2)) & $(round(pivoted[2], 6)) & $(round(pivoted[3]/2^20, 2)) & $(round(lu[2], 6)) & $(round(lu[3]/2^20, 2)) & $(round(pivlu[2], 6)) & $(round(pivlu[3]/2^20, 2)) \\\\")
    end

    for size in sizes
        # Tests on given matrices
        A, n, l = blocksys.load_matrix("tests/$(size)/A.txt")
        b = blocksys.load_vector("tests/$(size)/b.txt")
        Ap, bp = deepcopy(A), deepcopy(b)
        Al, bl = deepcopy(A), deepcopy(b)
        Alu, blu = deepcopy(A), deepcopy(b)

        gauss = @timed blocksys.compute_gauss(A, b, n, l)
        pivoted = @timed blocksys.compute_pivoted_gauss(Ap, bp, n, l)
        lu = @timed blocksys.compute_LU(Al, bl, n, l)
        pivlu = @timed blocksys.compute_pivoted_LU(Alu, blu, n, l)

        # println("Size: $size | (t) Gauss $(gauss[2]) s | (mem) Gauss: $(gauss[3]/2^20) MB | (t) pivoted: $(pivoted[2]) s | (mem) pivoted: $(pivoted[3]/2^20) MB")
        # println("Size: $size | (t) Gauss $(lu[2]) s | (mem) Gauss: $(lu[3]/2^20) MB | (t) pivoted: $(pivlu[2]) s | (mem) pivoted: $(pivlu[3]/2^20) MB")

        println("$size & $(round(gauss[2], 6)) & $(round(gauss[3]/2^20, 2)) & $(round(pivoted[2], 6)) & $(round(pivoted[3]/2^20, 2)) & $(round(lu[2], 6)) & $(round(lu[3]/2^20, 2)) & $(round(pivlu[2], 6)) & $(round(pivlu[3]/2^20, 2)) \\\\")
    end
end

function compare_gaussian()
    for size in sizes
        # Tests on given matrices
        A, n, l = blocksys.load_matrix("tests/$(size)/A.txt")
        b = blocksys.load_vector("tests/$(size)/b.txt")
        Ap, bp = deepcopy(A), deepcopy(b)
        Al, bl = deepcopy(A), deepcopy(b)
        Alu, blu = deepcopy(A), deepcopy(b)

        result = @timed \(A, b)

        gauss = @timed blocksys.compute_gauss(A, b, n, l)
        pivoted = @timed blocksys.compute_pivoted_gauss(Ap, bp, n, l)

        # println("Size: $size | (t) Gauss $(gauss[2]) s | (mem) Gauss: $(gauss[3]/2^20) MB | (t) pivoted: $(pivoted[2]) s | (mem) pivoted: $(pivoted[3]/2^20) MB")
        # println("Size: $size | (t) Gauss $(lu[2]) s | (mem) Gauss: $(lu[3]/2^20) MB | (t) pivoted: $(pivlu[2]) s | (mem) pivoted: $(pivlu[3]/2^20) MB")

        println("$size & $(round(result[2], 6)) & $(round(result[3]/2^20, 4)) & $(round(gauss[2], 6)) & $(round(gauss[3]/2^20, 4)) & $(round(pivoted[2], 6)) & $(round(pivoted[3]/2^20, 4)) \\\\")
    end

    for size in gen_sizes
        matrixgen.blockmat(size, block_size, 25.0, "generated/$(size)/A.txt")
        A, n, l = blocksys.load_matrix("generated/$(size)/A.txt")
        b = blocksys.compute_b(A, size, block_size)
        Ap, bp = deepcopy(A), deepcopy(b)

        result = @timed \(A, b)

        gauss = @timed blocksys.compute_gauss(A, b, n, l)
        pivoted = @timed blocksys.compute_pivoted_gauss(Ap, bp, n, l)

        println("$size & $(round(result[2], 6)) & $(round(result[3]/2^20, 4)) & $(round(gauss[2], 6)) & $(round(gauss[3]/2^20, 4)) & $(round(pivoted[2], 6)) & $(round(pivoted[3]/2^20, 4)) \\\\")
    end
end

function compare_lu()
    for size in sizes
        # Tests on given matrices
        A, n, l = blocksys.load_matrix("tests/$(size)/A.txt")
        b = blocksys.load_vector("tests/$(size)/b.txt")
        Ap, bp = deepcopy(A), deepcopy(b)
        Al, bl = deepcopy(A), deepcopy(b)

        result = @timed \(A, b)

        gauss = @timed blocksys.compute_LU(A, b, n, l)
        pivoted = @timed blocksys.compute_pivoted_LU(Ap, bp, n, l)

        # println("Size: $size | (t) Gauss $(gauss[2]) s | (mem) Gauss: $(gauss[3]/2^20) MB | (t) pivoted: $(pivoted[2]) s | (mem) pivoted: $(pivoted[3]/2^20) MB")
        # println("Size: $size | (t) Gauss $(lu[2]) s | (mem) Gauss: $(lu[3]/2^20) MB | (t) pivoted: $(pivlu[2]) s | (mem) pivoted: $(pivlu[3]/2^20) MB")

        println("$size & $(round(result[2], 6)) & $(round(result[3]/2^20, 4)) & $(round(gauss[2], 6)) & $(round(gauss[3]/2^20, 4)) & $(round(pivoted[2], 6)) & $(round(pivoted[3]/2^20, 4)) \\\\")
    end

    for size in gen_sizes
        matrixgen.blockmat(size, block_size, 25.0, "generated/$(size)/A.txt")
        A, n, l = blocksys.load_matrix("generated/$(size)/A.txt")
        b = blocksys.compute_b(A, size, block_size)
        Ap, bp = deepcopy(A), deepcopy(b)

        result = @timed \(A, b)

        gauss = @timed blocksys.compute_LU(A, b, n, l)
        pivoted = @timed blocksys.compute_pivoted_LU(Ap, bp, n, l)

        println("$size & $(round(result[2], 6)) & $(round(result[3]/2^20, 4)) & $(round(gauss[2], 6)) & $(round(gauss[3]/2^20, 4)) & $(round(pivoted[2], 6)) & $(round(pivoted[3]/2^20, 4)) \\\\")
    end
end

function compare_error()
    for size in sizes
        # Tests on given matrices
        A, n, l = blocksys.load_matrix("tests/$(size)/A.txt")
        b = blocksys.compute_b(A, n, l)
        x = ones(Float64, n)
        Ap, bp = deepcopy(A), deepcopy(b)

        result = @timed \(A, b)

        gauss = blocksys.compute_gauss(A, b, n, l)
        pivoted = blocksys.compute_pivoted_gauss(Ap, bp, n, l)

        println("$n & $(norm(x - result[1]) / norm(result[1])) & $(norm(x - gauss[1]) / norm(gauss[1])) & $(norm(x - pivoted[1]) / norm(pivoted[1])) \\\\")
    end
end

# compare_gaussian()
# compare()
# compare_lu()
compare_all()
