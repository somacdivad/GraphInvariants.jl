

"""
    compute(::SubKDominationNumber, g::AbstractGraph)

Return the sub-k-domination number of the graph `g`.

## Reference

D. Amos et al., "The sub-k-domination number of a graph with applications to k-domination",
arXiv preprint arXiv:1611.02379, (2016)
"""
function compute(
    alg::SubKDominationNumber,
    g::AbstractGraph{T},
) where T <: Integer

    # Sort in non-increasing order
    D = sort(degree(g), rev=true)

    # The number of vertices in `g`.
    n = nv(g)

    # The sub-k-domination number of `g` is the smallest integer `t` such that
    # the sum of the degrees of the first `t` vertices in the sorted
    # degree sequence with t is at least `n`. Scaling by 1/k
    for i in 1:n
        if i + sum(D[1:i]) / alg.k >= n
            return i
        end
    end
    return nothing
end

"""
    compute(::Type{SlaterNumber}, g::AbstractGraph)

Return the Slater invariant for the graph `g`.
"""
function compute(
    ::Type{SlaterNumber},
    g::AbstractGraph{T},
) where T <: Int

    return compute(SubKDominationNumber(1), g)
end

"""
    sub_total_domination_number(g::AbstractGraph)

Return the sub-total domination number of the graph `g`.

## Reference

R. Davila, "A note on sub-total domination in graphs", arXiv preprint arXiv:1701.07811, (2017)
"""
function compute(
    ::Type{SubTotalDominationNumber},
    g::AbstractGraph{T},
) where T <: Integer
    D = sort(degree(g), rev=true)  # Sort in non-increasing order
    n = nv(g)
    for i in 1:n
        if sum(D[1:i]) >= n
            return i
        end
    end
    return nothing
end

