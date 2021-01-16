"""
Validate the minimization function - `PotentialMap.action`.

Reference
---------
- `run.m`
"""



# Find Steady States
steadies1, jac_ms1, stab_modes1 = PotentialMap.fixedpoint_gen(sp.ODE!, sp.u0, sp.p, [-10.:1.0:10.,-10.:1.0:10.])


# Generate Gradient function 
TotalTime = 2
TotalPoint = 350
gradfunc = gradient_gen(sp.ODE!, sp.p, length(sp.u0), TotalPoint)



# Test
point_start = [0.,0.]
point_end = [1.,1.]
dt = 1.0

initpath = PotentialMap.linearpath(point_start, point_end, TotalPoint)


# Integration 
PotentialMap.integral(initpath, sp.ODE!, PotentialMap.DiffusionMatrix, 0.1, sp.p )

# Gradient 
PotentialMap.grad(initpath, gradfunc, dt)

# Least action 
ref_i = 5
ops = []
@info steadies1[ref_i]
for i in 1:length(steadies1)
    op = action(TotalPoint, 350., steadies1[ref_i], steadies1[i], sp.ODE!, sp.p, PotentialMap.DiffusionMatrix)
    push!(ops, op)
end


# Plot 

fig, ax = plt.subplots()


ax.scatter([i[1] for i in steadies1], [i[2] for i in steadies1], color="black")
ax.scatter( steadies1[ref_i]..., color="red")

for op in ops 
    xs = op.path[1,:]
    ys = op.path[2,:]
    ax.plot(xs, ys)
end 

plt.display_figs()