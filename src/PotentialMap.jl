module PotentialMap

using FindSteadyStates
using SteadyStateDiffEq
using NLsolve
using LinearAlgebra
# Write your package code here.
include("fixedpoint_gen.jl")
include("DiffusionMatrix.jl")
include("gradient_gen.jl")

end
