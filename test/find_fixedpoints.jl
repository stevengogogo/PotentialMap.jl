#=
Generate steady states and the stability state

Reference 
---------
1. Source code from https://www.nature.com/articles/s41598-017-15889-2
=#

include("SampleDE.jl")
import .SampleDE: ODE!, u0, p, ODE_features

steadies1, jac_ms1, stab_modes1 = PotentialMap.fixedpoint_gen(ODE!, u0, p, [-10.:1.0:10.,-10.:1.0:10.])

steadies2, jac_ms2, stab_modes2 = PotentialMap.fixedpoint_gen(ODE!, p, [-10.:1.0:10.,-10.:1.0:10.])



@test length(steadies2) == sum(length.([ODE_features["StableStates"]
                                       ,ODE_features["UnstableStates"]]))

@test sum(getfield.(stab_modes2, :stable)) == length(ODE_features["StableStates"])

@test sum(getfield.(stab_modes2, :unstable)) == length(ODE_features["UnstableStates"])