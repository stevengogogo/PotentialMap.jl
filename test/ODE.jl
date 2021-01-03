#=
Test function 

Reference
---------

=#

function ODE!(du,u,p,t)
    du[1]= -1 + 9 *u[1] - 2*u[1]^3 + 9 *u[2] - 2*u[2]^3;
    du[2]=  1 - 11*u[1] + 2*u[1]^3 + 11*u[2] - 2*u[2]^3;
end

u0 = [1.0, 2.0]
p_ = [2.0, 3.0]