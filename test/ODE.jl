#=
Test function 

Reference
---------

=#

function ODE!(dx,x,p,t)
    dx[1]= -1 + 9 *x[1] - 2*x[1]^3 + 9 *x[2] - 2*x[2]^3;
    dx[2]=  1 - 11*x[1] + 2*x[1]^3 + 11*x[2] - 2*x[2]^3;
end

u0 = [1.0, 2.0]
x = [2,.0, 3.0]