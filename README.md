# Coding Standards & Conventions

A collection of coding standards and best practices for software development. These conventions are used across multiple projects to ensure consistency, maintainability, and code quality.

## Overview

This repository contains coding conventions and best practices that can be referenced and reused across projects. The standards are organized by language and topic, making it easy to find relevant guidelines for your project.

## Swift / SwiftUI Conventions

See [swift-conventions.md](./swift-conventions.md) for comprehensive Swift and SwiftUI coding standards.

## Commit Message Conventions

See [commit-conventions.md](./commit-conventions.md) for commit message standards following the [Conventional Commits](https://www.conventionalcommits.org/) specification, including the `topic()` scope convention for work-in-progress features.

## General Principles

These principles apply across all languages and projects:

- **DRY** (Don't Repeat Yourself): Ensure each piece of logic has a single representation.
- **Immutability & Finality**: Prefer immutability where possible. Mark classes as `final` unless inheritance is required. Prefer value types over reference types.
- **Constructors over Setters**: Prefer immutability and constructor initialization over setters unless setters genuinely make more sense for the use case.
- **KISS** (Keep It Simple, Stupid): Prioritize simplicity and avoid over‑engineering.
- **SOLID**: Apply the five SOLID principles for flexible architecture.
- **YAGNI** (You Aren't Gonna Need It): Build only what is currently required.

## Usage

Reference these conventions in your project README:

```markdown
## Coding Standards

This project follows the coding conventions defined in:
https://github.com/tomer-ben-david/2025-coding-standards
```

Or link to specific sections:

```markdown
See our [Swift coding conventions](https://github.com/tomer-ben-david/2025-coding-standards/blob/main/swift-conventions.md).
```

## Contributing

Contributions are welcome! If you have improvements or additional conventions to add, please open a pull request.

## License

This repository is provided as-is for reference and reuse.
