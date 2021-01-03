using PotentialMap
using SteadyStateDiffEq
using Test

@testset "PotentialMap.jl" begin
    #include("find_fixedpoints.jl")
    include("diffusionM.jl")
end
