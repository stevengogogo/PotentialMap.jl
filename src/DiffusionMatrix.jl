#= 
The diffusion matrix insert noise to deterministic model. 
=#

"""
Generate Diffusion matrix.
For independent noise, the diffusion matrix is an identity matrix

Arguement
---------
- `len_of_u`{Integer}: the dimension of ODE model 
"""
function DiffusionMatrix(len_of_u)
    return Matrix(I, len_of_u, len_of_u)
end