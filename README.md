# Shared GitHub Workflows

This repository centralizes shared GitHub Actions workflows. Currently it contains the Discord notifications workflow that listens to pushes, issues, PRs, comments, reviews, and a manual trigger.

## Usage
- Secrets: by default the workflow reads `DISCORD_WEBHOOK_URL`. To use a different secret name, set repo variable `DISCORD_WEBHOOK_SECRET_NAME` to the desired secret key and add that secret to the repo.
- Triggers: push to `main`/`master`, issue/PR/review events, and `workflow_dispatch` (with optional `commit_sha`).
- Location: subtree the repo directly into `.github/workflows` so GitHub discovers the workflow at `.github/workflows/discord-notifications.yml`.

## Dogfooding
- This repo now runs the same workflow from `.github/workflows/discord-notifications.yml` so pushes/issues/PRs here notify Discord too.
- Keep `discord-notifications.yml` and `.github/workflows/discord-notifications.yml` identical; run `cp discord-notifications.yml .github/workflows/discord-notifications.yml` after edits.
- Add the repo secret `DISCORD_WEBHOOK_URL` (or whatever `DISCORD_WEBHOOK_SECRET_NAME` points to) with your Discord webhook URL so notifications fire.

## Subtree commands
Replace `<remote>` with the remote/URL for this repo (local path or GitHub remote) and run from a consumer repo.

```sh
git remote add shared-githubworkflows <remote>
# First add
git subtree add --prefix .github/workflows shared-githubworkflows main --squash
# To pull updates later
git subtree pull --prefix .github/workflows shared-githubworkflows main --squash
```
