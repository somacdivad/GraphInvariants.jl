var documenterSearchIndex = {"docs":
[{"location":"","page":"Home","title":"Home","text":"CurrentModule = GraphInvariants","category":"page"},{"location":"#GraphInvariants","page":"Home","title":"GraphInvariants","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"Documentation for GraphInvariants.","category":"page"},{"location":"","page":"Home","title":"Home","text":"","category":"page"},{"location":"","page":"Home","title":"Home","text":"Modules = [GraphInvariants]","category":"page"},{"location":"#GraphInvariants.clique_number-Tuple{Graphs.AbstractGraph}","page":"Home","title":"GraphInvariants.clique_number","text":"function clique_number(g::AbstractGraph)\n\nReturn the clique number of g.\n\nImplementation Notes\n\nComputes the independence number of the complement of g.\n\nExample\n\njulia> using Graphs\n\njulia> g = path_graph(5)\n{5, 4} undirected simple Int64 graph\n\njulia> clique_number(g)\n2\n\n\n\n\n\n","category":"method"},{"location":"#GraphInvariants.independence_number-Union{Tuple{Graphs.AbstractGraph{T}}, Tuple{T}} where T<:Integer","page":"Home","title":"GraphInvariants.independence_number","text":"function independence_number(\n    g::AbstractGraph{T};\n    optimizer=Cbc.Optimizer,\n) where T <: Integer\n\nReturn the independence number of g.\n\nImplementation Notes\n\nThis function relies on max_independent_set to obtain a maximum independent set of g. The optimizer is passed to max_independent_set.\n\nExample\n\njulia> using Graphs\n\njulia> g = cycle_graph(5)\n{5, 5} undirected simple Int64 graph\n\njulia> independence_number(g)\n2\n\n\n\n\n\n","category":"method"},{"location":"#GraphInvariants.max_independent_set-Union{Tuple{Graphs.AbstractGraph{T}}, Tuple{T}} where T<:Integer","page":"Home","title":"GraphInvariants.max_independent_set","text":"function max_independent_set(\n    g::AbstractGraph{T};\n    optimizer=Cbc.Optimizer,\n) where T <: Integer\n\nObtain a maximum independent set of g.\n\nImplementation Notes\n\nThe independent set is found by solving the following linear program:\n\nbeginalign*\n    max_i in mathbbZ  sumlimits_v in V x_v \n    textst  x_v in 0 1  forall v in V \n     x_u + x_v leq 1  forall uv in E\nendalign*\n\nThe default optimizer is Cbc as provided by Cbc.jl. You may provide a different optimizer by passing an optimizer constructer (such Cbc.Optimizer or ()->Cbc.Optimizer()) to the optimizer parameter.\n\nExample\n\njulia> using Graphs\n\njulia> g = path_graph(5)\n{5, 4} undirected simple Int64 graph\n\njulia> max_independent_set(g)\n3-element Vector{Int64}:\n 1\n 3\n 5\n\n\n\n\n\n","category":"method"}]
}
