
struct GradFunc
    VecOfEq
    Variables 
    dt
end

function (self::GradFunc)(dt, X)
    vars = Dict()
    for i in eachindex(self.Variables)
        vars[self.Variables[i]] = X[i]
    end
    vars[self.dt] = dt 
    @show vars
    expr =  [ModelingToolkit.substitute(i, vars) for i in self.VecOfEq]
    val = ModelingToolkit.expand_derivatives.(expr)
    
    return val
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

   
    ret = ModelingToolkit.gradient(S, collect(Iterators.flatten(X)) )

    ret = ModelingToolkit.simplify(ret)
    ret=reshape(ret,dim,:) # Matrix


    return GradFunc(ret, X, dt)
end


function get_dxdt(ODE!, x, p; t=nothing)
    dx = deepcopy(x)
    ODE!(dx, x, p, t)
    return dx
end

"""
Differentiation
"""
function Δ(X,k,dt)
    return (X[:,k] - X[:, k-1])/dt
end