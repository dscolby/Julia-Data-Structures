module JuliaDataStructures

export LList
export Queue, enqueue!, dequeue!
export Stack

include("linked_list.jl")
include("queue.jl")
include("stack.jl")

end
