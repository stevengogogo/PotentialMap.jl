using PotentialMap
<<<<<<< HEAD
using OrdinaryDiffEq
=======
using SteadyStateDiffEq
>>>>>>> 0ad723ce3250776a20faeb03c0f8b5e1160b8d8d
using Test

@testset "PotentialMap.jl" begin
    #include("find_fixedpoints.jl")
    include("diffusionM.jl")
end
