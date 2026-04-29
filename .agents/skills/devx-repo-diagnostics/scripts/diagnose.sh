#!/bin/bash

# DevX Repo Diagnostics Script
# Runs a suite of Git commands to audit codebase health.

set -e

echo "========================================"
echo "🚀 Running DevX Repo Diagnostics"
echo "========================================"

echo ""
echo "🔥 1. HIGH CHURN HOTSPOTS (Top 20 most changed files in last year)"
echo "--------------------------------------------------------"
git log --format=format: --name-only --since="1 year ago" | sort | uniq -c | sort -nr | head -20

echo ""
echo "👥 2. AUTHORSHIP & BUS FACTOR (All-time vs Last 6 months)"
echo "--------------------------------------------------------"
echo "--- ALL TIME ---"
git shortlog -sn --no-merges | head -10
echo ""
echo "--- LAST 6 MONTHS ---"
git shortlog -sn --no-merges --since="6 months ago" | head -10

echo ""
echo "🐞 3. BUG CLUSTERS (Top 20 files with bug-related commits)"
echo "--------------------------------------------------------"
git log -i -E --grep="fix|bug|broken" --name-only --format='' | sort | uniq -c | sort -nr | head -20

echo ""
echo "📉 4. PROJECT MOMENTUM (Commit count by month)"
echo "--------------------------------------------------------"
git log --format='%ad' --date=format:'%Y-%m' | sort | uniq -c

echo ""
echo "🚒 5. FIREFIGHTING FREQUENCY (Reverts and hotfixes in last year)"
echo "--------------------------------------------------------"
git log --oneline --since="1 year ago" | grep -iE 'revert|hotfix|emergency|rollback' || echo "No firefighting patterns detected."

echo ""
echo "========================================"
echo "✅ Diagnostics Complete"
echo "========================================"
