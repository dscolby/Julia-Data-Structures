using Test
using JuliaDataStructures

@testset "Adding and Removing Data" begin
    stack = Stack()
    @test size(stack) === 0
    @test isnothing(stack.top)

    push!(stack, 1)
    @test pop!(stack) === 1
    @test size(stack) === 0

    push!(stack, 1)
    push!(stack, 2)
    @test size(stack) === 2
    @test pop!(stack) === 2
    @test size(stack) === 1
end