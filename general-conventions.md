# General Coding Conventions

These coding conventions apply to all programming languages. The core philosophy is to build robust, maintainable systems by prioritizing deep architectural integrity over surface-level fixes.

## #1 RULE: Prefer the best / long-term design over the quick / short-term one — and ignore human-shaped effort estimates

**This is the #1 rule because it is the one agents violate most often.** Always favor the real best, long-term design over a quicker-to-implement short-term design. Do not pick a solution because it takes less time to write when a better long-term design exists. "Best design" is the broad framing; "structural fix over non-structural patch" is the common instance of it. When the root cause points at a structural change, implement the structural fix — e.g. page order must be rewritten into the PDF itself, not parked in a `reorder` column read instead (a second source of truth that will diverge). The same applies at the design level: prefer the design that will still be right in a year over the one that ships ten minutes sooner.

**Ignore human-style effort estimates.** Agents routinely self-censor the best design by estimating it like a human would ("that's a big change, risky, hours of work") and then proposing a smaller, quicker design. An agent can do in minutes what a human budgets in hours. **Do not let a human-shaped effort estimate steer you away from the best long-term solution.** Judge a design by correctness, structure, and longevity — not by perceived implementation time.

This is the inverse caution to #2: #2 says don't *over*-engineer; this says don't *under*-engineer into a short-term design. The deciding question is **"which design is the best long-term one?"** — implementation time is not a valid input to that decision.

- Re-ask: **"Am I avoiding the best/long-term design because it feels big? Is that 'big' a real cost or a human-shaped estimate?"**
- Re-ask: **"Does this short-term design create a second source of truth, a workaround, or tech debt that must be maintained forever?"** If yes, prefer the long-term design.
- A larger design that is correct and durable is better than a small one that leaves the root cause in place or stores up debt.
- State the trade-off explicitly to the user (long-term best vs. short-term quick), then default to the long-term one unless they say otherwise.

## #2 RULE: When stuck or over-complex, rethink — look for the simpler overlooked solution

When a problem becomes too complex, the fix keeps growing (A needs B needs C...), or you find yourself banging your head against the same solution — **STOP and rethink.** "Think outside the box" here does NOT mean unconventional or over-engineered. In most cases it means a **simple, effective solution you just didn't consider.** We frequently tunnel-vision on escalating fixes and miss that a much smaller solution exists.

- Re-ask: **"What is the ACTUAL problem, and what is the MINIMAL change that solves just that?"**
- Re-ask: **"Are we assuming a path that a simpler alternative would sidestep?"**
- Don't defend the current direction — genuinely reconsider alternatives.
- Favor the smallest correct fix over a clever, design-heavy, or unconventional one.

This is KISS/YAGNI enforced through *active re-thinking*, not passive compliance. Over-engineering and over-design are constant risks; the overlooked simple path is usually the right one.

## #3 RULE: Prove the user-visible outcome before implementing

Before writing any fix, prove the actual **user-visible** outcome with the simplest possible check (a screenshot, a UI count, a log of what the user sees). Never assume an API-level or intermediate number ("the API returns 23") equals what the user sees ("the UI shows 1") — merge, filter, grounding, grouping, dedup, and UI collapse all sit between them. These layers routinely diverge. If you cannot first show the user-visible improvement with the simplest possible check, do not implement — you will polish the wrong layer. This is "prove before building" applied to the **end of the pipeline**, not just the start.

## Code Review Preface (read this first)

Use this section when reviewing a branch against `main` (or any PR). It scopes *what* to review and *how* to judge readability. Pair it with the rest of this document.

### Goal and non-goals (read both before reviewing)

Every review starts with an explicit **goal** and **non-goals**, supplied by the author or PR description. State both in your report so findings stay scoped.

> **Goal:** _&lt;one sentence — what this branch/PR is trying to solve&gt;_

> **Non-goals:** _&lt;bullets — what this review must NOT spend time on&gt;_

Example goal: _Add RexIDE git review workflow (branch switch, pull, named local Codex + ChatGPT review panes) and preserve embedded JCEF browser state across pane maximize/restore._

