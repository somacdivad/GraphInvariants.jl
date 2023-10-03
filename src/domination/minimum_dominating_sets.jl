
"""
    compute(::Type{MinimumDominatingSet}, g::AbstractGraph{T}; optimizer=HiGHS.Optimizer)

Return a minimum dominating set of `g`.

### Description

A [dominating set](https://en.wikipedia.org/wiki/Dominating_set) of a graph `g` is a
subset `S` of the vertices of `g` such that every vertex not in `S` is adjacent to at
least one member of `S`. A dominating set is said to be minimum if it has the smallest
possible cardinality among all dominating sets of `g`.

## Example

```jldoctest
julia> using Graphs

julia> using GraphInvariants

julia> g = cycle_graph(5)
{5, 5} undirected simple Int64 graph

julia> compute(MinimumDominatingSet, g)
2-element Vector{Int64}:
    1
    3
```
"""
function compute(
    ::Type{MinimumDominatingSet},
    g::AbstractGraph{T};
    optimizer=HiGHS.Optimizer
) where T

    # Instantiate the model.
    model = Model(optimizer)
    JuMP.set_silent(model)

    # The number of vertices.
    n = nv(g)

    # Decision variable for each vertex.
    @variable(model, x[1:n], Bin)

    # Objective: minimize the size of the dominating set.
    @objective(model, Min, sum(x[i] for i=1:n))

    # Constraints: each vertex must either be in the dominating set or adjacent to a vertex in the set
    for u in 1:n
        neighbors_u = neighbors(g, u)
        @constraint(model, x[u] + sum(x[v] for v in neighbors_u) >= 1)
    end

    # Solve the model
    optimize!(model)

    # Extract the solution
    dominating_set = [v for v in 1:n if value(x[v]) == 1.0]

    return dominating_set
end

"""
    compute(::Type{MinimumTotalDominatingSet}, g::AbstractGraph{T}; optimizer=HiGHS.Optimizer)

Return a minimum total dominating set of `g`.

### Description

A [total dominating set](https://en.wikipedia.org/wiki/Total_dominating_set) of a graph `g` is a
subset `S` of the vertices of `g` such that every vertex in `g` is adjacent to at
least one member of `S`. A total dominating set is said to be minimum if it has the smallest
possible cardinality among all total dominating sets of `g`.

## Example

```jldoctest
julia> using Graphs

julia> using GraphInvariants

julia> g = cycle_graph(5)
{5, 5} undirected simple Int64 graph

julia> compute(MinimumTotalDominatingSet, g)
3-element Vector{Int64}:
    1
    2
    3
```
"""
function compute(
    ::Type{MinimumTotalDominatingSet},
    g::AbstractGraph{T};
    optimizer=HiGHS.Optimizer
) where T <: Int

    # Instantiate the model.
    model = Model(optimizer)
    JuMP.set_silent(model)

    # The number of vertices.
    n = nv(g)

    # Decision variable for each vertex.
    @variable(model, x[1:n], Bin)

    # Objective: minimize the size of the dominating set.
    @objective(model, Min, sum(x[i] for i=1:n))

    # Constraints: each vertex must either be in the dominating set or adjacent to a vertex in the set
    for u in 1:n
        neighbors_u = neighbors(g, u)
        @constraint(model, sum(x[v] for v in neighbors_u) >= 1)
    end

    # Solve the model
    optimize!(model)

    # Extract the solution
    dominating_set = [v for v in 1:n if value(x[v]) == 1.0]

    return dominating_set
end

function compute(
    ::Type{MinimumLocatingDominatingSet},
    g::AbstractGraph{T};
    optimizer=HiGHS.Optimizer
) where T <: Int

    # Instantiate the model.
    model = Model(optimizer)
    JuMP.set_silent(model)

    n = nv(g)

    # Decision variable for each vertex.
    @variable(model, x[1:n], Bin)

    # Decision variable to identify which dominator is responsible for a vertex.
    @variable(model, z[1:n, 1:n], Bin)

    # Objective: minimize the size of the dominating set.
    @objective(model, Min, sum(x[i] for i=1:n))

    # Constraints ensuring every vertex is dominated.
    for v in 1:n
        @constraint(model, sum(z[v, u] for u in 1:n) == 1)
        for u in 1:n
            if u == v || has_edge(g, u, v)
                @constraint(model, z[v, u] <= x[u])
            else
                @constraint(model, z[v, u] == 0)
            end
        end
    end

    # Solve the model
    optimize!(model)

    # Extract the solution
    locating_dominating_set = [v for v in 1:n if value(x[v]) == 1.0]

    return locating_dominating_set
