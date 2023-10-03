@doc raw"""
    function clique_number(g::AbstractGraph)

Return the [clique number](https://en.wikipedia.org/wiki/Clique_problem) of
`g`.

### Implementation Notes
Computes the independence number of the complement of `g`.

### Example
```jldoctest
julia> using Graphs

julia> g = path_graph(5)
{5, 4} undirected simple Int64 graph

julia> clique_number(g)
2
```
"""
function compute(
    ::Type{CliqueNumber},
    g::AbstractGraph{T};
    optimizer=HiGHS.Optimizer,
) where T <: Int
    h = complement(g)
    return compute(IndependenceNumber, h; optimizer=optimizer)
end
