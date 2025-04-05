"""This file contains a simple implementation of a Bloom Filter.
"""

mutable struct BloomFilter
    capacity::Int
    error_rate::AbstractFloat
    size::Int
    num_hashes::Int
    array::BitVector
end

function BloomFilter(capacity::Int, error_rate::AbstractFloat=0.01)
    size = Int(round(-(capacity * log(error_rate)) / (log(2)^2)))
    num_hashes = Int(round((size / capacity) * log(2)))
    BloomFilter(capacity, error_rate, size, num_hashes, falses(size))
end

function add!(bf::BloomFilter, key::T) where{T}
    hashes = compute_hashes(key, bf.num_hashes, bf.size)
    bf.array[hashes] .= 1
end

function Base.in(item::T, bf::BloomFilter) where{T}
    hashes = compute_hashes(item, bf.num_hashes, bf.size)

    return all(x -> x == 1, bf.array[hashes])
end

# This function uses two hashes, which is more robust, but there are other hash functions
# with different tradeoffs between computation and performance
function compute_hashes(key::T, k::Int, max::Int) where {T}
    a_hash = hash(key, UInt(0))
    b_hash = hash(key, UInt(170))
    hashes = Array{UInt, 1}(undef, k)
    for i in 1:k
        hashes[i] = mod(a_hash + i * b_hash, max) + 1
    end
    return hashes
end
