"""
    compute(::Type{MinimumZeroForcingSet}, g::AbstractGraph)

Return a minimum zero forcing set of `g`.

"""
function compute(
    ::Type{MinimumZeroForcingSet},
    g::AbstractGraph
)
    n = nv(g)
    for size in 1:n
        for subset in combinations(1:n, size)
            blue = Set(subset)
            apply!(ZeroForcingRule, blue, g; max_iter=n)
            if length(blue) == n
                return subset
            end
        end
    end
    return []
end
