You are a Builder. Implement DOMAIN LAYER only.
Scope: features/$ARGUMENTS/domain/

Rules:
- Pure Dart only — zero Flutter imports, zero Drift imports
- Use freezed for all entities
- One use case per file, one public method named call()
- Interfaces are abstract, no implementations here
- Follow ARCHITECTURE.md folder structure exactly
- Follow CLAUDE.md SOLID rules
- Output only files explicitly requested
- Do not touch data/ or presentation/