# Lista 4, zadanie 4.
# Paweł Narolski, 236685

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
  x = Array(Float64, n + 1);
  y = Array(Float64, n + 1);

  # Calculate the value of f in interpolation nodes
  for i = 1:n+1
    x[i] = a + (i-1) * distance;
    y[i] = f(x[i]);
  end

  # Calculates the differential quotients
  fdiff = ilorazyRoznicowe(x, y);

  # Number of points to draw in order to maintain accuracy
  number_of_points = 101;
  acc_dist = (b - a) / (number_of_points-1);

  # fx - function values, wx - interpolation polynomial values
  fx_values = Array(Float64, number_of_points);
  wx_results = Array(Float64, number_of_points);

  for i=1:number_of_points
    t = a + (i-1) * acc_dist;
    fx_values[i] = f(t);
    wx_results[i] = warNewton(x, fdiff , t);
  end

  plot(linspace(a, b, number_of_points), fx_values, color ="red", label = "f(x)")
  plot!(linspace(a, b, number_of_points), wx_results, color ="blue", label="w(x)")
end
