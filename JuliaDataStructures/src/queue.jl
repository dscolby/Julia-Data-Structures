"""A simple linked list implementation of a queue.
"""

mutable struct QNode
    data
    next
end

mutable struct Queue
    head::Union{QNode, Nothing}
    size::Int
end

Queue() = Queue(nothing, 0)

enqueue!(q::Queue, item) = _enqueue!(q, q.head, item)

# We could also use iteration instead of recursion but this is an educational exercise, 
# so it is good to practice recursion
function _enqueue!(q::Queue, curr::Union{QNode, Nothing}, item)
    # Base case when no items have been added yet
    if isnothing(curr)
        q.head = QNode(item, nothing)
        q.size += 1
        return
    end

    # Next base case when curr is the last node in the queue
    if isnothing(curr.next)
        curr.next = QNode(item, nothing)
        q.size += 1
        return
    end

    # Call enqueue again with the next node
    _enqueue!(q, curr.next, item)
end

function dequeue!(q::Queue)
    if isnothing(q.head)
        return nothing
    end

    curr = q.head
    q.head = curr.next
    q.size -= 1

    return curr.data
end

Base.size(q::Queue) = q.size
