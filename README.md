# DocChunker.jl

A lightweight, native Julia package for intelligent document chunking and text slicing. Designed specifically to prepare documents for Retrieval-Augmented Generation (RAG) pipelines and LLM context windows.

## Features
* **Semantic Splitting:** Keeps related thoughts together by chunking paragraphs at natural `\n\n` boundaries.
* **Context Overlap:** Prevents context loss by automatically overlapping characters between raw chunks.
* **Direct File Ingestion:** Reads and chunks `.txt` and `.md` files in a single function call.

## Installation

You can install `DocChunker` using Julia's package manager. In the Julia REPL, type `]` to enter the Pkg prompt and run:
```julia
pkg> add [https://github.com/YOUR_GITHUB_USERNAME/DocChunker.jl](https://github.com/YOUR_GITHUB_USERNAME/DocChunker.jl)