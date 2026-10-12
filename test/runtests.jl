using DocChunker
using Test

@testset "DocChunker.jl" begin
    # Basic test to ensure the package loads and chunk_text works
    text = "This is a simple test string to verify the chunker."
    chunks = chunk_text(text, chunk_size=10, overlap=2)
    
    @test length(chunks) > 0
    @test typeof(chunks) == Vector{String}
end