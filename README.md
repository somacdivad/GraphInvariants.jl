# GraphInvariants.jl

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://somacdivad.github.io/GraphInvariants.jl/stable/)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://somacdivad.github.io/GraphInvariants.jl/dev/)
[![Build Status](https://github.com/somacdivad/GraphInvariants.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/somacdivad/GraphInvariants.jl/actions/workflows/CI.yml?query=branch%3Amain)
[![Coverage](https://codecov.io/gh/somacdivad/GraphInvariants.jl/branch/main/graph/badge.svg)](https://codecov.io/gh/somacdivad/GraphInvariants.jl)
[![Code Style: Blue](https://img.shields.io/badge/code%20style-blue-4495d1.svg)](https://github.com/invenia/BlueStyle)
[![ColPrac: Contributor's Guide on Collaborative Practices for Community Packages](https://img.shields.io/badge/ColPrac-Contributor's%20Guide-blueviolet)](https://github.com/SciML/ColPrac)
[![PkgEval](https://JuliaCI.github.io/NanosoldierReports/pkgeval_badges/G/GraphInvariants.svg)](https://JuliaCI.github.io/NanosoldierReports/pkgeval_badges/report.html)

## Overview

The goal of *GraphInvariants.jl* is to provide a wide range of functions for computing invariants on graphs, and is inspired by the [GrinPy](https://github.com/somacdivad/grinpy) Python library.

*GraphInvariants.jl* computes invariants for any graph type that implements the [Graphs.jl](https://github.com/JuliaGraphs/Graphs.jl) `AbstractGraph` interface.

## Installation

Currently, *GraphInvariants.jl* is not a registered Julia package, but you can be installed from this repository's URL:

```julia-repl
pkg> add https://github.com/somacdivad/GraphInvariants.jl
```

We plan to register *GraphInvariants.jl* as soon as version `0.1.0` is released.

## Basic use

To compute an invariant, pass an `AbstractGraph` object to the invariant's function. For instance, the following code creates a cycle graph on five vertices and computes its independence number:

```julia-repl
julia> using Graphs

julia> using GraphInvariants

julia> g = cycle_graph(5)
{5, 5} undirected simple Int64 graph

julia> independence_number(g)
2
```

## Documentation

The full documentation is a work in progress, but is available on [GitHub Pages](https://somacdivad.github.io/GraphInvariants.jl/). You can also access documentation for methods using Julia's help system.

## Project Status

This project is still in its early stages. We plan to implement the following invariants for the version `0.1.0` release:

- [ ] Chromatic number
- [ ] Clique number
- [x] Independence number
- [ ] Domination number
- [ ] Total domination number
- [ ] Connected domination number
- [ ] Independent domination number
- [ ] Matching number

More invariants will be added in later version, including:

- Zero forcing number
- Topological indices, like the Randić and Zagreb indices
- Residue
- And more...