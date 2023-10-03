"""
    compute(::Type{ZeroForcingNumber}, g::AbstractGraph{T}) where T <: Integer

Return the zero forcing number of `g`.

"""
function compute(
    ::Type{ZeroForcingNumber},
    g::AbstractGraph{T}
) where T <: Integer
    return length(compute(MinimumZeroForcingSet, g))
end
