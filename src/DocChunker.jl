module DocChunker

export chunk_text, chunk_by_paragraphs, chunk_file

"""
    chunk_text(text::AbstractString; chunk_size::Int=500, overlap::Int=50)
"""
function chunk_text(text::AbstractString; chunk_size::Int=500, overlap::Int=50)
    if overlap >= chunk_size
        error("Overlap must be strictly less than chunk_size.")
    end

    chunks = String[]
    step_size = chunk_size - overlap
    chars = collect(text)
    total_chars = length(chars)
    
    for i in 1:step_size:total_chars
        end_idx = min(i + chunk_size - 1, total_chars)
        push!(chunks, String(chars[i:end_idx]))
        if end_idx == total_chars
            break
        end
    end
    
    return chunks
end

"""
    chunk_by_paragraphs(text::AbstractString; max_size::Int=500)
"""
function chunk_by_paragraphs(text::AbstractString; max_size::Int=500)
    paragraphs = split(text, "\n\n")
    
    chunks = String[]
    current_chunk = ""

    for p in paragraphs
        p = String(strip(p)) 
        if isempty(p)
            continue
        end

        if length(p) > max_size
            if !isempty(current_chunk)
                push!(chunks, String(strip(current_chunk)))
                current_chunk = ""
            end
            
            sub_chunks = chunk_text(p, chunk_size=max_size, overlap=50)
            append!(chunks, sub_chunks)
            continue
        end

        if length(current_chunk) + length(p) + 2 > max_size && !isempty(current_chunk)
            push!(chunks, String(strip(current_chunk)))
            current_chunk = p
        else
            current_chunk = isempty(current_chunk) ? p : current_chunk * "\n\n" * p
        end
    end

    if !isempty(current_chunk)
        push!(chunks, String(strip(current_chunk)))
    end

    return chunks
end

"""
    chunk_file(filepath::AbstractString; method::Symbol=:paragraphs, max_size::Int=500, chunk_size::Int=500, overlap::Int=50)

Reads a text or markdown file and chunks its contents. 
Set `method=:paragraphs` for semantic chunking or `method=:characters` for raw character slicing.
"""
function chunk_file(filepath::AbstractString; method::Symbol=:paragraphs, max_size::Int=500, chunk_size::Int=500, overlap::Int=50)
    if !isfile(filepath)
        error("File not found: $filepath")
    end
    
    # Read the entire file into a single string
    text = read(filepath, String)
    
    # Route to the appropriate chunking function
    if method == :paragraphs
        return chunk_by_paragraphs(text, max_size=max_size)
    elseif method == :characters
        return chunk_text(text, chunk_size=chunk_size, overlap=overlap)
    else
        error("Unknown method: $method. Please use :paragraphs or :characters.")
    end
end

end # module