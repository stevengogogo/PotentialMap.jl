using PotentialMap
using Documenter

makedocs(;
    modules=[PotentialMap],
    authors="stevengogogo <stevengogogo4321@gmail.com> and contributors",
    repo="https://github.com/stevengogogo/PotentialMap.jl/blob/{commit}{path}#L{line}",
    sitename="PotentialMap.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://stevengogogo.github.io/PotentialMap.jl",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    branch = "gh-pages",
    repo="github.com/stevengogogo/PotentialMap.jl.git",
)
