"""
Arguement
---------
- `ODE`{Function}: ODE(du,u,p,t)
- `dim`{Integer}: Number of variables (`length of u`)
- `N` {Integer}: Sections of time intervals
"""
function gradient_gen(ODE, dim, N)
    N = N + 1

    @variables x[1:dim, 1:N]
    @parameter dt 

    S = 0

    for k in 2:N
        S = S+1/4*dt*()
    end


end

function Δ()