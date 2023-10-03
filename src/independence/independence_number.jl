@doc raw"""
    function compute(
        ::Type{CliqueNumber},
        g::AbstractGraph{T};
        optimizer=Cbc.Optimizer,
    ) where T <: Integer

Return the [independence number](https://en.wikipedia.org/wiki/Independent_set_(graph_theory)) of `g`.

### Implementation Notes
This function relies on `max_independent_set` to obtain a maximum independent set of `g`.
The `optimizer` is passed to `max_independent_set`.

### Example
```jldoctest
julia> using Graphs

julia> g = cycle_graph(5)
{5, 5} undirected simple Int64 graph

julia> compute(IndependenceNumber, g)
2
```
"""
function compute(
    ::Type{IndependenceNumber},
    g::AbstractGraph{T};
    optimizer=HiGHS.Optimizer,
) where T <: Integer
    max_ind_set = compute(MaximumIndependentSet, g; optimizer=optimizer)
    return length(max_ind_set)
end
