# Swift / SwiftUI Conventions

This document covers Swift and SwiftUI-specific conventions. For general coding principles that apply to all languages, see [general-conventions.md](./general-conventions.md).

## SwiftUI-Specific Patterns

### State Management

- **MainActor by Default**: UI and Store coordination must occur on `@MainActor`. Background work must explicitly hop back via actors/clients.
- Use `@StateObject` for owning dependencies in SwiftUI views

### Example: Composition Root in SwiftUI

This demonstrates the general principle of initializing dependencies at the application root (see [general-conventions.md](./general-conventions.md#architecture--state)):

```swift
@main
struct MyApp: App {
    @StateObject private var store: AppStore
    
    init() {
        // Composition root - wire up all dependencies
        let store = AppStore(
            gmailService: GmailService(),
            driveService: DriveService()
        )
        _store = StateObject(wrappedValue: store)
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView(store: store)
        }
    }
}
```

### Example: Dependency Injection in Swift

This demonstrates the general dependency injection principles (see [general-conventions.md](./general-conventions.md#dependency-injection)):

```swift
// Protocol for dependency
protocol APIClient {
    func fetch() async throws -> Data
}

// Implementation
final class HTTPClient: APIClient {
    private let session: URLSession
    
    init(session: URLSession) {
        self.session = session
    }
    
    func fetch() async throws -> Data {
        // Implementation
    }
}

// Usage with dependency injection
final class Service {
    private let apiClient: APIClient
    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
}
```

### Example: Fail-Fast Singleton Pattern

This demonstrates the general singleton lifecycle pattern (see [general-conventions.md](./general-conventions.md#singleton-lifecycle)):

```swift
final class Logger {
    static var shared: Logger!
    
    private init() {}
    
    static func configure() {
        shared = Logger()
    }
}
```

### Example: Codable for Data Models

```swift
struct User: Codable {
    let id: String
    let name: String
    let email: String
}
```

## Swift-Specific Notes

- Use `@MainActor` for UI-related code
- Prefer `struct` over `class` for value types
- Use `let` over `var` for immutability
- Mark classes as `final` unless inheritance is needed
- Use `Codable` for serialization instead of manual encoding/decoding

For all other conventions (dependency injection, error handling, testing, etc.), see [general-conventions.md](./general-conventions.md).
