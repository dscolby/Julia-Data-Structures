"""
This module contains an implementation of a linked list.
"""

mutable struct Node
    data
    next
end

mutable struct LList
    head::Union{Node, Nothing}
    size::Int
end

LList() = LList(nothing, 0)

function Base.push!(lst::LList, data)
    curr = lst.head

    if isnothing(curr)
        curr = Node(data, nothing)
        lst.head = curr
    end

    # Find the last node in the chain
    while curr.next !== nothing
        curr = curr.next
    end

    if curr.data === nothing  # The last node is the head node with no data yet
        curr.data = data
    else
        curr.next = Node(data, nothing) # The last node has data but no next node
    end

    lst.size += 1
end

function Base.getindex(lst::LList, k::Int)
    (k < 1 || k > lst.size) && throw(BoundsError(string(k) * " is not a valid index"))
    idx = 1
    curr = lst.head

    while idx < k  # Keep going to the next node until we hit the node with our index
        curr = curr.next
        idx += 1
    end

    return curr.data
end

function Base.setindex!(lst::LList, value, key)
    (key < 1 || key > lst.size) && throw(BoundsError(string(key) * " is not a valid index"))
    curr = lst.head
    idx = 1

    while idx < key
        curr = curr.next
        idx += 1
    end

    curr.data = value
end

Base.size(lst::LList) = lst.size