end

function compute(
    ::Type{MinimumPairedDominatingSet},
    g::AbstractGraph{T};
    optimizer=HiGHS.Optimizer
) where T

    # Instantiate the model.
    model = Model(optimizer)
    JuMP.set_silent(model)

    n = nv(g)

    # Decision variable for each vertex.
    @variable(model, x[1:n], Bin)

    # Decision variable for each pair.
    @variable(model, z[1:n, 1:n], Bin)

    # Objective: minimize the size of the paired dominating set.
    @objective(model, Min, sum(z[i,j] for i=1:n for j=1:n))

    # Constraints for the pairs.
    for i in 1:n
        for j in 1:n
            @constraint(model, z[i, j] <= x[i])
            @constraint(model, z[i, j] <= x[j])
        end
    end

    # Ensure each vertex is covered by a pair.
    for v in 1:n
        @constraint(model, sum(z[i, j] for i=1:n for j=1:n if i != v && j != v) >= 1)
    end

    # Solve the model
    optimize!(model)

    # Extract the solution
    paired_dominating_set = [v for v in 1:n if value(x[v]) == 1.0]

    return paired_dominating_set
end

function compute(
    ::Type{MinimumIndependentDominatingSet},
    g::AbstractGraph{T};
    optimizer=HiGHS.Optimizer
) where T <: Int

    # Instantiate the model.
    model = Model(optimizer)
    JuMP.set_silent(model)

    # The number of vertices.
    n = nv(g)

    # Decision variable for each vertex.
    @variable(model, x[1:n], Bin)

    # Objective: minimize the size of the dominating set.
    @objective(model, Min, sum(x[i] for i=1:n))

    # Constraints: each vertex must either be in the dominating set or adjacent to a vertex in the set
    for u in 1:n
        neighbors_u = neighbors(g, u)
        @constraint(model, x[u] + sum(x[v] for v in neighbors_u) >= 1)
    end

    # Constraints: insure that no two vertices in the dominating set are adjacent
    for u in 1:n
        for v in (u+1):n
            if has_edge(g, u, v)
                @constraint(model, x[u] + x[v] <= 1)
            end
        end
    end

    # Solve the model
    optimize!(model)

    # Extract the solution
    dominating_set = [v for v in 1:n if value(x[v]) == 1.0]

    return dominating_set
end


function compute(
    ::Type{MinimumEdgeDominatingSet},
    g::AbstractGraph{T};
    optimizer=HiGHS.Optimizer
) where T <: Int

    # Instantiate the model.
    model = Model(optimizer)
    JuMP.set_silent(model)

    # The edge set of the graph.
    E = edges(g)

    # Decision variable for each edge.
    @variable(model, x[E], Bin)

    # Objective: Minimize the number of edges in the MEDS
    @objective(model, Min, sum(x[e] for e in E))

    # Constraints: Each edge or at least one of its adjacent edges is in the MEDS
    for e in E
        u, v = src(e), dst(e)
        adjacent_edges = [
            e2 for e2 in E
            if (e2 != e) &&
                (
                    src(e2) == u ||
                    dst(e2) == u ||
                    src(e2) == v ||
                    dst(e2) == v
                )
        ]
        @constraint(model, x[e] + sum(x[e2] for e2 in adjacent_edges) >= 1)
    end

    # Solve the model.
    optimize!(model)

    # Extract the solution.
    return [e for e in E if value(x[e]) == 1.0]
end


"""
    compute(::Type{MinimumZeroForcingSet}, g::AbstractGraph)

Return a minimum zero forcing set of `g`.

"""
function compute(
    ::Type{MinimumPowerDominatingSet},
    g::AbstractGraph{T}
) where T <: Int
    n = nv(g)
    for size in 1:n
        for subset in combinations(1:n, size)
            blue = Set(subset)
            apply!(DominationRule, blue, g)
            apply!(ZeroForcingRule, blue, g; max_iter=n)
            if length(blue) == n
                return subset
            end
        end
    end
    return []
end

