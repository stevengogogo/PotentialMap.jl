#=
Generate steady states and the stability state
=#

include("ODE.jl")

PotentialMap.fixedpoint_gen(ODE!, u0, p_, [
    (0.1,5.,100),
    (0.1,5.,100)
    ])




