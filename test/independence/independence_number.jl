@testset "Independence Number" begin

    g0 = SimpleGraph(0)
    for g in testgraphs(g0)
        z = @inferred(independence_number(g))
        @test (z == 0)
    end

    g1 = SimpleGraph(1)
    for g in testgraphs(g1)
        z = @inferred(independence_number(g))
        @test (z == 1)
    end

    g2 = path_graph(5)
    for g in testgraphs(g2)
        z = @inferred(independence_number(g))
        @test (z == 3)
    end

    g3 = cycle_graph(5)
    for g in testgraphs(g3)
        z = @inferred(independence_number(g))
        @test (z == 2)
    end

end
