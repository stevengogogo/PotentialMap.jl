"""
    Gradient function
"""
struct GradFunc
    function_arg
    S_func 
    dim
    N 
    len_arg 
end

function (self::GradFunc)(dt, X)
    return reshape(grad_func(dt,X, self.S_func), self.dim, self.N)  # Output gradient
end

"""
Arguement
---------
- `ODE`{Function}: ODE(du,u,p,t)
- `dim`{Integer}: Number of variables (`length of u`)
- `N` {Integer}: Sections of time intervals
"""
function gradient_gen(ODE!, p, dim, N)
    N = N + 1

    @variables X[1:dim, 1:N]
    @parameters dt 

    S = 0

    D = DiffusionMatrix(dim)

    for k in 2:N
        dxdt = get_dxdt(ODE!, X[:,k-1], p)
        S = S + (1/4)*dt* (Δ(X,k,dt) - dxdt)' * (D)^(-1) * (Δ(X,k,dt) - dxdt )
    end

    vecX =  collect(Iterators.flatten(X))
    vec = collect([dt, vecX...])
    S_func = build_function(S,vec, expression=Val{false}) # S_func( [dt Xs])
   

    return GradFunc(vec, S_func, dim, N, dim*N)
end


grad_func(dt,Xs, S_func) = ForwardDiff.gradient(S_func, [dt,Xs...])[2:end] # Index 1 is df/dt


function get_dxdt(ODE!, x, p; t=nothing)
    dx = deepcopy(x)
    ODE!(dx, x, p, t)
    return dx
end

