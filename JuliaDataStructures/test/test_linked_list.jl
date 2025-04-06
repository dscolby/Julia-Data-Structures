using Test
using JuliaDataStructures

@testset "Linked List" begin
    @testset "Adding and Accessing Elements" begin
        lst = LList()
        push!(lst, 1)
        @test lst[1] === 1
        @test size(lst) === 1
    
        lst[1] = 10
        @test lst[1] === 10
        @test size(lst) === 1
    
        push!(lst, 1)
        lst[2] = 2
        @test lst[2] === 2
        @test size(lst) === 2
    
        push!(lst, 1)
        lst[2] = 3
        @test lst[2] === 3
        @test size(lst) === 3
    end
    
    @testset "Bounds Checking" begin
        lst = LList()
        @test_throws BoundsError lst[1]
        @test_throws BoundsError lst[1] = 1
    
        push!(lst, 1)
        @test_throws BoundsError lst[3]
        @test_throws BoundsError lst[-5]
    end
end
