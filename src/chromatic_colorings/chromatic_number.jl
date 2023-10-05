
"""
    compute(::Type{ChromaticNumber}, g::AbstractGraph{T}) where T <: Integer

Return the chromatic number of `g`.

"""
function compute(
    ::Type{ChromaticNumber},
    g::AbstractGraph{T};
    optimizer = HiGHS.Optimizer
) where T <: Int
    min_prop_coloring = compute(MinimumProperColoring, g; optimizer=optimizer)
    return length(unique(values(min_prop_coloring)))
end