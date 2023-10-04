
function compute(
    ::Type{SlaterNumber},
    g::AbstractGraph{T}
) where T <: Integer

    # Get the sorted degree sequence in non-increasing order
    sorted_degrees = sort(degree(g), rev=true)

    # The number of vertices in `g`.
    n = nv(g)

    # The sum of the degrees of the first `t` vertices in the sorted
    # degree sequence with the integer t.
    t_sum = 0

    # The Slater number of `g` is the smallest integer `t` such that
    # the sum of the degrees of the first `t` vertices in the sorted
    # degree sequence with t is at least `n`.
    for t = 1:n
        t_sum += sorted_degrees[t]
        if t + t_sum >= n
            return t
        end
    end
end