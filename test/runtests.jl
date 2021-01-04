using PotentialMap
using SteadyStateDiffEq
using Test

@testset "PotentialMap.jl" begin

    @testset "Generate diffusion matrix" begin
        include("diffusionM.jl")
    end

    @testset "Wrapper of FindSteadyStates" begin 
        include("find_fixedpoints.jl")
    end
end
