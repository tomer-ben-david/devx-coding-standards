# General Coding Conventions

These coding conventions apply to all programming languages. The core philosophy is to build robust, maintainable systems by prioritizing deep architectural integrity over surface-level fixes.

## Core Philosophy: Structural Fixes over Patches

**We always prefer structural fixes and root cause analysis over patches.** This applies to all edits, not just bug fixes.

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
- **Fail Loud by Default**: Prefer fast, explicit failures. Do not add silent fallbacks or degradation paths unless explicitly required.

## Logging & Observability

- **Structured Logging**: Use structured logging with canonical metadata keys (e.g., `serviceId`, `outcome`) for critical paths. **No `print()` or `console.log()`**.
- **Preserve Exception Context**: When logging exceptions, include the full exception object (stack trace and message), not just `e.getMessage()`. Log the entire exception to preserve debugging context.

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
- **Deduce, Don't Store**: Prefer deducing state from the source of truth rather than caching/storing state that can become stale. If a value can be computed from existing data, compute it.
- **Type-Safety Check**: For each fix, evaluate whether stronger types (e.g., constrained value objects, sealed unions) can prevent the same bug class from recurring.

## General Principles

- **Leave Code Better**: Always leave the code in a better state than you found it—refactor surrounding code for maintainability while fixing bugs or adding features.
- **Reviewable Change Sets**: Keep each PR small and focused. If a change is functionally correct but adds unrelated refactors, extra fallbacks, or behavior that is not needed for the stated fix, trim it so the review surface stays clear.
- **DRY** (Don't Repeat Yourself): Ensure each piece of logic has a single representation.
- **Immutability & Finality**: Prefer immutability where possible. Mark classes as `final` unless inheritance is required. Prefer value types over reference types where applicable.
- **Constructors over Setters**: Prefer immutability and constructor initialization over setters unless setters genuinely make more sense for the use case.
- **KISS** (Keep It Simple, Stupid): Prioritize simplicity and avoid over‑engineering.
- **Simplicity over Caching**: Prefer clear, minimal state and derive from source-of-truth data when possible, even if it costs some performance. Use caches/indexes only when they provide clear, measured value.
- **SOLID**: Apply the five SOLID principles for flexible architecture.
- **YAGNI** (You Aren't Gonna Need It): Build only what is currently required.
