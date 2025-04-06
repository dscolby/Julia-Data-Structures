using Test
using JuliaDataStructures

@testset "Heap" begin
    @testset "Adding and Removing from Max Heap" begin
        h = Heap(:max)
        @test isnothing(pop!(h))
        @test size(h) === 0
    
        push!(h, 1)
        @test size(h) === 1
    
        push!(h, 5)
        @test size(h) === 2
    
        push!(h, 3)
        @test size(h) === 3
    
        @test pop!(h) === 5
        @test size(h) === 2
        @test pop!(h) === 3
        @test size(h) === 1
        @test pop!(h) === 1
        @test size(h) === 0
        @test isnothing(pop!(h))
    end
    
    @testset "Adding and Removing from Min Heap" begin
        h = Heap(:min)
        @test isnothing(pop!(h))
        @test size(h) === 0
    
        push!(h, 1)
        @test size(h) === 1
    
        push!(h, 5)
        @test size(h) === 2
    
        push!(h, 3)
        @test size(h) === 3
    
        @test pop!(h) === 1
        @test size(h) === 2
        @test pop!(h) === 3
        @test size(h) === 1
        @test pop!(h) === 5
        @test size(h) === 0
        @test isnothing(pop!(h))
    end
end
