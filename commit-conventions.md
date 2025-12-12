# Commit Message Conventions

This project follows the [Conventional Commits](https://www.conventionalcommits.org/) specification.

## Format

```
<type>[optional scope]: <description>
```

## Examples

- `feat(login): add OAuth2 authentication`
- `fix(api): resolve timeout issue`
- `feat(topic): experimental feature X` - Use `topic()` scope for work-in-progress features
- `refactor(ui): simplify component structure`

## Commit Types

- `feat`: A new feature
- `fix`: A bug fix
- `docs`: Documentation only changes
- `style`: Code style changes (formatting, etc.)
- `refactor`: Code refactoring
- `test`: Adding or updating tests
- `chore`: Maintenance tasks

For breaking changes, append `!` after the type/scope: `feat!: change API response format`

See [Conventional Commits](https://www.conventionalcommits.org/) for the full specification.
