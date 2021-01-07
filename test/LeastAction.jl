"""
Validate the minimization function - `PotentialMap.action`.

Reference
---------
- `run.m`
"""

include("SampleDE.jl")
import .SampleDE: ODE!, u0, p_


# Find Steady States
steadies1, jac_ms1, stab_modes1 = PotentialMap.fixedpoint_gen(ODE!, u0, p_, [-10.:1.0:10.,-10.:1.0:10.])


# Generate Gradient function 
TotalTime = 2
TotalPoint = 350 
gradient_func = gradient_gen(ODE!, p_, length(u0), TotalPoint)



