export fixedpoint_gen

function fixedpoint_gen(func, u0, p, ranges; MaxIter=10000)



ssmethod = SSRootfind(nlsolve = (f,u0,abstol) -> (
    res=NLsolve.nlsolve(f,u0, autodiff=:forward, iterations= MaxIter,ftol=abstol);
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
steadies = unique(sols)


# Jacobian
jac_ms = j_gen.(steadies)


# Stability
stab_modes = StabilityType.(jac_ms)


return steadies, jac_ms, jac_ms


end 