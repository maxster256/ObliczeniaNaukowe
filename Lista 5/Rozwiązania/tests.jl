include("blocksys.jl")

using Base.Test
using blocksys

# Default test sizes
sizes = [16, 10000, 50000]

@testset "Features test for matrix $size" for size in sizes
    A, n, l = blocksys.load_matrix("tests/$(size)/A.txt")
    b = blocksys.load_vector("tests/$(size)/b.txt")

    @testset "Computing b from A" begin
        @test isapprox(blocksys.compute_b(A, n, l), b)
    end

    @testset "Gaussian elimination" begin
        @test isapprox(blocksys.compute_gauss(A, b, n, l), \(A, b))
    end

    @testset "Pivoted gaussian elimination" begin
        @test isapprox(blocksys.compute_pivoted_gauss(A, b, n, l), \(A, b))
    end

    @testset "LU" begin
        @test isapprox(blocksys.compute_LU(A, b, n, l), \(A, b))
    end

    @testset "Pivoted LU" begin
        @test isapprox(blocksys.compute_pivoted_LU(A, b, n, l), \(A, b))
    end
end
