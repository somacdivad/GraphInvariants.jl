
"""
    apply!(::Type{HavelHakimiRule}, sequence::Vector{Int})

Apply the Havel-Hakimi rule to the given sequence.

# Example
```jldoctest
julia> using GraphInvariants

julia> D = [3, 3, 2, 2, 1, 1]

julia> apply!(HavelHakimiRule, D)
true

julia> D
6-element Vector{Int64}:
 2
 1
 1
 1
 1
 1
```
"""

function apply!(
    ::Type{HavelHakimiRule},
    sequence::Vector{Int}
)
    # Base case: if sequence is all zeros, return false
    # meaning we cannot apply the rule again to the sequence
    all(d == 0 for d in sequence) && return false

    # Sort the sequence in non-increasing order
    sort!(sequence, rev=true)

    # If the first number is greater than the length of the sequence or is negative, it's not graphical
    if sequence[1] < 0 || sequence[1] > length(sequence) - 1
        throw(
            DomainError(
                sequence[1],
                "The sequence is not graphical"
        ))
    end

    # Remove the first number and subtract 1 from the next set of numbers
    Δ = sequence[1]
    for i in 2:(Δ + 1)
        sequence[i] -= 1
        if sequence[i] < 0
            throw(
                DomainError(
                    sequence[i],
                    "The sequence is not graphical"
            ))
        end
    end

    # Remove the first number
    deleteat!(sequence, 1)

    # Return true if we can apply the rule again to the sequence
    return true
end

"""
    apply!(::Type{HavelHakimiRule}, sequence::Vector{Int}, eliminations::Vector{Int})

Apply the Havel-Hakimi rule to the given sequence.

# Example
```jldoctest
julia> using GraphInvariants

julia> D = [3, 3, 2, 2, 1, 1]

julia> eliminations = Int[]

julia> apply!(HavelHakimiRule, D, eliminations)
true

julia> D
6-element Vector{Int64}:
 2
 1
 1
 1
 1
 1

julia> eliminations
1-element Vector{Int64}:
 3
```
"""
function apply!(
    ::Type{HavelHakimiRule},
    sequence::Vector{Int},
    eliminations::Vector{Int}
)
    # If sequence is all zeros, add these zeros to
    # the eliminations vector and returr false meaning
    # we cannot apply the rule again to the sequence
    if all(d == 0 for d in sequence)
        for _ in eachindex(sequence)
            push!(elimnations, 0)
        end
        return true
    end

    # Sort the sequence in non-increasing order
    sort!(sequence, rev=true)

    # If the first number is greater than the length of the sequence or is negative, it's not graphical
    if sequence[1] < 0 || sequence[1] > length(sequence) - 1
        throw(
            DomainError(
                sequence[1],
                "The sequence is not graphical"
        ))
    end

    # Remove the first number and subtract 1 from the next set of numbers
    Δ = sequence[1]
    for i in 2:(Δ + 1)
        sequence[i] -= 1
        if sequence[i] < 0
            throw(
                DomainError(
                    sequence[i],
                    "The sequence is not graphical"
            ))
        end
    end

    # Add the first number to the eliminations vector
    push!(eliminations, Δ)

    # Remove the first number
    deleteat!(sequence, 1)

    # Return true if we can apply the rule again to the sequence
    return true
end
