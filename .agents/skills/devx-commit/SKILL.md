---
name: devx-commit
description: "Formats commit messages following devx-coding-standards commit conventions. Reads the canonical MD file and produces compliant messages."
category: git
risk: safe
source: self
source_type: self
date_added: "2026-04-08"
author: tomer-ben-david
tags: [commit, git, conventions]
tools: [claude, cursor, gemini, codex]
---

# DevX Commit

## Overview
Creates properly formatted commit messages following the devx-coding-standards commit conventions. Reads the canonical `commit-conventions.md` as the source of truth.

## When to Use
- Before creating a commit
- When writing commit messages for staged changes
- When the user says "commit" or "make a commit"
- To reformat an existing commit message

## How It Works

### Step 1: Read the conventions
Read `commit-conventions.md` from the devx-coding-standards repository. Look for it in this order:
1. Project-local: check for a local copy or subtree of `devx-coding-standards/` in the current repo
2. If the user's CLAUDE.md references `~/dev/projects/devx-coding-standards`, use that path
3. Ask the user for the location if not found

### Step 2: Analyze the changes
Look at the staged/unstaged changes to understand:
- What was changed
- Why it was changed (from code context, not just diffs)
- The scope/area of impact

### Step 3: Format the commit message
Follow the conventions from `commit-conventions.md`. Key rules from the standard:

- Use [Conventional Commits](https://www.conventionalcommits.org/) format
- Use `topic()` scope for work-in-progress features (e.g., `feat(topic): experimental feature`)
- Message should explain the "why", not the "what" — the diff shows what changed

### Step 4: Confirm and commit
Show the proposed commit message to the user before committing.

## Key Rules
- Never hardcode convention rules — always read `commit-conventions.md`
- The commit message is about intent, not implementation details
- Keep the subject line under 72 characters
- If the change is complex, use a body to explain the motivation
