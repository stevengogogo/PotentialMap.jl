using PotentialMap
using SteadyStateDiffEq
using Test

@testset "PotentialMap.jl" begin
    include("diffusionM.jl")
    include("find_fixedpoints.jl")
end
