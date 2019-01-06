using Interpolate
xi = [-1.0, 0.0, 1.0, 2.0]
fxi = [-1.0, 0.0, -1.0, 2.0]

ir = ilorazyRoznicowe(xi, fxi)
n = naturalna(xi, ir)

println("Obliczone ilorazy roznicowe: $(ir)")
println("Postac naturalna: $(n)")
