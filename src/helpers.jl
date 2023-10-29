# function regenerateODEProblem!(mdl::PMModel)
#     p = mdl.parameters.values
#     u = mdl.parametesr.val
#     odeproblem = remake(mdl._odeproblem; p = mdl.parameters.values, u0 = mdl.p)
# end