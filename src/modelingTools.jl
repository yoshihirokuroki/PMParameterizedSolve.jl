using DifferentialEquations

Base.@kwdef struct PMSolution <: PMParameterizedBase.AbstractPMSolution
    _solution::ODESolution
    _states::PMParameterizedBase.Variables
    _parameters::PMParameterizedBase.Parameters
    _constants::PMParameterizedBase.Constants
    _observed::PMParameterizedBase.Observed
    _names::Vector{Symbol}
end


Base.@kwdef struct partialSol
    partialsolution
    observed::PMParameterizedBase.Observed
    parameters::PMParameterizedBase.Parameters
    states::PMParameterizedBase.Variables
end


function (sol::PMSolution)(in)
    if length(in) == 1
        in = [in]
    end
    stmp = sol._solution(in)
    psol = partialSol(partialsolution = stmp, observed = sol._observed, parameters = sol._parameters, states = sol._states)
    return psol
end




function DifferentialEquations.solve(mdl::PMModel, alg::Union{DEAlgorithm,Nothing} = nothing; kwargs...)
    p = vcat(mdl.parameters.values, mdl._inputs.values)
    prob = remake(mdl._odeproblem, p = p, u0 = mdl.states.values)
    sol = solve(prob, alg; kwargs...)
    solution = PMSolution(_solution = sol,
                            _states = mdl.states,
                            _parameters = mdl.parameters,
                            _constants = mdl.parameters.constants, 
                            _observed = mdl.observed,
                            _names = [names(mdl.observed)..., names(mdl.parameters)..., names(mdl.states)...])
    return solution
end


function DifferentialEquations.solve!(mdl::PMModel, alg::Union{DEAlgorithm,Nothing} = nothing ; kwargs...)
    regenerateODEProblem!(mdl)
    sol = solve(mdl._odeproblem, alg; kwargs...)
    solution = PMSolution(_solution = deepcopy(sol),
                            _states = mdl.states,
                            _parameters = mdl.parameters,
                            _constants = mdl._constants, 
                            _observed = mdl.observed, 
                            _names = vcat(collect(keys(mdl.observed._values)),mdl.parameters.names,mdl.states.names))
    mdl._solution = solution
    return nothing
end




