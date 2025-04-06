using Test
using JuliaDataStructures

@testset "HashMap" begin
    @testset "Hashing Functions" begin
        @test JuliaDataStructures._hash(12, 100) isa Integer
        @test JuliaDataStructures._hash("test", 100) isa Integer
        @test JuliaDataStructures._hash((1, 2), 100) isa Integer
        @test JuliaDataStructures._hash(("this", "is", "a", "test"), 100) isa Integer
    end
    
    @testset "Adding Items" begin
        hm = HashMap{Any, String}()
        hm[1] = "a"
        hm[1.5] = "b"
        hm["one"] = "c"
        hm[("1", "2")] = "d"
        @test hm[1] === "a"
        @test hm[1.5] === "b"
        @test hm["one"] === "c"
        @test hm[("1", "2")] === "d"
    end
    
    @testset "Rehashing" begin
        hm = HashMap{Integer, Integer}(4)
    
        for i in 1:20
            hm[i] = i + 1
        end
    
        @test hm[1] === 2
        @test hm[10] === 11
    end
end
