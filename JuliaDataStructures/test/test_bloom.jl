using Test
using JuliaDataStructures

@testset "Bloom Filter" begin
    @testset "Retriving Items" begin
        bf = BloomFilter(100)
        add!(bf, 1)
        @test 1 ∈ bf
        @test 17 ∉ bf
    
        add!(bf, 10)
        @test 10 ∈ bf
    end
end
