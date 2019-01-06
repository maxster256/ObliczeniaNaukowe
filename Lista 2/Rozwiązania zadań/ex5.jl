# Lista 2, zadanie 5.
# Paweł Narolski, 236685

function log_population_growth(p, r, I)
    results = I[p]

    for n in 1:40
        p += I(r * p * (1 - p))
        push!(results, p)
    end

    return results
end

function log_population_growth_modified(p, r, I)
    results = I[p]

    for n in 1:10
        p += I(r * p * (1 - p))
        push!(results, p)
        # println("n = $n, pn = $p")
    end

    # Leave only three numbers after digit
    p = trunc(p, 3)
    p += I(r * p * (1 - p))
    push!(results, p)

    for n in 12:40
        p += I(r * p * (1 - p))
        push!(results, p)
    end

    return results
end

p = Float32(0.01)
r = 3

normal_results = log_population_growth(p, r, Float32)
normal_results_64 = log_population_growth(Float64(0.01), r, Float64)
changed_results = log_population_growth_modified(p, r, Float32)

println(changed_results)

for i in 1:41
    # println("($i), $(normal_results[i]), $(changed_results[i])")
    println("$(i - 1) & $(changed_results[i]) & $(normal_results[i]) & $(normal_results_64[i])")
end
