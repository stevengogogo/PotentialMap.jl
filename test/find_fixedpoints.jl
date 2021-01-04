#=
Generate steady states and the stability state
=#

include("ODE.jl")

PotentialMap.fixedpoint_gen(ODE!, u0, p_, [
    -10.:1.0:10.,
    -10.:1.0:10.
    ])




