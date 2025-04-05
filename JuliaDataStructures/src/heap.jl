"""This file contains code to create a heap or priority queue from an array.
"""

mutable struct Heap{T}
    array::Vector{T}
    how::Symbol
    size::Int
end

Heap(how::Symbol) = Heap{Real}(Real[], how, 0)

function Base.push!(heap::Heap, data)
    push!(heap.array, data)
    idx = length(heap.array)

    if heap.how == :max
        bubble_up_max!(heap, idx)
    else
        bubble_up_min!(heap, idx)
    end

    heap.size += 1
end

function Base.pop!(heap::Heap)
    n = length(heap.array)
    n == 0 && return nothing
    root = heap.array[1]

    # Move the last element to the root and remove the last element
    heap.array[1] = heap.array[end]
    pop!(heap.array)

    # Re-heapify (bubble down) from the root if the heap is not empty
    if !isempty(heap.array)
        if heap.how == :max
            bubble_down_max!(heap, 1, length(heap.array))
        else
            bubble_down_min!(heap, 1, length(heap.array))
        end
    end
    heap.size -= 1

    return root
end

function bubble_up_max!(heap::Heap, idx::Int)
    while idx > 1
        parent = idx ÷ 2
        if heap.array[parent] < heap.array[idx]
            heap.array[parent], heap.array[idx] = heap.array[idx], heap.array[parent]
            idx = parent
        else
            break
        end
    end
end

function bubble_up_min!(heap::Heap, idx::Int)
    while idx > 1
        parent = idx ÷ 2
        if heap.array[parent] > heap.array[idx]
            heap.array[parent], heap.array[idx] = heap.array[idx], heap.array[parent]
            idx = parent
        else
            break
        end
    end
end

function bubble_down_max!(heap::Heap, idx::Int, n::Int)
    largest = idx
    left = 2idx
    right = 2idx + 1

    if left <= n && heap.array[left] > heap.array[largest]
        largest = left
    end
    if right <= n && heap.array[right] > heap.array[largest]
        largest = right
    end
    if largest != idx
        heap.array[idx], heap.array[largest] = heap.array[largest], heap.array[idx]
        bubble_down_max!(heap, largest, n)
    end
end

function bubble_down_min!(heap::Heap, idx::Int, n::Int)
    smallest = idx
    left = 2idx
    right = 2idx + 1

    if left <= n && heap.array[left] < heap.array[smallest]
        smallest = left
    end
    if right <= n && heap.array[right] < heap.array[smallest]
        smallest = right
    end
    if smallest != idx
        heap.array[idx], heap.array[smallest] = heap.array[smallest], heap.array[idx]
        bubble_down_min!(heap, smallest, n)
    end
end

Base.size(heap::Heap) = heap.size