Example non-goals:

- Bug hunting, edge cases, and runtime validation (other reviewers handle that)
- Pre-existing issues already on `main` (review branch-introduced changes only)
- Splitting the PR for size when the author accepted a larger scope
- Drive-by refactors outside the stated goal

**Do not file findings that fall under the stated non-goals.** If something outside scope is worth noting, label it _out of scope_ and do not count it toward merge confidence.

### Scope: branch-introduced changes only

- Review **only code this branch adds or changes** vs the base branch (`main`, etc.).
- Do **not** flag pre-existing issues already on `main`. If `main` was bad, it was bad — your target is whether **our new commits** are good.

### Focus: clarity, readability, and these conventions

You are reviewing whether the **new** code is clear, readable, and aligned with this document — especially:

- SRP, DRY, KISS, YAGNI (see [General Principles](#general-principles))
- Structural root-cause fixes over patches (see [Core Philosophy](#core-philosophy-structural-fixes-over-patches))
- Small, reviewable change sets (see [Reviewable Change Sets](#general-principles))
- Intent-revealing names and flat control flow

Also note where the branch **did well** against these standards, not only violations.

### Anti-patterns to watch (common in AI-generated code)

The implementing agent is often capable but tends toward code that is hard to review. Flag branch-introduced instances of:

| Trap | What to look for |
|------|------------------|
| **Over-complex / cryptic / over-engineered** | Clever abstractions, deep nesting, magic behavior |
| **Too many fallbacks** | Silent degradation, generic catch, swallowed errors |
| **SRP / DRY violations** | God functions, duplicated readiness/rules across UI entry points |
| **Unclear code** | Names that hide intent; nullable flags instead of explicit models |
| **Whack-a-Mole / reactive patching** | Guards and one-off fixes at the symptom layer |
| **Cover-up fixes** | Null checks, reload skips, `singleOrNull` silence — instead of encoding invariants |
| **Overly specific tests** | Tests that mirror production structure instead of user-visible behavior |

When you find these, say what **structural** change would improve PR readability (split PR, sealed types, extract workflow step, etc.) — not a list of micro-edits.

### Review output format

1. **Findings** — P1/P2/P3, file/area, branch-introduced only  
2. **What went well** — where the branch matches these conventions  
3. **PR readability** — 2–3 sentences overall  
4. **Structural improvements** — what you would do to make the PR easier to read and trust (no drive-by refactors)  
5. **Merge confidence (standards/clarity)** — yes / medium / no  

Do not change files unless explicitly asked. Report only.

### Reproducibility / guarantees audit (a distinct review dimension)

Diff review catches *changes that are wrong*; it does **not** catch *system properties that were never encoded* (a guarantee that lives only in a runbook, or only "by coincidence" of a default). Run this as a separate pass, not folded into the diff walk:

For each thing the PR claims is true after merge (engine/dependency versions, schema state, feature flags + their defaults, rollback path, index presence, etc.), answer: **where is it enforced, and is that enforcement automatic or human?** Tag each guarantee: `IaC` / `migration` / `code` / `runbook (manual)` / `implicit (default/coincidence)`. Any guarantee tagged `runbook` or `implicit` is a reproducibility risk — a fresh account/environment depends on an operator remembering it, or on a default not changing. Flag those: either encode them (IaC/migration/code) or explicitly accept the manual step with the reason. This catches the class of gap a diff review structurally cannot (e.g., "engine version pinned in IaC but the extension version is a manual runbook step → fresh account isn't deterministic").

## Core Philosophy: Structural Fixes over Patches

**We always prefer structural fixes and root cause analysis over patches.** This applies to all edits, not just bug fixes.

- **Prove the problem before building.** Whether it's a bug fix or a feature, confirm the assumed cause/need with real evidence (logs, data, a repro) before writing code. A change built on an unverified hypothesis solves the wrong problem and wastes the whole review cycle.
- **No Symptoms**: Do not treat symptoms (e.g., adding a null check, a catch block, or a guard clause).
- **Fix the Root**: Find the underlying architectural reason why a failure is possible (e.g., state ownership, lifecycle mismatch, coupling) and fix it at the source.
- **Encode Invariants**: Once fixed, encode the invariant in the type system or architecture so the failure mode becomes impossible to represent.
- **Leave it Better**: Every edit is an opportunity to improve the structure. If you find a patch, replace it with a structural fix.

## Dependency Injection

### Prefer Dependency Injection

Pass services/clients explicitly.

- **No Default Values**: Avoid `init(service: Service = .shared)`. Force the caller to provide the dependency.
- **No Empty Constructors**: Do not provide `private init() {}` just to satisfy a singleton if it leaves the object uninitialized.
- **Avoid Global Singletons**: Minimize `static let shared`. Create instances at the app root and pass them down.

### Singleton Lifecycle

If a singleton is necessary, use a "Fail Fast" pattern.

- **Do**: `static var shared: Service!`. Configure it once at app launch. Crash if accessed too early.
- **Don't**: `static var shared { get { ... } set { ... } }`. Avoid lazy creation of "fake" instances or mutable setters just for tests.

### Side-Effect Isolation

Dependencies with user-visible side effects (notifications, alerts) must be injected via protocols to allow No-op substitutes.

### Constructor Injection

Prefer injecting dependencies via `init` parameters over setter injection.

- **Do**: `init(service: ServiceProtocol)` with `private let service: ServiceProtocol`
- **Don't**: `var service: ServiceProtocol?` with setter or property assignment after init

Constructor injection ensures immutability, required dependencies, and no invalid intermediate states.

### No Optional Dependencies

If a dependency is needed, make it required—not optional.

- **Don't**: `upgradePrompter?.openCheckout()` — guessing if it's initialized adds uncertainty.
- **Do**: `upgradePrompter.openCheckout()` — we know it's there, no guessing.

If the dependency is truly optional (feature flag, graceful degradation), document why explicitly.

## DRY & Shared Components (Guidance)

- **Extract Shared Logic**: Prefer extracting UI patterns or business logic to shared components when they appear in multiple locations to maintain a single source of truth.
- **Avoid Duplication**: Keep an eye out for duplicate "clever" logic or magic constants and consolidate them into utilities or shared components when appropriate.

## Test Isolation

- **Avoid Macros**: Minimize `#if DEBUG`. Do not use it to expose private state or change logic for tests.
- **Test Fresh Instances**: Do not test global singletons (`.shared`). Instantiate a fresh instance of the class under test with mock dependencies.
- **No Test‑Only State**: Keep production classes free of "test‑only" mutable properties. Tests should inject their own stateful mocks.

## Testing Philosophy

- **Local E2E**: Prefer integration-style tests that exercise full flows (e.g., ViewModel → Service → Client) using in-memory fakes. Avoid testing implementation details; test user-facing behavior.
- **Do Not Mirror Production Models in Tests**: Tests should not define parallel DTOs, schemas, summaries, or field lists that duplicate production models/read APIs. Prefer production readers/selectors and infer fixture return types from builders or seed functions so production field changes fail in one obvious place.
- **Builder Defaults over Fixture Dumps**: For deterministic test data, use small builders with clear defaults and targeted overrides instead of large static JSON blobs or repeated object literals. Builders should create only source facts; production code should still derive keys, links, fingerprints, deduplication, and enriched state.

## Architecture & State

- **Composition Root**: Wire up all dependencies in a single location (e.g., `App.init`, `main()`, application entry point) rather than scattering initialization logic. Initialize and own core dependencies (Stores, Managers) at the application root.
- **No Delegate Storage**: Avoid storing app state in delegates. Use delegates only for system lifecycle events, not as a dependency container.
- **Static Helpers**: Avoid `static var` dependencies in helper enums/structs. Pass dependencies as method arguments (Method Injection) or convert the helper to an injectable service.

## Type Safety & State Machines

- Prefer stronger type safety (for example sealed/union types and exhaustive matching) so invalid states or unhandled transitions fail at compile time whenever practical.

## Control Flow Readability

- **Guard Clauses**: Prefer clear early-return guards at the start of functions for preconditions, with one reason per guard, so the main logic stays flat.

## Data Modeling

- **Domain-Driven**: Use explicit types for domain concepts (e.g., `User`, `Order`) instead of primitives or dictionaries.
- **Separation of Concerns**: Keep data models dumb. They should hold data, not business logic or side effects.
- **Centralized Definitions**: Define shared data models in a dedicated `Models/` directory, not nested inside other types or service files.
- **Serialization**: Prefer built-in serialization mechanisms (e.g., `Codable` in Swift, `Serializable` in Java) for data models to simplify logging, debugging, and persistence.

## Migrations Policy

- **No Migrations by Default (Pre-Launch)**: Assume there are no real users yet unless explicitly stated otherwise. Do not add schema/data/state migrations by default.
- **Ask for Explicit Confirmation First**: Before adding any migration logic, ask the owner for explicit confirmation.
- **Prefer Clean Replacement Early**: In pre-launch projects, prefer direct model/schema replacement over compatibility shims.
- **No Silent Compatibility Paths**: Do not add hidden auto-migration, legacy enum remapping, or backward-compatibility fallbacks unless explicitly approved.

## Error Handling

- **Exceptions for Exceptional Cases**: Use exceptions only for exceptional/error conditions, not for normal business flow (e.g., account_inactive, channel not found). Prefer result types or optionals for expected business cases.
- **Propagate Errors**: Do not catch errors internally unless you can fully recover from them. Let them throw to the caller.
- **Cleanup Without Recovery**: Use `finally`/`defer` only for mandatory cleanup (for example locks, in-flight maps, temp resources). Do not swallow or transform the original failure; let it propagate.
- **Avoid Generic Catch**: Avoid `catch { print(error) }`. If you catch, handle specific errors or rethrow.
- **Fail Loud by Default**: Prefer fast, explicit failures for violated invariants, missing required dependencies or configuration, security or data-integrity risk, and errors the current layer cannot safely recover from. This is not a blanket rule to crash or remove intentional graceful degradation in user-facing or production systems. When a review recommends replacing an explicit recovery path with a hard failure, classify it as an **optional product-policy recommendation** unless the current behavior demonstrably hides a broken required path, corrupts data, weakens security, or violates an explicit product contract. Put optional recommendations under **Structural improvements**, not **Findings**, and do not reduce merge confidence for them; state the availability and user-experience tradeoff instead.
- **Config as Constants, Not Env**: Non-secret configuration (thresholds, tuning knobs, feature behavior) belongs as constants in the code — do not read it from environment variables with fallbacks to constants. Only secrets and genuine deployment-time values stay as env.

## Logging & Observability

- **Structured Logging**: Use structured logging with canonical metadata keys (e.g., `serviceId`, `outcome`) for critical paths. **No `print()` or `console.log()`**.
- **Preserve Exception Context**: When logging exceptions, include the full exception object (stack trace and message), not just `e.getMessage()`. Log the entire exception to preserve debugging context.
- **Monitoring/metrics live in their own module, not inline in the feature file.** Calculation and emission of metrics/telemetry (counters, contribution rank, phase timings, tag construction) belongs in `lib/observability/<thing>-metrics.ts` (matching `grafana-metrics-push.ts`, `metrics.ts`, `metrics-environment.ts`). The feature file should contain **one call** — `recordX(...)` / `enqueueX(...)` — not the metric logic itself. Do not let instrumentation bloat the orchestrator: if the feature file grows metric/telemetry code beyond a single call site, extract it to `lib/observability/`. This keeps business logic readable and lets metric logic be reviewed/tested in isolation.
- **The metrics transport (queue, batch, retry, wire format) is generic infrastructure; feature-specific metric construction does not live in it.** Keep the two concerns in separate modules so a backend change never couples to a product-telemetry change.

## Concurrency

- **Explicit Threading**: Be explicit about which thread/actor context code runs on. Background work must explicitly hop back to the main/UI thread when needed.
- **No Sleep-Based Coordination**: Avoid `sleep`/`Thread.sleep` for readiness or sequencing; wait on deterministic signals instead.

## Repository Diagnostics

Before reading a single file in a new codebase, use these diagnostic commands to understand the project's health and hotspots.

- **High Churn Hotspots**: Identify the most frequently changed files (often where technical debt clusters).
  `git log --format=format: --name-only --since="1 year ago" | sort | uniq -c | sort -nr | head -20`
- **Authorship & Bus Factor**: Map out key contributors and potential knowledge silos.
  `git shortlog -sn --no-merges`
- **Bug Clusters**: Locating files with the highest density of bug-related fixes.
  `git log -i -E --grep="fix|bug|broken" --name-only --format='' | sort | uniq -c | sort -nr | head -20`
- **Project Momentum**: Commit count by month to scan for declining rhythm or spikes.
  `git log --format='%ad' --date=format:'%Y-%m' | sort | uniq -c`
- **Stability & Firefighting**: Frequency of reverts and hotfixes (indicates trust in the deploy process).
  `git log --oneline --since="1 year ago" | grep -iE 'revert|hotfix|emergency|rollback'`

## Bug Fixing

Align all bug fixing with the **Core Philosophy: Structural Fixes over Patches**.

- **Root Cause Analysis**: Before fixing a bug, read the whole codebase or larger areas around the bug. Understand the full flow before applying a fix.
- **Prove the Cause Before Building the Fix**: Confirm the diagnosis with real evidence (a repro, logs, DB values, a worked example) *before* writing code. A fix built on an unverified hypothesis solves the wrong problem and wastes the review cycle. State the proof (e.g. "field A = X, field B = Y, so the substitution is real") before any edit.
- **Deduce, Don't Store**: Prefer deducing state from the source of truth rather than caching/storing state that can become stale. If a value can be computed from existing data, compute it.
- **Type-Safety Check**: For each fix, evaluate whether stronger types (e.g., constrained value objects, sealed unions) can prevent the same bug class from recurring.

## General Principles

- **Leave Code Better**: Always leave the code in a better state than you found it—refactor surrounding code for maintainability while fixing bugs or adding features.
- **Reviewable Change Sets**: Keep each PR small and focused. If a change is functionally correct but adds unrelated refactors, extra fallbacks, or behavior that is not needed for the stated fix, trim it so the review surface stays clear.
- **Intent-Revealing Names**: Name functions, variables, constants, enums, and types for the domain concept or behavior they represent. A reader seeing the code for the first time should understand what role the identifier plays and why it exists, not only decode what value it stores or what implementation detail it touches.
- **DRY** (Don't Repeat Yourself): Ensure each piece of logic has a single representation.
- **Immutability & Finality**: Prefer immutability where possible. Mark classes as `final` unless inheritance is required. Prefer value types over reference types where applicable.
- **Constructors over Setters**: Prefer immutability and constructor initialization over setters unless setters genuinely make more sense for the use case.
- **KISS** (Keep It Simple, Stupid): Prioritize simplicity and avoid over‑engineering.
- **Simplicity over Caching**: Prefer clear, minimal state and derive from source-of-truth data when possible, even if it costs some performance. Use caches/indexes only when they provide clear, measured value. **Cache skepticism (enforcement):** when a PR introduces a cache (memoization, module-level `??=`, process-lifetime/request dedup), do not accept it on the author's say-so. Require a real measurement of the un-cached cost (EXPLAIN, timed run). Several caches were removed after proving the un-cached path was ~50-100ms - negligible. Default: remove the cache unless the un-cached cost is proven material at scale; if it stays, it must have a clear invalidation path (no process-lifetime stickiness, no silent stale/poisoned state). A cache that silently disables a feature on a transient error is worse than re-running a 50ms query.
- **SOLID**: Apply the five SOLID principles for flexible architecture.
- **YAGNI** (You Aren't Gonna Need It): Build only what is currently required.

When reviewing TypeScript code, use [Effective TypeScript](https://effectivetypescript.com/) as an additional language-specific reference after applying these general conventions.
