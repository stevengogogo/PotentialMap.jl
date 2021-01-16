"""
Reference
---------
- `run.m`
- `gradient_gen.m`
"""


# gradient_func(dt, X)
gradient_func = gradient_gen(sp.ODE!, sp.p, 2, 3)

@testset "Gradient Results" begin 
@test gradient_func(1., ones(6,1)) == sp.gradient(1., ones(6,1))
@test gradient_func(1., 2*ones(6,1)) == sp.gradient(1., 2*ones(6,1))
@test gradient_func(1., zeros(6,1)) == sp.gradient(1., zeros(6,1))
@test gradient_func(2., ones(6,1)) == sp.gradient(2., ones(6,1))
end

@testset "Gradient Results: Screening test" for v in ParameterGrid( [1:2, 1:2, 1:2, 1:2, 1:2, 1:2] )

# Convet Num to Float
grad = map(y->y, gradient_func(0.1, v));

@test grad ≈ sp.gradient(0.1, v);

end;

# Gradient function : mutated
a = ones(6,1)
x = deepcopy(a)
g! = PotentialMap.grad!(gradient_func, 0.1, 2, 3)

g!(a, x)

@test a ≂̸ a_
