using Test
using JuliaDataStructures

@testset "Enqueing and Dequing" begin
    q = Queue()
    @test isnothing(dequeue(q))

    enqueue(q, 1)
    @test dequeue(q) === 1

    enqueue(q, 1)
    enqueue(q, 2)
    @test dequeue(q) === 1
    @test dequeue(q) === 2
    @test isnothing(dequeue(q))
end
