"""

- `run.m`
- `gradient_gen.m`
"""

include("SampleDE.jl")

using .SampleDE
import .SampleDE: ODE!,  p_

# gradient_func(dt, X)
gradient_func = gradient_gen(ODE!, p_, 2, 2)

@testset "Gradient Results" begin 
@test gradient_func(1., ones(6,1)) == SampleDE.gradient(1., ones(6,1))
@test gradient_func(1., 2*ones(6,1)) == SampleDE.gradient(1., 2*ones(6,1))
@test gradient_func(1., zeros(6,1)) == SampleDE.gradient(1., zeros(6,1))
@test gradient_func(2., ones(6,1)) == SampleDE.gradient(2., ones(6,1))
end

@testset "Gradient Results: Screening test" for v in ParameterGrid( [1:2, 1:2, 1:2, 1:2, 1:2, 1:2] )

# Convet Num to Float
grad = map(y->y.val, gradient_func(0.1, v));

@test grad ≈ SampleDE.gradient(0.1, v);

end;
