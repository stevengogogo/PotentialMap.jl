#=
Test function 

Properties 
----------

- There are 9 steady states:
    - Stable
        - (-2.39,2.35)    (2.3,-2.34) (-2.18,-2.12)   (2.06,2.12) 
    - Unstable
        - (-2.27,-0.23)   (2.17,0.22) (-0.12,-2.23)   (0.33,2.22) (0.1,0.01)

Reference 
---------
1. Source code from https://static-content.springer.com/esm/art%3A10.1038%2Fs41598-017-15889-2/MediaObjects/41598_2017_15889_MOESM2_ESM.rar
=#

"""
Reference
---------
- `ODE.m`
"""
function ODE!(du,u,p,t)
    du[1]= -1 + 9 *u[1] - 2*u[1]^3 + 9 *u[2] - 2*u[2]^3;
    du[2]=  1 - 11*u[1] + 2*u[1]^3 + 11*u[2] - 2*u[2]^3;
end

u0 = [1.0, 2.0]
p_ = [2.0, 3.0]



"""
Reference
---------
- `exact_potential.m`
"""
function exact_potential(points, RefPointNum)
    pot = zeros(length(points), 1)
    for i in 1:length(points)
        x = points[i][1]; y = points[i][2];
        pot[i] = -5*(x^2+y^2)+(x^4+y^4)/2+x*y+x;
    end
    pot = pot .- pot[RefPointNum]
    return pot
end


"""
Reference
---------
- `Readme.pdf`
"""
ODE_features = Dict(
    "StableStates" => [ (-2.39,2.35),(2.3,-2.34), (-2.18,-2.12),   (2.06,2.12)  ],
    "UnstableStates" => [(-2.27,-0.23) ,  (2.17,0.22), (-0.12,-2.23),   (0.33,2.22), (0.1,0.01)],
    "SteadyStates" => [(-2.39,2.35),(2.3,-2.34), (-2.18,-2.12),   (2.06,2.12), (-2.27,-0.23) ,  (2.17,0.22), (-0.12,-2.23),   (0.33,2.22) ,(0.1,0.01)]
)