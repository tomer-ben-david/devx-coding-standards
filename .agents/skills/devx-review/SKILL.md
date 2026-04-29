---
name: devx-review
description: "Reviews code and diffs against devx-coding-standards conventions. Reads the canonical MD files and flags violations."
category: code-review
risk: safe
source: self
source_type: self
date_added: "2026-04-08"
author: tomer-ben-david
tags: [review, conventions, code-quality]
tools: [claude, cursor, gemini, codex]
---

# DevX Code Review

## Overview
Reviews code, diffs, or pull requests against the devx-coding-standards conventions. Reads the canonical markdown files as the single source of truth — no conventions are hardcoded into this skill.

## When to Use
- Reviewing a diff, PR, or staged changes
- Auditing existing code against team conventions
- Before committing to catch violations early
- When the user asks for a code review

## How It Works

### Step 1: Read the conventions
Read all convention files from the devx-coding-standards repository. Look for them in this order:
1. Project-local: check for a local copy or subtree of `devx-coding-standards/` in the current repo
2. If the user's CLAUDE.md references `~/dev/projects/devx-coding-standards`, use that path
3. Ask the user for the location if not found

Always read these files (if they exist):
- `general-conventions.md` — core principles (DI, error handling, testing, bug fixing, etc.)
- `swift-conventions.md` — Swift/SwiftUI-specific patterns (if Swift code is being reviewed)
- `commit-conventions.md` — commit message format

### Step 2: Analyze the code
Examine the code or diff provided by the user. For each changed file, check it against every relevant convention section.

### Step 3: Report findings
Structure the review as:

**Violations** (must fix):
- `[convention-name]` Description of what's wrong and the fix. Reference the specific section from the MD.

**Suggestions** (should fix):
- `[convention-name]` Description of improvement. Reference the specific section.

Also call out PRs that are technically correct but too broad for the stated fix. If the diff adds unrelated refactors, extra behavior changes, or fallback paths that make the review harder to follow, recommend trimming the change set so it stays reviewable.

**Positive** (worth noting):
- Things done well per the conventions.

### Step 4: Fix if asked
If the user wants fixes applied, modify the code to comply with the conventions while preserving intent.

## Key Rules
- Never hardcode convention rules — always read the MD files fresh so edits to conventions are immediately reflected.
- If a convention file is missing, note it but review against what's available.
- Prioritize violations by severity: structural/architectural issues > style issues > nitpicks.
- Reference specific sections (e.g., "see general-conventions.md#dependency-injection") so the user can look up the rule.

## Scope Notes
- For Swift code, apply both `general-conventions.md` and `swift-conventions.md`.
- For other languages, apply `general-conventions.md` only (it's language-agnostic).
- For commit messages, apply `commit-conventions.md`.
