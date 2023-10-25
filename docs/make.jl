using PMParameterizedSolve
using Documenter

DocMeta.setdocmeta!(PMParameterizedSolve, :DocTestSetup, :(using PMParameterizedSolve); recursive=true)

makedocs(;
    modules=[PMParameterizedSolve],
    authors="Timothy Knab",
    repo="https://github.com/timknab/PMParameterizedSolve.jl/blob/{commit}{path}#{line}",
    sitename="PMParameterizedSolve.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://timknab.github.io/PMParameterizedSolve.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/timknab/PMParameterizedSolve.jl",
    devbranch="main",
)
