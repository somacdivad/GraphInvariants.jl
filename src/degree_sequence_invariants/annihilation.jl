


"""
    compute(::Type{AnnihilationNumber}, g::SimpleGraph)

Return the annihilation number of the graph `g`.
"""
function compute(
    ::Type{AnnihilationNumber},
    g::SimpleGraph,
)
    # Sort in non-decreasing order
    D = sort(degree(g))

    # The number of edges in `g`.
    m = ne(g)

    for i in reverse(1:nv(g))
        if sum(D[1:i]) <= m
            return i
        end
    end
    return nothing
end