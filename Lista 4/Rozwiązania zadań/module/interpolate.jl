# Lista 4, moduł interpolate.jl
# Paweł Narolski, 236685

module Interpolate
using Plots
gr()

export ilorazyRoznicowe
export warNewton
export rysujNnfx
export naturalna

"""
Oblicza ilorazy różnicowe na podstawie podanego wektora węzłów oraz wartości funkcji bez użycia tablicy dwuwymiarowej.
Wejście
    x - wektor składający się z węzłów x0, ..., xn długości n+1
    f - wektor składający się z wartości interpolowanej funkcji w węzłach f(x0), ..., f(xn) długości n+1
Zwraca
    fdiff - wektor zawierający obliczone ilorazy różnicowe długości n+1
"""
function ilorazyRoznicowe(x::Vector{Float64}, f::Vector{Float64})

    n = length(f)
    fdiff = Vector{Float64}(n)

    for i = 1:n
        fdiff[i] = f[i]
    end

    # Calculates the differential quotients
    for i = 2:n
        for j = n:-1:i
            fdiff[j] = (fdiff[j] - fdiff[j-1]) / (x[j] - x[j - i + 1])
        end
    end

    return fdiff
end

"""
Calculates the value of polynomial in a given point in Newton's form using the Horner's algorithm.
Input:
    a - vector with nodes
    fdiff - vector of differential quotients
    x - point where we are calculating the values
Returns
    nt - value of polynomial in t
"""
function warNewton(a::Vector{Float64}, fdiff::Vector{Float64}, x::Float64)
    n = length(fdiff)
    nt = fdiff[n]

    for i = n-1:-1:1
        nt = fdiff[i] + (x - a[i]) * nt
    end

    return nt
end

"""
Calculates the coefficients of the Newton's polynomial given in its' natural form.
    a - vector of nodes
    fdiff - vector of differential quotients
Returns
    coeff - vector of coefficients
"""
function naturalna(a::Vector{Float64}, fdiff::Vector{Float64})
    n = length(fdiff)
    coeff = Vector{Float64}(n)
    coeff[n] = fdiff[n]

    for i = n-1:-1:1
        # TODO: CHANGE
        p = coeff[i+1] * a[i]
        coeff[i] = fdiff[i] - p

        for k = i+1:n-1
            # TODO: CHANGE
            p = coeff[k+1] * a[i]
            coeff[k] = coeff[k] - p
        end
    end

    return coeff
end

"""
Interpolates the given function in range [a, b] using the Newton's  polynomial and returns the plot of both the function and polynomial.
Parameters:
    f - function
    a, b - range
    n - degree of polynomial
"""
function rysujNnfx(f, a::Float64, b::Float64, n::Int)
    # Calculate the distance between nodes
    distance = (b - a) / n;

    # Used to calculate the value of f in interpolation nodes
    x = Array{Float64}(n + 1)
    y = Array{Float64}(n + 1)

    # Calculate the value of f in interpolation nodes
    for i = 1:n+1
        x[i] = a + (i-1) * distance
        y[i] = f(x[i]);
    end

    # Calculates the differential quotients
    fdiff = ilorazyRoznicowe(x, y)

    # Number of points to draw in order to maintain accuracy
    number_of_points = 101;
    acc_dist = (b - a) / (number_of_points-1)

    # fx - function values, wx - interpolation polynomial values
    fx_values = Array{Float64}(number_of_points)
    wx_results = Array{Float64}(number_of_points)

    for i=1:number_of_points
        t = a + (i-1) * acc_dist
        fx_values[i] = f(t)
        wx_results[i] = warNewton(x, fdiff , t)
    end

    plot(linspace(a, b, number_of_points), fx_values, color ="red", label = "f(x)")
    plot!(linspace(a, b, number_of_points), wx_results, color ="blue", label="w(x)")
    savefig("plot_$a$b$n.png")
end

end
