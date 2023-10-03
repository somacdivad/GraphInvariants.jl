module GraphRules

using Graphs

######################### Define Primary Abstract Types #################################
abstract type AbstractGraphRule end
abstract type AbstractDegreeSequenceRule end

############################ Graph Operations as Rules ##################################

struct DominationRule <: AbstractGraphRule end
struct ZeroForcingRule <: AbstractGraphRule end

##################### Graphical Degree Sequence Operations ##############################

struct HavelHakimiRule <: AbstractDegreeSequenceRule end


######################### Include the Primary Functions #################################
include("domination_rule.jl")
include("zero_forcing_rule.jl")
include("havel_hakimi.jl")

######################### Export the Primary Types and Apply Function  ##################
export AbstractGraphRule, AbstractDegreeSequenceRule
export DominationRule, HavelHakimiRule, ZeroForcingRule
export apply!

end