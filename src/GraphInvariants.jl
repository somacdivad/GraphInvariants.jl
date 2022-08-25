module GraphInvariants

using Cbc
using Graphs
using JuMP

include("independence/max_independent_set.jl")
include("independence/independence_number.jl")
include("cliques/clique_number.jl")


# independence
export max_independent_set
export independence_number

# cliques
export clique_number

end
