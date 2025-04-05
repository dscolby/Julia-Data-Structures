"""A simple implementation of a stack.
"""

mutable struct SNode
    data
    next
end

mutable struct Stack
    top::Union{SNode, Nothing}
    size::Int
end

Stack() = Stack(nothing, 0)

function Base.push!(s::Stack, item)
    # Create a new node and set it's next node as the node on top of the stack
    new_node = SNode(item, s.top)
    s.top = new_node
    s.size += 1
end

function Base.pop!(s::Stack)
    if isnothing(s.top)
        return nothing
    end

    # Pop a node off the top and set the top as the popped node's next node
    popped_node = s.top
    s.top = popped_node.next
    s.size -= 1

    return popped_node.data
end

Base.size(s::Stack) = s.size
