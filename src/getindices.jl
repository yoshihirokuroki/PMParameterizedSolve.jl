@inline function Base.getindex(x::PMSolution, sym::Symbol)
    sys = getfield(x,:_solution).prob.f.sys
    ivsym = ModelingToolkit.independent_variable(sys).metadata[ModelingToolkit.VariableSource][2]
    if sym in getfield(x, :_names)
        if sym in x._observed.names
            obs = x._observed
            idx = obs.sym_to_val[sym]
            quantity = obs.values[idx].second
            out = x._solution[quantity]
        else
            out = x._solution[sym]
        end
        if length(out) == 1
            out = ones(length(x._solution)) .* out
        end
    elseif sym ==  ivsym
        out = x._solution[sym]
    else
        out = getfield(x, sym)
    end
    return out
end

@inline function Base.getindex(x::partialSol, sym::Symbol)
    if sym in [:parameters, :states, :observed, :partialsolution]
        out = getfield(x, sym)
    else
        if sym in vcat(x.states.names..., x.parameters.names...)
            idx = x.states.sym_to_val[sym]
            out = x.partialsolution[x.states.values[idx].first]
        elseif sym in x.observed.names
            idx = x.observed.sym_to_val[sym]
            obs = x.observed.values[idx].second
            out = x.partialsolution[obs]
        else
            error("Unknown error")
        end
    end
    return out
end