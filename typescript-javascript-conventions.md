# TypeScript / JavaScript Conventions

This document covers TypeScript and JavaScript-specific conventions. For general coding principles that apply to all languages, see [general-conventions.md](./general-conventions.md). For deeper TypeScript type-system guidance, see [effective-typescript.md](./effective-typescript.md).

## Anti-slop patterns (low-evidence TS/JS)

These rules summarize [anti-slop](https://github.com/dmmulroy/anti-slop) — opinionated Oxlint rules that reject low-evidence, low-signal patterns. They apply to **both TypeScript and JavaScript**. Vendor the plugin into each repo (see the anti-slop README); the list below is the review checklist.

### Type safety and assertions

- **No chained type assertions** — reject `input as object as User`; chains of only `as const` are fine.
- **No widen-then-assert** — reject flowing a known value to `unknown`/`any`/`object` and asserting it back narrower later.
- **Document non-const assertions** — every `as` (not `as const`) needs a nearby `// SAFETY: <invariant justification>` (or configured marker).
- **No `unknown` on function contracts** — reject `unknown` parameters (except the `cause` convention and the exact subject of a type predicate), `unknown` returns, and type aliases that resolve to `unknown`.
- **No `object` parameters** — reject bare `object`, unions containing it, or generic aliases that resolve to it on inputs.
- **No unsafe dictionary types** — reject `Record<string, unknown>`, `{ [key: string]: object }`, and similar open dictionaries with weak value types. Generic constraints like `T extends Record<string, unknown>` are fine.

### Parsing and reflection

- **Parse at boundaries, not with `typeof`** — reject ad hoc `typeof` narrowing; use schema/boundary parsing. Existence probes (`typeof document === "undefined"`) are allowed.
- **No `Reflect.apply` / `Reflect.get`** — use typed function calls and property access (or boundary parsing at the edge).

### Objects and spreads

- **No conditional empty object spread** — reject `...(x !== undefined ? { x } : {})`; omission is not the same as `undefined`.
- **No known-value widening** — do not widen inferred object keys into loose `Record<string, Handler>` targets; preserve inference or use `satisfies`.

### Testing and naming

- **No module mocking** — reject Vitest/Jest `mock` / `doMock` / `unstable_mockModule`; use real dependency seams.
- **No `shape` in local symbol names** — reject locally owned identifiers containing `shape` (case-insensitive). Static members like `schema.shape` are fine.

### Optional: Effect projects

If the repo uses [Effect](https://effect.website/), enable the opt-in Effect rule group:

- **No service constructor imports** — runtime callers import the owning Layer and `yield` the service; `*.test.*` / `*.spec.*` may import constructors directly.

For Oxlint setup, rule names, violation examples, and vendoring steps, see the [anti-slop repository](https://github.com/dmmulroy/anti-slop).
