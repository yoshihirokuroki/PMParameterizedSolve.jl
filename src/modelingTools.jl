using DifferentialEquations

Base.@kwdef struct PMSolution <: PMParameterizedBase.AbstractPMSolution
    _solution::ODESolution
    _states::ModelValues
    _parameters::ModelValues
    _constants::ModelValues
    _observed::ModelValues
    _names::Vector{Symbol}
end


Base.@kwdef struct partialSol
    partialsolution
    observed::ModelValues
    parameters::ModelValues
    states::ModelValues
end


function (sol::PMSolution)(in)
    if length(in) == 1
        in = [in]
    end
    stmp = sol._solution(in)
    psol = partialSol(partialsolution = stmp, observed = sol._observed, parameters = sol._parameters, states = sol._states)
    return psol
end





function solve(mdl::PMModel, alg::Union{DEAlgorithm,Nothing} = nothing ; kwargs...)
    mdl_internal = deepcopy(mdl)
    regenerateODEProblem!(mdl_internal)
    sol = DifferentialEquations.solve(mdl_internal._odeproblem, alg; kwargs...)
    solution = PMSolution(_solution = sol,
                            _states = mdl_internal.states,
                            _parameters = mdl_internal.parameters,
                            _constants = mdl_internal._constants, 
                            _observed = mdl_internal.observed,
                            _names = vcat(collect(keys(mdl_internal.observed._values)),mdl_internal.parameters.names,mdl_internal.states.names))
    return solution
end


function solve!(mdl::PMModel, alg::Union{DEAlgorithm,Nothing} = nothing ; kwargs...)
    mdl_internal = deepcopy(mdl)
    regenerateODEProblem!(mdl_internal)
    sol = DifferentialEquations.solve(mdl_internal._odeproblem, alg; kwargs...)
    solution = PMSolution(_solution = sol,
                            _states = mdl_internal.states,
                            _parameters = mdl_internal.parameters,
                            _constants = mdl_internal._constants, 
                            _observed = mdl_internal.observed, 
                            _names = vcat(collect(keys(mdl_internal.observed._values)),mdl_internal.parameters.names,mdl_internal.states.names))
    mdl._solution = solution
    return nothing
end




