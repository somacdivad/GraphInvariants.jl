module GraphInvariants

using Cbc
using Graphs
using JuMP

include("independence/max_independent_set.jl")
include("independence/independence_number.jl")

export max_independent_set
export independence_number

end
