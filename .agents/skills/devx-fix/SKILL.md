---
name: devx-fix
description: "Fixes bugs using devx-coding-standards principles: root cause analysis, structural fixes, type-safety checks, and invariant encoding."
category: debugging
risk: safe
source: self
source_type: self
date_added: "2026-04-08"
author: tomer-ben-david
tags: [bug-fix, debugging, conventions]
tools: [claude, cursor, gemini, codex]
---

# DevX Fix

## Overview
Fixes bugs following the **Core Philosophy: Structural Fixes over Patches**. We always prioritize root cause analysis and encoding invariants so failures become impossible to represent.

## When to Use
- Fixing a reported bug
- Debugging unexpected behavior
- When the user says "fix" or "this is broken"
- When a test is failing and the cause is unclear

## How It Works

### Step 1: Read the conventions
Read `general-conventions.md` from the devx-coding-standards repository. Look for it in this order:
1. Project-local: check for a local copy or subtree of `devx-coding-standards/` in the current repo
2. If the user's CLAUDE.md references `~/dev/projects/devx-coding-standards`, use that path
3. Ask the user for the location if not found

Focus on the **Bug Fixing** and **Error Handling** sections.

### Step 2: Understand before fixing
Before writing any fix:
1. Read the codebase or the larger area around the bug
2. Understand the full flow — trace from entry point to failure
3. Identify the root cause, not just the symptom
4. Reproduce the failure mentally (or via tests if possible)

### Step 3: Apply the right fix level
Choose the appropriate fix:

**Structural fix** (preferred when root cause is architectural):
- State ownership issues → fix the ownership model
- Race conditions → fix the concurrency model
- Coupling issues → fix the dependency graph
- Lifecycle issues → fix the lifecycle boundaries

**Invariant encoding** (after any fix):
- Make the invariant explicit in code (typed state transitions, exhaustive matching, constrained values)
- Ensure the same class of bug cannot silently reappear

**Type-safety check** (per bug):
- Evaluate whether stronger types can prevent recurrence
- Add sealed/union types, constrained value objects, or exhaustive matching where applicable

### Step 4: No patches
- Do NOT add guard clauses around symptoms
- Do NOT add try/catch to silence failures
- Do NOT add nil checks to avoid crashes — fix why it's nil
- Do NOT add feature flags to skip broken code paths

### Step 5: Verify and deduce
- Ensure the fix doesn't introduce new issues
- Prefer deducing state from source of truth over caching/storing derived state
- If a value can be computed, compute it rather than storing it

## Key Rules
- Always read the full context around the bug before touching code
- Root cause or no fix — patches just move the problem
- After fixing, encode the invariant so it can't regress
- Leave code better than you found it
