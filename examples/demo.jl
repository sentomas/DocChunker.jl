# To run this, open your terminal in the 'examples' folder and type: julia demo.jl

using DocChunker

# 1. Chunking a direct string
println("--- STRING CHUNKING DEMO ---")
text = "Large Language Models require text to be sliced into manageable pieces so they do not exceed their token limits during retrieval."
chunks = chunk_text(text, chunk_size=50, overlap=10)
for (i, c) in enumerate(chunks)
    println("Chunk $i: $c")
end

println("\n--- FILE CHUNKING DEMO ---")
# 2. Chunking a local file semantically
file_chunks = chunk_file("sample.txt", method=:paragraphs, max_size=150)
for (i, c) in enumerate(file_chunks)
    println("Chunk $i: $c")
end