#=
Generate Symbolic Jacobian with ModelingToolkit. The testing equations are from Matlab tutorial: 
- Jacobian and gradient: https://www.mathworks.com/help/symbolic/jacobian.html
- Hessian: https://www.mathworks.com/help/symbolic/hessian.html
=#

using ModelingToolkit

@variables x, y, z


# Jacobian: Vector{1, N} → Matrix{N,M} where M is Number of variables
jac = ModelingToolkit.jacobian([x*y*z, y^2, x + z], [x, y, z])

# Gradient: Equation → Vector
grad = ModelingToolkit.gradient(2*x + 3*y + 4*z, [x, y, z])

# Hessian
hess = ModelingToolkit.hessian(x*y+2*z*x, [x,y,z])

# Hessian: Jacobian of Gradient 
hess_ = ModelingToolkit.jacobian(ModelingToolkit.gradient(x*y+2*z*x, [x,y,z]), [x,y,z])