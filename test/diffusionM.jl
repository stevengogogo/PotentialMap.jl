#=
Test the diffusion function generate the matrix which is square and with same length with the dimension of ODE.
=#



m_diff = PotentialMap.DiffusionMatrix(length(sp.u0))

@testset "Size of m_diff should be square and equal to the length of input vetor" for i in size(m_diff) 
    @test i == length(sp.u0) 
end;