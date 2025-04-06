"""This module contains a simple binary tree implementation.
"""

mutable struct BinaryTree{K<:Real, V}
    key::Union{K, Nothing}
    value::Union{V, Nothing}
    left::Union{BinaryTree{K, V}, Nothing}
    right::Union{BinaryTree{K, V}, Nothing}
end

BinaryTree{K, V}() where {K<:Real, V} = BinaryTree{K, V}(nothing, nothing, nothing, nothing)

function Base.setindex!(tree::BinaryTree, value::Any, key::T) where T <: Real
    if isnothing(tree.key) # Inserting at the root if nothing has been added yet
        tree.key = key
        tree.value = value
        return
    end

    # Replacing the value if a node has the same key
    if key == tree.key
        tree.value = value
        return

    # If the key is smaller than the key of the root's key, go left and insert the new node
    # if there is no left child, otherwise, recurse on the left child
    elseif key < tree.key
        if isnothing(tree.left)
            tree.left = BinaryTree(key, value, nothing, nothing)
        else
            setindex!(tree.left, value, key)
        end

    # If the key is larger than the key of the root's key, go right and insert the new node
    # if there is no right child, otherwise, recurse on the right child
    else
        if isnothing(tree.right)
            tree.right = BinaryTree(key, value, nothing, nothing)
        else
            setindex!(tree.right, value, key)
        end
    end
end

function Base.getindex(tree::BinaryTree, key::T) where T <: Real
    # Make sure the tree isn't empty
    if !isnothing(tree.key)
        # Base case when we find the key
        if tree.key === key
            return tree.value
        end

        # If the key is smaller than the key, then recurse on the left child
        if key < tree.key && !isnothing(tree.left)
            return getindex(tree.left, key)
        end

        # If the key is larger than the key, the recurse on the right child
        if key > tree.key && !isnothing(tree.right)
            return getindex(tree.right, key)
        end
    end
    return nothing # If the key isn't in the tree
end
