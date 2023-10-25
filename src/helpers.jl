function regenerateODEProblem!(mdl::PMModel)
    pp = [getproperty(mdl.parameters, x).value => PMParameterizedBase.getNumericValue(getproperty(mdl.parameters,x)) for x in mdl.parameters.names]
    pi = [getproperty(mdl._inputs, x).value => PMParameterizedBase.getNumericValue(getproperty(mdl._inputs,x)) for x in mdl._inputs.names]
    p = vcat(pp, pi)

    u0 = [getproperty(mdl.states, x).value => PMParameterizedBase.getNumericValue(getproperty(mdl.states,x)) for x in mdl.states.names]
    mdl._odeproblem = remake(mdl._odeproblem, p = p, u0 = u0)
end