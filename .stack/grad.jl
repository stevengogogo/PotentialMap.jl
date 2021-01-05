using ModelingToolkit


@variables x1 x2
@parameters dt

eq = [
    -1 + 9 *x1 - 2*x1^3 + 9 *x2 - 2*x2^3,
    1 - 11*x1 + 2*x1^3 + 11*x2 - 2*x2^3
]


ModelingToolkit.gradient.(eq, [[x1,x2]])

#=
os = OptimizationSystem(eq, [], [x1,x2])

calculate_gradient(os)
=#