"""
Differentiation
"""
function Δ(X,k,dt)
    return (X[:,k] - X[:, k-1])/dt
end


"""
Linspace
"""
function linspace(a,b,n)
    return [collect(range(a, stop=b, length=n))]
end


function linearpath(point_start, point_end, TotalPoint)
    
    initpath = point_start*ones(1,TotalPoint +1) 

    for i in 1:size(initpath)[2]
        step = (point_end - point_start)*i/size(initpath)[2]
        initpath[:,i] = initpath[:,i] + step
    end
    return initpath
end