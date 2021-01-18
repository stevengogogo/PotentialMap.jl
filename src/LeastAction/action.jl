
struct LeastActionResult
    path 
    lam # Least action energy
    res 
end


@with_kw struct curve_ind
    integral_func
    func! # ODE function (du, u,p, t)
    DiffusionMatrix
    dt 
    dim
    n_points
    p
    t = nothing # for ode: placeholder
end

function (self::curve_ind)(x)
    points = reshape(x, (self.dim, self.n_points) )

    intd = self.integral_func(points, self.func!, self.DiffusionMatrix, self.dt, self.p; t=self.t )
    return intd 
end

"""
Least Action Method

Arguements
----------
- `n_points` {Integer}: Number of time points 
- `tmax` {Float}: maximum time 
- `point_start` {Array}: initial variables
- `point_end` {Array}: final state 
- `ode!` {Function}: ODE function (non-allocation type) f(du,u,p,t)
- `p` {Array}: parameters `p` of `ode!`

Return
------
- `op` {Optim.MultivariateOptimizationResults} : keywords. `ls_success` (success of optimization). Use `Optim.minimizer` function to get the arg minimum.
"""
function action(n_points, tmax, point_start, point_end, ode!, p, Jacobian, DiffusionMatrix)

    dim = length(point_start)
    dt = tmax/n_points 

    # A straight line from A → B
    initpath = LeastAction.linearpath(point_start, point_end, n_points)
    init_vec = reshape(initpath, 1, :)

    # Function of curve integration
    curve_func = curve_ind(integral, ode!, DiffusionMatrix, dt, dim, n_points, p, nothing)
    g! = grad!(Jacobian, dt, dim, n_points)
    
    op = optimize(curve_func, g!, init_vec, ConjugateGradient())

    path = reshape(Optim.minimizer(op), size(initpath))
    lam = op.minimum

    return LeastActionResult(path, lam, op)

end

"""
Integration along the path
"""
function integral(points, func!, DiffusionMatrix, dt, p; t=nothing)
    dim = size(points)[1]
    integral = 0
    for k = 2: size(points)[end]
        du = get_dxdt(func!, points[:,k-1], p; t=nothing) 

        Tmp = Δ(points, k, dt) .- du #eq18.
        integral = integral + Tmp' * DiffusionMatrix(dim)^(-1) * Tmp * dt 
    end
    integral = integral/4


    return integral
end


"""
Gradient for optimzation
"""
struct grad!
    Jacobian
    dt 
    dim 
    N 
end

function (self::grad!)(G, x)
    x_ = reshape(x, self.dim, self.N)
    
    m_jac = self.Jacobian(self.dt, x_)

    G[:] = reshape(m_jac, size(x))
end