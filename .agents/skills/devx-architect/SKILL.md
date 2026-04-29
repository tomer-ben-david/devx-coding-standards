---
name: devx-architect
description: "Designs architecture following devx-coding-standards principles: dependency injection, composition roots, state management, and type safety."
category: architecture
risk: safe
source: self
source_type: self
date_added: "2026-04-08"
author: tomer-ben-david
tags: [architecture, design, conventions, di]
tools: [claude, cursor, gemini, codex]
---

# DevX Architect

## Overview
Designs and reviews software architecture following the devx-coding-standards principles. Focuses on dependency injection, composition roots, state management, type safety, and separation of concerns.

## When to Use
- Designing a new module or feature
- Planning a refactor or architectural change
- Setting up project structure
- When the user asks "how should I structure this?"
- Before implementation with `/devx-code`

## How It Works

### Step 1: Read the conventions
Read all relevant convention files from the devx-coding-standards repository. Look for them in this order:
1. Project-local: check for a local copy or subtree of `devx-coding-standards/` in the current repo
2. If the user's CLAUDE.md references `~/dev/projects/devx-coding-standards`, use that path
3. Ask the user for the location if not found

Always read:
- `general-conventions.md` — all sections (DI, Architecture & State, Type Safety, Data Modeling, Error Handling, Concurrency)
- `swift-conventions.md` — if designing Swift/SwiftUI architecture

### Step 2: Analyze requirements
Understand what's being built. Ask about:
- Dependencies and external services
- State lifecycle (who owns what, when is it created/destroyed)
- Concurrency requirements
- Error scenarios vs normal flow
- Testing requirements

### Step 3: Design following conventions
Apply these architectural principles from the conventions:

**Composition Root**:
- Wire all dependencies in a single location (app entry point)
- No scattered initialization logic
- App root owns core dependencies

**Dependency Injection**:
- All dependencies passed via constructors — no singletons, no optional deps, no default values
- Constructor injection over setter injection
- Protocols/interfaces for side-effect isolation

**State Management**:
- No delegate storage for app state
- No `static var` dependencies in helpers
- Explicit thread/actor context for all code
- Deduce state from source of truth, don't cache

**Type Safety**:
- Use sealed/union types and exhaustive matching
- Make invalid states unrepresentable at compile time
- Strong types for domain concepts, no primitives

**Data Modeling**:
- Domain-driven types in centralized `Models/` directory
- Dumb models — data only, no business logic
- Built-in serialization mechanisms

### Step 4: Present the design
Show:
1. Module/component diagram (ASCII or text)
2. Key interfaces/protocols
3. Dependency graph
4. Composition root wiring
5. Error handling strategy
6. Thread/actor boundaries

## Key Rules
- Never hardcode convention rules — always read the MD files
- Every dependency must be injectable and passed explicitly
- If you can't draw a clean dependency graph, the architecture needs work
- Simplicity over caching — prefer computing derived state
- YAGNI — design for what's needed now, not hypothetical future needs
