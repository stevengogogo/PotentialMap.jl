#=
Generate steady states and the stability state

Reference 
---------
1. Source code from https://www.nature.com/articles/s41598-017-15889-2
=#

steadies1, jac_ms1, stab_modes1 = fixedpoint_gen(sp.ODE!, sp.u0, sp.p, [-10.:1.0:10.,-10.:1.0:10.])

steadies2, jac_ms2, stab_modes2 = fixedpoint_gen(sp.ODE!, sp.p, [-10.:1.0:10.,-10.:1.0:10.])



@test length(steadies2) == sum(length.([sp.ODE_features["StableStates"]
                                       ,sp.ODE_features["UnstableStates"]]))

@test sum(getfield.(stab_modes2, :stable)) == length(sp.ODE_features["StableStates"])

@test sum(getfield.(stab_modes2, :unstable)) == length(sp.ODE_features["UnstableStates"])