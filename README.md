# Coding Standards & Conventions

A collection of coding standards and best practices for software development. These conventions are used across multiple projects to ensure consistency, maintainability, and code quality.

## Overview

This repository contains coding conventions and best practices that can be referenced and reused across projects. The standards are organized by language and topic, making it easy to find relevant guidelines for your project.

## General Coding Conventions

See [general-conventions.md](./general-conventions.md) for coding standards that apply to all programming languages. Examples use Swift syntax, but principles are language-agnostic.

**Reviewers:** read [Code Review Preface](./general-conventions.md#code-review-preface-read-this-first) first — explicit goal **and non-goals**, branch-only scope, clarity focus, AI anti-patterns, and output format.

### How to review against these standards

1. **Read fully, every time.** Read [`general-conventions.md`](./general-conventions.md) end-to-end (applies to all languages) **plus** the language-specific file matching the code under review ([`swift-conventions.md`](./swift-conventions.md) / [`effective-typescript.md`](./effective-typescript.md)). Don't review from memory.
2. **Scope:** branch-introduced changes only — never pre-existing issues on `main`.
3. **Check every item.** Go over **all** sections/items in the files you read and mark each **pass / not-pass / N/A** in your report, so nothing is silently skipped. Tie each `not-pass` to a finding; `N/A` needs a one-word why (don't use `pass` to mean "didn't check"). If a finding doesn't map to any item, it's likely out of scope or restates an existing one — re-check before filing.

## Swift / SwiftUI Conventions

See [swift-conventions.md](./swift-conventions.md) for Swift and SwiftUI-specific patterns and examples. This extends the [general conventions](./general-conventions.md) with Swift-specific syntax and patterns.

## TypeScript Conventions

See [effective-typescript.md](./effective-typescript.md) — a pointer to *Effective TypeScript* (Dan Vanderkam) as the canonical TS reference. It extends the [general conventions](./general-conventions.md); TS-specific mechanics defer to the book.

## Commit Message Conventions

See [commit-conventions.md](./commit-conventions.md) for commit message standards. We follow [Conventional Commits](https://www.conventionalcommits.org/) with `topic()` scope for work-in-progress features (e.g., `feat(topic): experimental feature`).

## Repository Diagnostics

See the **Repository Diagnostics** section in [general-conventions.md](./general-conventions.md#repository-diagnostics) for a list of Git commands to run when first exploring a codebase. These help identify churn hotspots, bug clusters, and bus factors before you even open a file.

## Usage

Reference these conventions in your project README:

```markdown
## Coding Standards

This project follows the coding conventions defined in:
https://github.com/tomer-ben-david/devx-coding-standards
```

Or link to specific sections:

```markdown
See our [Swift coding conventions](https://github.com/tomer-ben-david/devx-coding-standards/blob/main/swift-conventions.md).
```

## Contributing

Contributions are welcome! If you have improvements or additional conventions to add, please open a pull request.

## License

This repository is provided as-is for reference and reuse.
