# DocChunker.jl

[![CI](https://github.com/sentomas/DocChunker.jl/actions/workflows/CI.yml/badge.svg)](https://github.com/sentomas/DocChunker.jl/actions/workflows/CI.yml)

**DocChunker.jl** is a zero-dependency, native Julia package designed specifically to prepare unstructured text and documents for Retrieval-Augmented Generation (RAG) pipelines and Large Language Model (LLM) context windows. 

Instead of relying on heavy AI frameworks just to slice strings, `DocChunker` provides a lightweight, blazing-fast utility to chunk text semantically without breaking sentences in half or losing context.

## Installation

Once the package is officially registered, you can install it using Julia's built-in package manager. Open the Julia REPL, type `]` to enter Pkg mode, and run:

```julia
pkg> add DocChunker

```

## Quick Start & Usage Examples

### 1. Semantic Paragraph Splitting (chunk_by_paragraphs)

The safest way to chunk text for RAG is to respect natural document boundaries. This function groups paragraphs together (split by `\n\n`) until it hits your maximum character size limit.

```julia
using DocChunker

raw_text = """
Retrieval-Augmented Generation enhances LLM reliability by grounding outputs.

Chunking is the critical first stage of this pipeline. Slicing semantically ensures complete thoughts survive the embedding process intact.
"""

# Chunks cleanly along paragraph lines without cutting words in half
chunks = chunk_by_paragraphs(raw_text, max_size=500)

for (i, chunk) in enumerate(chunks)
    println("Chunk $i: ", chunk)
end

```

### 2. Overlapping Character Slicing (chunk_text)

If you have a massive block of text with no paragraphs, you must slice it by characters. To prevent context loss at the exact point of the cut, use `chunk_text` to create an overlapping bridge between chunks.

```julia
using DocChunker

long_string = "A very long continuous string of text that needs to be sliced carefully..."

# Slices into 500-character chunks, where the last 50 characters of Chunk 1 become the first 50 characters of Chunk 2
sub_chunks = chunk_text(long_string, chunk_size=500, overlap=50)

```

### 3. Direct File Ingestion (chunk_file)

Skip the custom I/O loops. Read, parse, and chunk local `.txt` or `.md` files in a single line of code.

```julia
using DocChunker

# Automatically reads the file and applies the paragraph-based semantic chunker
file_chunks = chunk_file("path/to/your/document.txt", method=:paragraphs, max_size=800)

```

```

### Why this is better:
1. **It fixes the code blocks:** In Markdown, you must start a code block with ` ```julia ` and end it with ` ``` `.
2. **It adds headers:** Using `##` and `###` creates nice, bold section titles on your GitHub page. 
3. **It adds backticks:** Wrapping things like `\n\n` and `chunk_text` in single backticks (`) formats them as inline code, making it much easier to read.

