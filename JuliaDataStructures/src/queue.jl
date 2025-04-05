"""A simple linked list implementation of a queue.
"""

mutable struct QNode
    data
    next
end

mutable struct Queue
    head::Union{QNode, Nothing}
    tail::Union{QNode, Nothing}
    size::Int
end

Queue() = Queue(nothing, nothing, 0)

function enqueue!(q::Queue, item)
    new_node = QNode(item, nothing)

    if isnothing(q.head)
        q.head = new_node
        q.tail = new_node
    else
        q.tail.next = new_node  # Add new nodes to the tail
        q.tail = new_node
    end

    q.size += 1
end

function dequeue!(q::Queue)
    if isnothing(q.head)
        return nothing
    end

    popped_node = q.head  # Pop nodes from the head
    q.head = popped_node.next

    if isnothing(q.head)
        q.tail = nothing
    end

    q.size -= 1

    return popped_node.data
end

Base.size(q::Queue) = q.size
