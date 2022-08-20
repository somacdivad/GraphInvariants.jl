@testset "Clique Number" begin

    g0 = SimpleGraph(0)
    for g in testgraphs(g0)
        z = @inferred(clique_number(g))
        @test (z == 0)
    end

    g1 = SimpleGraph(1)
    for g in testgraphs(g1)
        z = @inferred(clique_number(g))
        @test (z == 1)
    end

    g2 = path_graph(5)
    for g in testgraphs(g2)
        z = @inferred(clique_number(g))
        @test (z == 2)
    end

    g3 = cycle_graph(5)
    for g in testgraphs(g3)
        z = @inferred(clique_number(g))
        @test (z == 2)
    end

    g4 = complete_graph(3)
    for g in testgraphs(g4)
        z = @inferred(clique_number(g))
        @test (z == 3)
    end

end
