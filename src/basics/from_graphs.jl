
"""
    compute(::Type{Order}, g::AbstractGraph{T}) where T <: Integer

Return the order (the number of vertices) of `g`.

"""
function compute(
    ::Type{Order},
    g::AbstractGraph{T}
) where T <: Integer
    return nv(g)
end

"""
    compute(::Type{Size}, g::AbstractGraph{T}) where T <: Integer

Return the size (the number of edges) of `g`.

"""
function compute(
    ::Type{Size},
    g::AbstractGraph{T}
) where T <: Integer
    return ne(g)
end

"""
    compute(::Type{MaximumDegree}, g::AbstractGraph{T}) where T <: Integer

Return the maximum degree of `g`.

"""
function compute(
    ::Type{MaximumDegree},
    g::AbstractGraph{T}
) where T <: Integer
    return maximum(degree(g))
end

"""
    compute(::Type{MinimumDegree}, g::AbstractGraph{T}) where T <: Integer

Return the minimum degree of `g`.

"""
function compute(
    ::Type{MinimumDegree},
    g::AbstractGraph{T}
 ) where T <: Integer
    return minimum(degree(g))
end

"""
    compute(::Type{AverageDegree}, g::AbstractGraph{T}) where T <: Integer

Return the average degree of `g`.

"""
function compute(
    ::Type{AverageDegree},
    g::AbstractGraph{T}
) where T <: Integer
    return mean(degree(g))
end

"""
    compute(::Type{Diameter}, g::AbstractGraph{T}) where T <: Integer

Return the diameter of `g`.

"""
function compute(
    ::Type{Diameter},
    g::AbstractGraph{T}
) where T <: Integer
    return diameter(g)
end

"""
    compute(::Type{Radius}, g::AbstractGraph{T}) where T <: Integer

Return the radius of `g`.

"""
function compute(
    ::Type{Radius},
    g::AbstractGraph{T}
) where T <: Integer
    return radius(g)
end