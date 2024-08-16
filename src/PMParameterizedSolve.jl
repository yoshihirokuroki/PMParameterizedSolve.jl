module PMParameterizedSolve
using ..PMParameterizedBase
import DifferentialEquations: solve
using DifferentialEquations
PMModel = PMParameterizedBase.PMModel
ModelValues = PMParameterizedBase.ModelValues
include("modelingTools.jl")
include("getindices.jl")
include("getProperty.jl")
include("propertynames.jl")

export solve
export solve!

# Reexport from PMParameterizedBase
export @model
export getUnit
export getDescription
export getDefault
export getDefaultExpr
export getExpr
export ModelingToolkit
export Symbolics

end
