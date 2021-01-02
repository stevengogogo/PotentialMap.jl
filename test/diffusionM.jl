#=
Test the diffusion function generate the matrix which is square and with same length with the dimension of ODE.
=#
include("ODE.jl")



m_diff = PotentialMap.DiffusionMatrix(length(u0))

@testset "Size of m_diff should be square and equal to the length of input vetor" for i in size(m_diff) 
    @test i == length(u0) 
end;