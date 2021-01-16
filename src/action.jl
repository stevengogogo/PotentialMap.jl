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
"""
function action(n_points, tmax, point_start, point_end, ode!, p, DiffusionMatrix)

    dim = length(point_start)
    dt = tmax/n_points 

    # A straight line from A → B
    initpath = linearpath(point_start, point_end, n_points)
    init_vec = reshape(initpath, 1, :)

    # Function of curve integration
    curve_func = curve_ind(integral, ode!, DiffusionMatrix, dt, dim, n_points, p, nothing)

    
    op = Optim.minimizer(optimize(curve_func, init_vec, BFGS(); autodiff = :forward))  

    return op

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
function grad(points, Jacobian, dt)

    return Jacobian(dt, points)
end