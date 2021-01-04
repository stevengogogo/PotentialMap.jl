#=
Generate steady states and the stability state
=#

include("ODE.jl")

steadies1, jac_ms1, stab_modes1 = PotentialMap.fixedpoint_gen(ODE!, u0, p_, [-10.:1.0:10.,-10.:1.0:10.])

steadies2, jac_ms2, stab_modes2 = PotentialMap.fixedpoint_gen(ODE!, p_, [-10.:1.0:10.,-10.:1.0:10.])


