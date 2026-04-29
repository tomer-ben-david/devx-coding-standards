---
name: devx-code
description: "Writes code following devx-coding-standards conventions. Reads the canonical MD files and produces convention-compliant code."
category: development
risk: safe
source: self
source_type: self
date_added: "2026-04-08"
author: tomer-ben-david
tags: [coding, conventions, implementation]
tools: [claude, cursor, gemini, codex]
---

# DevX Code

## Overview
Writes or modifies code while following the devx-coding-standards conventions. Reads the canonical markdown files to ensure all output complies with team standards.

## When to Use
- Writing new features or modules
- Refactoring existing code
- When the user asks for code that follows team conventions
- As the implementation companion to `/devx-architect` planning

## How It Works

### Step 1: Read the conventions
Read all relevant convention files from the devx-coding-standards repository. Look for them in this order:
1. Project-local: check for a local copy or subtree of `devx-coding-standards/` in the current repo
2. If the user's CLAUDE.md references `~/dev/projects/devx-coding-standards`, use that path
3. Ask the user for the location if not found

Always read:
- `general-conventions.md` — core principles
- `swift-conventions.md` — if writing Swift code
- `commit-conventions.md` — only if also writing commit messages

### Step 2: Understand the task
Before writing code, understand what's needed. Ask clarifying questions if requirements are ambiguous.

### Step 3: Write convention-compliant code
Apply all conventions from the MD files while writing code. Key areas to check:

- **Dependency Injection**: Pass dependencies explicitly via constructors. No singletons, no optional dependencies, no default values.
- **Error Handling**: Throw for exceptional cases. Use result types/optionals for expected cases. No generic catch. Fail loud.
- **Type Safety**: Prefer strong types, sealed/union types, exhaustive matching. Make invalid states unrepresentable.
- **Immutability**: Prefer `let`/`final`/`const`. Mark classes `final` unless inheritance is needed.
- **Architecture**: Composition root pattern. No delegate storage for state.
- **Data Modeling**: Domain-driven types, dumb models, centralized definitions.
- **Logging**: Structured logging. No `print()` or `console.log()`.
- **Testing**: Design for testability via DI. No test-only state or `#if DEBUG` hacks.

### Step 4: Leave code better
Apply the "Leave Code Better" principle — improve surrounding code for maintainability while implementing the feature.

## Key Rules
- Never hardcode convention rules — always read the MD files.
- If unsure about a convention, read the relevant section rather than guessing.
- **Structural fixes over patches** (ALWAYS): If you're fixing something or modifying code, fix the root cause. This applies to all edits, not just bug fixes.
- KISS and YAGNI — build only what's required, keep it simple.
