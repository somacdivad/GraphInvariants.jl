@testset "Max Independent Set" begin

    g0 = SimpleGraph(0)
    for g in testgraphs(g0)
        z = @inferred(max_independent_set(g))
        @test isempty(z)
    end

    g1 = SimpleGraph(1)
    for g in testgraphs(g1)
        z = @inferred(max_independent_set(g))
        @test (z == [1,])
    end

    g2 = path_graph(5)
    for g in testgraphs(g2)
        z = @inferred(max_independent_set(g))
        @test (z == [1, 3, 5])
    end

    g3 = cycle_graph(5)
    for g in testgraphs(g3)
        z = @inferred(max_independent_set(g))
        @test (z == [3, 5])
    end

end
