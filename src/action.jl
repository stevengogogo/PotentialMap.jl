function action(n_points, tmax, point_start, point_end, Function, Jacobian, DiffusionMatrix)

    dim = size(n_points)[1] 
    dt = tmax/n_points 

    # A straight line from A → B
    initpath = linearpath(point_start, point_end, n_points)




    
    return nothing

end

"""
Integration along the path
"""
function integral(points, func, DiffusionMatrix, dt, p; t=nothing)
    dim = size(points)[1]
    integral = 0
    for k = 2: size(points)[end]
        Tmp = Δ(points, k, dt) .- func(points[:, k-1],p,t ) #eq18.
        integral = integral + Tmp' * DiffusionMatrix(dim)^(-1) * Tmp * dt 
    end
    integral = integral/4


    return integral
end

function grad(points, Jacobian, dt)

    grad_ = [];
    for i in 2:size(points)[2]-1
        @show i
        gradTemp = Jacobian(dt, points[:, i-1:i+1])
        grad_ = [grad_ ,gradTemp[:,2]]
    end

    return grad_
end