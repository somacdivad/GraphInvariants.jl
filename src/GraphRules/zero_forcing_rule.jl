

function apply!(
    ::Type{ZeroForcingRule},
    blue::Set{Int},
    g::AbstractGraph;
    max_iter=100_000 # this limits the number of applications of the rule
)
    changes_made = true
    iter = 0
    V = vertices(g)
    while changes_made && iter < max_iter
        changes_made = false
        for v in V
            if (v in blue)
                white_neighbors = setdiff(neighbors(g, v), blue)
                if length(white_neighbors) == 1
                    union!(blue, white_neighbors)
                    changes_made = true
                end
            end
        end
        iter += 1
    end
end