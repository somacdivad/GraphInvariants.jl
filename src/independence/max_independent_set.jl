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
    model = JuMP.Model(optimizer)
    JuMP.set_silent(model)
    @variable(model, x[vertices(g)], Bin)
    @objective(model, Max, sum(x))
    @constraint(model, [e = edges(g)], x[src(e)] + x[dst(e)] <= 1)
    optimize!(model)
    return [v for v in vertices(g) if value(x[v]) == 1.0]
end
