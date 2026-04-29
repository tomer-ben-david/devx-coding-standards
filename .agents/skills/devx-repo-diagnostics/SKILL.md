---
name: devx-repo-diagnostics
description: "Runs git diagnostic commands to assess repo health: churn hotspots, bug clusters, bus factor, momentum, and revert frequency."
category: analysis
risk: safe
source: self
source_type: self
date_added: "2026-04-08"
author: tomer-ben-david
tags: [git, audit, diagnostics, hotspots]
tools: [git, terminal]
---

# DevX Repo Diagnostics

## Overview
Analyzes a repository's Git history to identify technical debt, knowledge silos, and stability risks before reading code.

## When to Use
- Onboarding to a new codebase
- Starting a major refactor (identify hotspots)
- Auditing a project's health
- Investigating why a team is "slow"

## Diagnostics Commands

### 1. High Churn Hotspots
Identify files that change most frequently. High churn often correlates with technical debt and high complexity.
`git log --format=format: --name-only --since="1 year ago" | sort | uniq -c | sort -nr | head -20`

### 2. Authorship & Bus Factor
Map out who built the system and identify if knowledge is trapped with one person.
`git shortlog -sn --no-merges`
*Pro tip: Run with `--since="6 months ago"` to see who is currently active.*

### 3. Bug Clusters
Locate files with the highest density of bug-related fixes. Cross-reference with churn hotspots for the "highest risk" areas.
`git log -i -E --grep="fix|bug|broken" --name-only --format='' | sort | uniq -c | sort -nr | head -20`

### 4. Project Momentum
Scan the monthly commit count to detect declining activity or batchy release cycles.
`git log --format='%ad' --date=format:'%Y-%m' | sort | uniq -c`

### 5. Firefighting Frequency
Measure the frequency of reverts and hotfixes. High frequency indicates an unreliable deploy pipeline or lack of trust in tests.
`git log --oneline --since="1 year ago" | grep -iE 'revert|hotfix|emergency|rollback'`

## Interpretation Guide
- **High Churn + High Bug Cluster**: This is your highest-risk code. Refactor these first.
- **Top Contributor Missing in 6-month Window**: High bus factor risk. Knowledge has likely left the building.
- **Declining Momentum**: Team might be bogged down by technical debt or staffing changes.
- **Frequent Reverts**: Investigate the testing and CI/CD strategy.

## Key Rules
- Run these commands *before* opening a single source file.
- Use the output to prioritize which components to read/review first.
- Document the findings as part of the initial audit report.
