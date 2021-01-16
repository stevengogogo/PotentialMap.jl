using PotentialMap
using SteadyStateDiffEq
using FindSteadyStates
using Test



include("SampleDE.jl")
sp = SampleDE 

@testset "PotentialMap.jl" begin

    @testset "Generate diffusion matrix" begin
        include("diffusionM.jl")
    end

    @testset "Wrapper of FindSteadyStates" begin 
        include("find_fixedpoints.jl")
    end

    @testset "gradient calculation compared to the reference" begin
        include("gradient.jl")
    end 

    @testset "LeastAction" begin
        include("LeastAction.jl")
    end
end
