using GraphInvariants
using Documenter

DocMeta.setdocmeta!(GraphInvariants, :DocTestSetup, :(using GraphInvariants); recursive=true)

makedocs(;
    modules=[GraphInvariants],
    authors="David Amos <somacdivad@gmail.com> and contributors",
    repo="https://github.com/somacdivad/GraphInvariants.jl/blob/{commit}{path}#{line}",
    sitename="GraphInvariants.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://somacdivad.github.io/GraphInvariants.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/somacdivad/GraphInvariants.jl",
    devbranch="main",
)
