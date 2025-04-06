using Test
using JuliaDataStructures

@testset "Queue" begin
    @testset "Enqueing and Dequeing" begin
        q = Queue()
        @test isnothing(dequeue!(q))
        @test size(q) === 0
    
        enqueue!(q, 1)
        @test size(q) === 1
        @test dequeue!(q) === 1
        @test size(q) === 0
    
        enqueue!(q, 1)
        enqueue!(q, 2)
        @test size(q) === 2
        @test dequeue!(q) === 1
        @test dequeue!(q) === 2
        @test isnothing(dequeue!(q))
    end
end
