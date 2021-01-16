"""
Validate the minimization function - `PotentialMap.action`.

Reference
---------
- `run.m`
"""



# Find Steady States
steadies1, jac_ms1, stab_modes1 = PotentialMap.fixedpoint_gen(sp.ODE!, sp.u0, sp.p, [-10.:1.0:10.,-10.:1.0:10.])


# Generate Gradient function 
TotalTime = 2
TotalPoint = 10 
gradfunc = gradient_gen(sp.ODE!, sp.p, length(sp.u0), TotalPoint)



# Test
point_start = [0.,0.]
point_end = [1.,1.]
dt = 1.0

initpath = PotentialMap.linearpath(point_start, point_end, TotalPoint)


# Integration 
PotentialMap.integral(initpath, sp.ODE!, PotentialMap.DiffusionMatrix, 0.1, sp.p )

# Gradient 
PotentialMap.grad(initpath, gradfunc, dt)

# Least action 
action(TotalPoint, 100., [2.1724,0.2194], [0.3291,2.2194], sp.ODE!, sp.p, PotentialMap.DiffusionMatrix)