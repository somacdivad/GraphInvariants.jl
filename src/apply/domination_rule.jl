function apply!(
    ::Type{DominationRule},
    target_set::Set{Int},
    g::AbstractGraph,
)
    for v in copy(target_set)  # use copy to avoid modifying set during iteration
        union!(target_set, neighbors(g, v))
    end
end