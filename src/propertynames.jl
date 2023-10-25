@inline function Base.propertynames(x::PMSolution)
    return x._names
end

@inline function Base.propertynames(x::partialSol)
    names = vcat(x.states.names, x.parameters.names, x.observed.names)
    return names
end