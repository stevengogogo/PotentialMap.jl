#=
Try optim in high dimension and matrix
=#
using Optim
using BenchmarkTools

function f(x)
    return (1.0 - x[1])^2 + 100.0 * (x[2] - x[1]^2)^2
end

function g!(G, x)
    G[1] = -2.0 * (1.0 - x[1]) - 400.0 * (x[2] - x[1]^2) * x[1]
    G[2] = 200.0 * (x[2] - x[1]^2)
end

function h!(H, x)
    H[1, 1] = 2.0 - 400.0 * x[2] + 1200.0 * x[1]^2
    H[1, 2] = -400.0 * x[1]
    H[2, 1] = -400.0 * x[1]
    H[2, 2] = 200.0
end

initial_x = zeros(2)

# 27μs
@btime Optim.minimizer(optimize(f, g!, h!, initial_x, BFGS()))
# 39μs
@btime Optim.minimizer(optimize(f,initial_x, BFGS()))
# 31μs
@btime Optim.minimizer(optimize(f, initial_x, BFGS(); autodiff = :forward))



