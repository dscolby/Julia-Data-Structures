"""This file contains an implementation of a hashmap with multiplicative hashing and linear
chaining.
"""

const KNUTHS_CONSTANT = (sqrt(5) - 1) / 2

# This is basically a linked list to deal with collisions
mutable struct HashNode{K, V}
    key::Union{K, Nothing}
    value::Union{V, Nothing}
    next::Union{HashNode{K, V}, Nothing}
end

mutable struct HashMap{K, V}
    size::Int # Initial number of slots
    capacity::AbstractFloat # Proportion to be filled before rehashing
    growth_factor::Real
    table::Vector{HashNode{K, V}} # The actual table
    length::Int # Number of elements in the hashmap
end

function HashMap{K, V}(
    size::Int=256, capacity::AbstractFloat=0.75, growth_factor::Real=2
) where {K, V}
    table = [HashNode{K, V}(nothing, nothing, nothing) for i in 1:size]
    HashMap{K, V}(size, capacity, growth_factor, table, 0)
end

function _hash(key::Tuple{Vararg{<:Real}}, size::Int)
    hash_val = 0

    for num in key 
        hash_val += num
    end

    return _hash(hash_val, size)
end

Base.setindex!(hashmap::HashMap, value, key) = _insert!(hashmap, value, key)

function Base.getindex(hashmap::HashMap, key)
    idx = _hash(key, hashmap.size)
    curr = hashmap.table[idx]

    while curr.key != key
        curr = curr.next
    end

    return curr.value
end

function _insert!(hm::HashMap{K, V}, value::V, key::K) where {K, V}
    idx = _hash(key, hm.size)
    node = hm.table[idx]

    # If there is no data at the given slot
    if isnothing(node.key)
        node.key = key
        node.value = value
        hm.length += 1
        return
    end

    # Search the chain for the existing key
    while true
        if node.key == key
            node.value = value  # overwrite
            return
        elseif isnothing(node.next)
            break
        end
        node = node.next
    end

    node.next = HashNode{K, V}(key, value, nothing)
    hm.length += 1
    hm.length / hm.size >= hm.capacity && _rehash(hm)
end

function _rehash(hashmap::HashMap{K, V}) where {K, V}
    old_table, old_size = hashmap.table, hashmap.size
    hashmap.size = Int(old_size * hashmap.growth_factor)
    hashmap.table = [HashNode{K, V}(nothing, nothing, nothing) for _ in 1:hashmap.size]
    hashmap.length = 0

    for node in old_table
        curr = node

        # Insert the values from the old table into the new one
        while !isnothing(curr) && !isnothing(curr.key)
            _insert!(hashmap, curr.value, curr.key)
            curr = curr.next
        end
    end
end

function _hash(key::Tuple{Vararg{String}}, size::Int)
    hash_val = 0

    for item in key
        for char in item
            hash_val += sum([Int(char) for char in item])
        end
    end
    return _hash(hash_val, size)
end

_hash(key::String, size::Integer) = _hash(sum([Int(c) for c in key]), size)

function _hash(key::Real, size::Integer)
    return max(1, Int(floor(size * (key * KNUTHS_CONSTANT % 1))))
end
