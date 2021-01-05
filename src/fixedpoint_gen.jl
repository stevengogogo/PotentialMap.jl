"""
    fixedpoint_gen(func, u0, p, ranges; MaxIter=1000, UniqSpac=8)
    fixedpoint_gen(func, p, ranges; MaxIter=1000, UniqSpac=8)

Find steady states and categorized stability with Jacobian.

Arguements
----------
- `func`{Function}: An ODE function
- `u0`{Vector}: Initial Values (used for creating `DEsteady`)
- `p`{Vector}: Parameters
- `ranges`{Vector of range}: define the domain and grid for Searching
- `MaxIter`: Maximum iteration for solving the root
- `UniqSpac`{Int}: Rounding the solution.
"""
function fixedpoint_gen(func, u0, p, ranges; MaxIter=10000, UniqSpac=8)

ssmethod = SSRootfind(nlsolve = (f,u0,abstol) -> (
    res=nlsolve(f,u0, autodiff=:forward, iterations= MaxIter,ftol=abstol);
    res.zero
    ))

# Define a problem
de = DEsteady(func=func, p=p, u0= u0, method= ssmethod)

j_gen = jacobian(de) # jacobian generator

# Searching method and domain
param_gen = ParameterGrid(ranges)

# Solve
sols = solve(de, param_gen)

# Remove similar solutions
steadies = unique(sols; tol_digit=UniqSpac)


# Jacobian
jac_ms = j_gen.(steadies)


# Stability
stab_modes = StabilityType.(jac_ms)


return steadies, jac_ms, stab_modes


end 

function fixedpoint_gen(func, p, ranges; kwag...)
    u0 = [i[1] for i in ranges]
    return fixedpoint_gen(func, u0, p, ranges; kwag...)
end