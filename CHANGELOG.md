# Changelog

All notable changes to this project will be documented in this file.

## [0.1.0] - Initial Release

### Added
- `chunk_by_paragraphs`: Semantic chunking that respects natural document boundaries (`\n\n`).
- `chunk_text`: Character-based chunking with customizable sliding overlap windows to preserve context.
- `chunk_file`: Direct ingestion and chunking of local `.txt` and `.md` files in a single function call.
- Initial automated test suite and Continuous Integration (CI) pipeline.