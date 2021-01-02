using PotentialMap
using OrdinaryDiffEq
using Test

@testset "PotentialMap.jl" begin
    #include("find_fixedpoints.jl")
    include("diffusionM.jl")
end
