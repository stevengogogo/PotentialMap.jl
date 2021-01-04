export fixedpoint_gen

function fixedpoint_gen(func, u0, p, ranges)


# Define a problem
de = DEsteady(func=func, p=p, u0= u0, method=SSRootfind())

j_gen = jacobian(de) # jacobian generator

# Searching method and domain
param_gen = ParameterGrid(ranges)

# Solve
sols = solve(de, param_gen)

# Remove similar solutions
steadies = unique(sols)

<<<<<<< HEAD
# Jacobian
jac_ms = j_gen.(steadies)

=======

# Jacobian
jac_ms = j_gen.(steadies)


>>>>>>> 0ad723ce3250776a20faeb03c0f8b5e1160b8d8d
# Stability
stab_modes = StabilityType.(jac_ms)


return steadies, jac_ms, jac_ms


end 