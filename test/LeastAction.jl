"""
Validate the minimization function - `PotentialMap.action`.

Reference
---------
- `run.m`
"""

include("SampleDE.jl")
import .SampleDE: ODE, u0, p, ODE!


# Find Steady States
steadies1, jac_ms1, stab_modes1 = PotentialMap.fixedpoint_gen(ODE!, u0, p, [-10.:1.0:10.,-10.:1.0:10.])


# Generate Gradient function 
TotalTime = 2
TotalPoint = 10 
gradfunc = gradient_gen(ODE!, p, length(u0), TotalPoint)



# Test
point_start = [0.,0.]
point_end = [1.,1.]
dt = 1.0

initpath = PotentialMap.linearpath(point_start, point_end, TotalPoint)


# Integration 
PotentialMap.integral(initpath, ODE, PotentialMap.DiffusionMatrix, 0.1, p )

# Gradient 
PotentialMap.grad(initpath, gradfunc, dt)