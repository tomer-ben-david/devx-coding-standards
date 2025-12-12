# Commit Message Conventions

This document outlines the commit message conventions used across projects. These conventions follow the [Conventional Commits](https://www.conventionalcommits.org/) specification, which provides a standardized format for commit messages.

## Format

```
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

## Commit Types

- **`feat`**: A new feature
- **`fix`**: A bug fix
- **`docs`**: Documentation only changes
- **`style`**: Changes that do not affect the meaning of the code (white-space, formatting, missing semi-colons, etc.)
- **`refactor`**: A code change that neither fixes a bug nor adds a feature
- **`perf`**: A code change that improves performance
- **`test`**: Adding missing tests or correcting existing tests
- **`chore`**: Changes to the build process or auxiliary tools and libraries such as documentation generation
- **`ci`**: Changes to CI configuration files and scripts
- **`build`**: Changes that affect the build system or external dependencies

## Scope

The scope is optional and provides additional contextual information about the part of the codebase affected.

Examples:
- `feat(auth): add OAuth2 support`
- `fix(api): resolve timeout issue`
- `refactor(ui): simplify component structure`

### Topic Scope Convention

You may use `topic()` as a scope to indicate work-in-progress or experimental features:

- `feat(topic): experimental feature X`
- `fix(topic): temporary workaround for issue Y`

The `topic()` scope signals that this commit is part of a larger topic or feature branch that may be squashed or rebased before merging.

## Description

The description should:
- Be written in imperative mood ("add feature" not "added feature" or "adds feature")
- Be concise but descriptive
- Not end with a period
- Start with a lowercase letter (unless it's a proper noun)

**Good examples:**
- `feat: add user authentication`
- `fix: resolve memory leak in image loader`
- `docs: update API documentation`

**Bad examples:**
- `feat: Added user authentication.` (past tense, period)
- `feat: Add User Authentication` (unnecessary capitalization)
- `feat: fix bug` (type mismatch - should be `fix`)

## Body

The body is optional and should:
- Provide additional context about the change
- Explain the "why" rather than the "what" (the description already covers the "what")
- Be separated from the description by a blank line
- Wrap at 72 characters

Example:
```
feat: add dark mode support

Implement dark mode toggle in settings with system preference
detection. Users can now switch between light and dark themes
manually or use system default.

Closes #123
```

## Footer

The footer is optional and can contain:
- Breaking changes (see below)
- Issue references: `Closes #123`, `Fixes #456`, `Refs #789`

## Breaking Changes

To indicate a breaking change, include `BREAKING CHANGE:` in the footer or append a `!` after the type/scope.

**Using footer:**
```
feat(api): change authentication method

BREAKING CHANGE: The API now requires OAuth2 instead of API keys.
All existing API key-based integrations will need to be updated.
```

**Using exclamation mark:**
```
feat!: require Node.js version >= 14

BREAKING CHANGE: The application now requires Node.js version 14 or higher.
```

## Examples

### Simple feature
```
feat: add user profile page
```

### Feature with scope
```
feat(auth): implement two-factor authentication
```

### Bug fix with body
```
fix: resolve crash on empty file upload

The application was crashing when users attempted to upload
an empty file. Added validation to check file size before
processing.

Fixes #234
```

### Breaking change
```
feat(api)!: change response format

BREAKING CHANGE: API responses now return data wrapped in a
`result` object instead of directly returning the data.
```

### Topic scope example
```
feat(topic): experimental AI integration

This is work-in-progress for the new AI feature. Will be
squashed before merging to main.
```

## Benefits

Following these conventions enables:
- **Automated changelog generation**: Tools can parse commit messages to generate changelogs
- **Semantic versioning**: Commit types correlate with version increments (fix → PATCH, feat → MINOR, BREAKING CHANGE → MAJOR)
- **Better collaboration**: Consistent commit history aids in understanding project evolution
- **Easier code review**: Clear commit messages make it easier to review changes

## References

- [Conventional Commits Specification](https://www.conventionalcommits.org/)
- [Semantic Versioning](https://semver.org/)
