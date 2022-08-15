using GraphInvariants
using Graphs
using Test

const testdir = dirname(@__FILE__)

testgraphs(g) = is_directed(g) ? [g, DiGraph{UInt8}(g), DiGraph{Int16}(g)] : [g, Graph{UInt8}(g), Graph{Int16}(g)]
testgraphs(gs...) = vcat((testgraphs(g) for g in gs)...)
testdigraphs = testgraphs

tests = [
    "independence/max_independent_set",
    "independence/independence_number",
]

@testset "GraphInvariants.jl" begin
    for t in tests
        tp = joinpath(testdir, "$(t).jl")
        include(tp)
    end
end
