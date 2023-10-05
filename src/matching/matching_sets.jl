
"""
    compute(::Type{MaximumMatching}, g::AbstractGraph{T}; optimizer=HiGHS.Optimizer) where T <: Integer

Return a maximum matching of `g`.

### Description

A [matching](https://en.wikipedia.org/wiki/Matching_(graph_theory)) of a graph `g`
is a subset of the edges of `g` such that no two edges share a common vertex. A matching
is said to be maximum if it has the largest possible cardinality among all matchings of `g`.

## Example

```jldoctest
julia> using Graphs

julia> using GraphInvariants

julia> g = cycle_graph(5)
{5, 5} undirected simple Int64 graph

julia> compute(MaximumMatching, g)
2-element Vector{Edge{Int64}}:
 Edge 1 => 2
 Edge 3 => 4
```
"""
function compute(
    ::Type{MaximumMatching},
    g::AbstractGraph{T};
    optimizer=HiGHS.Optimizer
) where T <: Integer
    # Instantiate the model.
    model = JuMP.Model(optimizer)
    JuMP.set_silent(model)

    # The number of vertices.
    n = nv(g)

    # The edge set of the graph.
    E = edges(g)

    # Decision variable for each edge.
    @variable(model, x[E], Bin)

    # Objective: maximize the number of edges in the matching.
    @objective(model, Max, sum(x[e] for e in E))

    # Constraints: Each vertex is incident to at most one matched edge
    for v in 1:n
        incident_edges = [e for e in E if src(e) == v || dst(e) == v]
        @constraint(model, sum(x[e] for e in incident_edges) <= 1)
    end

    # Solve the model.
    optimize!(model)

    # Extract the solution.
    return [e for e in E if value(x[e]) == 1.0]
end
