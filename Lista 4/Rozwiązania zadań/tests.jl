# Lista 4, testy
# Paweł Narolski, 236685

# Excercise 1
using Base.Test
using Interpolate

x1 = [3.0, 1.0, 5.0, 6.0]
f1 = [1.0, -3.0, 2.0, 4.0]
fdiff1 = [1.0, 2.0, -3.0/8.0, 7.0/40.0]

x2 = [-1.0, 0.0, 1.0, 2.0, 3.0]
f2 = [2.0, 1.0, 2.0, -7.0, 10.0]
fdiff2 = [2.0, -1.0, 1.0, -2.0, 2.0]

@testset "Differential quotients" begin
    @test isapprox(ilorazyRoznicowe(x1, f1), fdiff1)
    @test isapprox(ilorazyRoznicowe(x2, f2), fdiff2)
end

# Excercise 2
fdiff3 = ilorazyRoznicowe(x2, f2)

@testset "Newton's polynomial value" begin
    @test isapprox(warNewton(x2, fdiff3, 2.0), -7.0)
    @test isapprox(warNewton(x2, fdiff3, 10.0), 13961.0)
    @test isapprox(warNewton(x2, fdiff3, 5.0), 506.0)
    @test isapprox(warNewton(x2, fdiff3, -3.0), 298.0)
end

# Excercise 3
out = [3.0, 30.0, -8.0, -27.0, 10.0]
@testset "Coefficients of Newton polynomial's natural form" begin
    @test isapprox(naturalna(x2, f2), out)
end
