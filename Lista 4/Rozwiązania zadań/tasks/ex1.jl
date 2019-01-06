# Lista 4, zadanie 1.
# Paweł Narolski, 236685

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
