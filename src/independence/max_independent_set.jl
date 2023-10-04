@doc raw"""
    function compute(
        ::Type{MaximumIndependentSet},
        g::AbstractGraph{T};
        optimizer=Cbc.Optimizer,
    ) where T <: Integer

Obtain a [maximum independent set](https://en.wikipedia.org/wiki/Independent_set_(graph_theory)) of
`g`.

### Implementation Notes
The independent set is found by solving the following linear program:

```math
\begin{align*}
    \max_{i \in \mathbb{Z}} & \sum\limits_{v \in V} x_v \\
    \;\;\text{s.t.}\; & x_v \in \{0, 1\} & \forall v \in V \\
    & x_u + x_v \leq 1 & \forall uv \in E
\end{align*}
```

### Example
```jldoctest
julia> using Graphs

julia> g = path_graph(5)
{5, 4} undirected simple Int64 graph

julia> compute(MaximumIndependentSet, g)
3-element Vector{Int64}:
 1
 3
 5
```
"""
function compute(
    ::Type{MaximumIndependentSet},
    g::AbstractGraph{T};
    optimizer=HiGHS.Optimizer,
) where T <: Integer

    model = Model(optimizer)  # You can replace Cbc with your preferred optimizer
    JuMP.set_silent(model)  # Suppress solver output

    # Define binary variables for each vertex
    @variable(model, x[vertices(g)], Bin)

    # Define the objective function
    @objective(model, Max, sum(x[v] for v in vertices(g)))

    # Add constraints: adjacent vertices cannot both be in the independent set
    for e in edges(g)
        @constraint(model, x[src(e)] + x[dst(e)] <= 1)
    end

    # Solve the optimization problem
    optimize!(model)

    # Extract the solution
    independent_set = [v for v in vertices(g) if value(x[v]) == 1.0]

    return independent_set
end
