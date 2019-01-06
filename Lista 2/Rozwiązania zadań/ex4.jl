# Lista 2, zadanie 4.
# Paweł Narolski, 236685

using Polynomials

# Coefficients of the polynomial
coeff = reverse(Float64[1, -210.0, 20615.0,-1256850.0,
      53327946.0,-1672280820.0, 40171771630.0, -756111184500.0,
      11310276995381.0, -135585182899530.0,
      1307535010540395.0,     -10142299865511450.0,
      63030812099294896.0,     -311333643161390640.0,
      1206647803780373360.0,     -3599979517947607200.0,
      8037811822645051776.0,      -12870931245150988800.0,
      13803759753640704000.0,      -8752948036761600000.0,
      2432902008176640000.0])

# Create the polynomial using defined coefficients
P = Poly(coeff)
roots_P = reverse(roots(P))

p = poly([1.0:20.0;])

println("Calculated roots of P(x): ", roots_P)

# for i in 1:20
#       println("$i & $(roots_P[i]) \\\\")
# end

for k in 1:20
      zk = roots_P[k]
      Pzk = abs(polyval(P, zk))
      pzk = abs(polyval(p, zk))
      n = abs(zk - k)

      # println("($k) |P(zk)| = $Pzk \t |p(zk)| = $pzk \t |zk - k| = $n ")
      println("$k & $zk & $Pzk & $pzk & $n \\\\")
end

# Replace the coefficient to the new value and update references
println("Coeff", coeff[20])

coeff[20] = Float64(-210.0 - (1/2)^(23))
P = Poly(coeff)
roots_P = reverse(roots(P))

println("Calculations for updated coefficient 19: ", coeff[20])

for k in 1:20
      zk = roots_P[k]
      Pzk = abs(polyval(P, zk))
      pzk = abs(polyval(p, zk))
      n = abs(zk - k)

      # println("($k) |P(zk)| = $Pzk \t |p(zk)| = $pzk \t |zk - k| = $n ")
      println("$k & $zk & $Pzk & $pzk & $n \\\\")
end
