# General Coding Conventions

These coding conventions apply to all programming languages. Examples shown use Swift syntax, but the principles are language-agnostic.

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

## Architecture & State

- **Composition Root**: Wire up all dependencies in a single location (e.g., `App.init`) rather than scattering initialization logic.
- **No Delegate Storage**: Avoid storing app state in delegates. Use delegates only for system lifecycle events, not as a dependency container.
- **Static Helpers**: Avoid `static var` dependencies in helper enums/structs. Pass dependencies as method arguments (Method Injection) or convert the helper to an injectable service.

## Data Modeling

- **Domain-Driven**: Use explicit types for domain concepts (e.g., `User`, `Order`) instead of primitives or dictionaries.
- **Separation of Concerns**: Keep data models dumb. They should hold data, not business logic or side effects.
- **Centralized Definitions**: Define shared data models in a dedicated `Models/` directory, not nested inside other types or service files.
- **Serialization**: Prefer built-in serialization mechanisms (e.g., `Codable` in Swift, `Serializable` in Java) for data models to simplify logging, debugging, and persistence.

## Error Handling

- **Exceptions for Exceptional Cases**: Use exceptions only for exceptional/error conditions, not for normal business flow (e.g., account_inactive, channel not found). Prefer result types or optionals for expected business cases.
- **Propagate Errors**: Do not catch errors internally unless you can fully recover from them. Let them throw to the caller.
- **Avoid Generic Catch**: Avoid `catch { print(error) }`. If you catch, handle specific errors or rethrow.

## Logging & Observability

- **Structured Logging**: Use structured logging with canonical metadata keys (e.g., `serviceId`, `outcome`) for critical paths. **No `print()` or `console.log()`**.
- **Preserve Exception Context**: When logging exceptions, include the full exception object (stack trace and message), not just `e.getMessage()`. Log the entire exception to preserve debugging context.

## Concurrency

- **Explicit Threading**: Be explicit about which thread/actor context code runs on. Background work must explicitly hop back to the main/UI thread when needed.

## Bug Fixing

- **Root Cause Analysis**: Before fixing a bug, read the whole codebase or larger areas around the bug. Understand the full flow before applying a fix.
- **No Patches**: Avoid quick workarounds that treat symptoms. Find and fix the root cause.
- **Deduce, Don't Store**: Prefer deducing state from the source of truth rather than caching/storing state that can become stale. If a value can be computed from existing data, compute it.

## General Principles

- **DRY** (Don't Repeat Yourself): Ensure each piece of logic has a single representation.
- **Immutability & Finality**: Prefer immutability where possible. Mark classes as `final` unless inheritance is required. Prefer value types over reference types where applicable.
- **Constructors over Setters**: Prefer immutability and constructor initialization over setters unless setters genuinely make more sense for the use case.
- **KISS** (Keep It Simple, Stupid): Prioritize simplicity and avoid over‑engineering.
- **SOLID**: Apply the five SOLID principles for flexible architecture.
- **YAGNI** (You Aren't Gonna Need It): Build only what is currently required.
