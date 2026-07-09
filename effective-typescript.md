# Effective TypeScript

TypeScript-**specific** reference. For the general principles that apply to *all*
languages — type safety, structural fixes, error handling, observability
separation, review format — read **[general-conventions.md](./general-conventions.md)**.
This file does **not** repeat them; it only adds the TS-specific pointer.

## Canonical reference

Follow **[Effective TypeScript, 2nd Edition](https://www.oreilly.com/library/view/effective-typescript-2nd/9781098155056/)**
(Dan Vanderkam, 83 items) as the authoritative source for TS best practices. When
general-conventions.md says "prefer stronger type safety," the *how* is the items
in this book. Author site: <https://effectivetypescript.com/>.

## How to read it alongside the general conventions

| general-conventions.md principle | Effective TypeScript items to consult |
|---|---|
| Prefer stronger type safety (sealed/union types, exhaustive matching) | The type-inference, union, and discriminated-union items |
| Encode invariants in the type system | The items on `unknown` vs `any`, type guards, and branded types |
| Structural fixes over patches | The items favoring ECMA features over TS-only runtime features (relevant as Node strips types natively) |

When in doubt, defer to the book. Do not invent patterns weaker than what
general-conventions.md and the book describe.
