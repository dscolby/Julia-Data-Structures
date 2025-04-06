using Test
using JuliaDataStructures

@testset "Binary Tree" begin
    tree = BinaryTree{Int, String}()
    tree[2] = "b"
    tree[1] = "a"
    tree[3] = "c"
    tree[4] = "d"
    tree[0] = "z"

    @testset "Insertion" begin
        @test tree.key === 2
        @test tree.value === "b"
        @test tree.left.key === 1
        @test tree.left.value === "a"
        @test tree.right.key === 3
        @test tree.right.value === "c"
        @test tree.right.right.key === 4
        @test tree.right.right.value === "d"
        @test tree.left.left.key === 0
        @test tree.left.left.value === "z"
    end

    @testset "Retrieval" begin
        @test tree[2] === "b"
        @test tree[1] === "a"
        @test tree[3] === "c"
        @test tree[4] === "d"
        @test tree[0] === "z"
        @test isnothing(tree[90])
    end
end
