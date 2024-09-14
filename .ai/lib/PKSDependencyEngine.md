# PKSDependencyEngine

**PKSDependencyEngine** is a lightweight and efficient dependency injection framework designed specifically for Swift developers. In modern application development, managing dependencies in a clean, maintainable, and testable way is crucial. PKSDependencyEngine simplifies this process by providing an easy-to-use API for registering and resolving dependencies, whether you’re working with classes or protocols.

By integrating PKSDependencyEngine into your project, you can achieve a more modular and decoupled codebase, making it easier to manage complex applications. The framework is thread-safe, ensuring that your dependencies are accessed consistently across different parts of your application without introducing any concurrency issues. Moreover, PKSDependencyEngine has no external dependencies, making it a seamless addition to any Swift project without adding unnecessary bloat.

Whether you're building a small SwiftUI app or a large-scale enterprise application, PKSDependencyEngine provides the flexibility and power you need to manage your dependencies effectively.

## Features

- **Lightweight and Efficient**: Minimal footprint with maximum impact on your dependency management, designed to work smoothly in any Swift project.
- **Easy-to-Use API**: Intuitive interface for registering and resolving dependencies with minimal boilerplate code.
- **Supports Both Class and Protocol-Based Dependencies**: Flexibility to use concrete classes or protocols, enabling more testable and decoupled code.
- **Thread-Safe**: Safely resolve dependencies from multiple threads with no risk of race conditions or unexpected behavior.
- **No External Dependencies**: PKSDependencyEngine is self-contained, ensuring it integrates cleanly into your project without bringing in additional libraries.

## Getting Started

To start using PKSDependencyEngine in your project, follow these simple steps:

### Step 1: Install PKSDependencyEngine

First, integrate PKSDependencyEngine into your project using Swift Package Manager.

#### In Xcode:

1. Open your project in Xcode.
2. Navigate to **File > Add Packages**.
3. Enter the repository URL: `https://github.com/ohk/PKSDependencyEngine`.
4. Select the version and add the package to your project.

#### Alternatively, via `Package.swift`:

If you're using a `Package.swift` file, add PKSDependencyEngine as a dependency:

```swift
dependencies: [
    .package(url: "https://github.com/ohk/PKSDependencyEngine", from: "1.0.0")
]
```

### Step 2: Register Dependencies

Registering dependencies is straightforward with PKSDependencyEngine. You can use the `@PKSRegisterDependency` property wrapper to define and register your dependencies:

```swift
import PKSDependencyEngine

class MyDependency {
    func doSomething() {
        print("Doing something...")
    }
}

class App {
    @PKSRegisterDependency var myDependency: MyDependency = MyDependency()
}
```

In this example, `MyDependency` is registered as a dependency within the `App` class.

### Step 3: Resolve Dependencies

To resolve and use your registered dependencies, simply use the `@PKSDependency` property wrapper:

```swift
import PKSDependencyEngine

class MyService {
    @PKSDependency var dependency: MyDependency

    func doSomething() {
        dependency.doSomething()
    }
}
```

In this example, `MyService` automatically resolves and uses the `MyDependency` instance registered earlier.

### Step 4: Protocol-Based Dependencies (Optional)

You can also register and resolve protocol-based dependencies to promote more flexible and testable code:

```swift
import PKSDependencyEngine

protocol MyDependencyProtocol {
    func doSomething()
}

class MyDependency: MyDependencyProtocol {
    func doSomething() {
        print("Doing something...")
    }
}

class App {
    @PKSRegisterDependency var myDependency: MyDependencyProtocol = MyDependency()
}
```

```swift
class MyService {
    @PKSDependency var dependency: MyDependencyProtocol

    func doSomething() {
        dependency.doSomething()
    }
}
```

### Step 5: Run Your Project

With dependencies registered and resolved, you're ready to run your project. PKSDependencyEngine will ensure that your dependencies are managed efficiently, allowing you to focus on building great features.

## Installation

You can integrate PKSDependencyEngine into your project using Swift Package Manager.

In Xcode, open your project and navigate to File > Add Packages.
Enter the repository URL: https://github.com/ohk/PKSDependencyEngine
Select the version and add the package to your project.
Alternatively, you can add the following dependency to your Package.swift file:

```swift
dependencies: [
    .package(url: "https://github.com/ohk/PKSDependencyEngine", from: "1.0.0")
]
```

## Usage

### Registering Dependencies

To register a dependency, use the `@PKSRegisterDependency` property wrapper. You can specify the type of the dependency as the generic parameter. For example:

```swift
import PKSDependencyEngine

class MyDependency {
    func doSomething() {
        print("Doing something...")
    }
}

class App {
    @PKSRegisterDependency var myDependency: MyDependency = MyDependency()

    ...
}
```

### Resolving Dependencies

To read a dependency, use the `@PKSDependency` property wrapper. You can specify the type of the dependency as the generic parameter. For example:

```swift
import PKSDependencyEngine

class MyDependency {
    func doSomething() {
        print("Doing something...")
    }
}

class MyService {
    @PKSDependency var dependency: MyDependency

    func doSomething() {
        dependency.doSomething()
    }

    ...
}
```

### Protocol-Based Dependencies

You can also use protocols to define dependencies. For example:

```swift
import PKSDependencyEngine

protocol MyDependencyProtocol {
    func doSomething()
}

class MyDependency: MyDependencyProtocol {
    func doSomething() {
        print("Doing something...")
    }
}

class MyService {
    // Read the dependency
    @PKSDependency var dependency: MyDependencyProtocol

    func doSomething() {
        dependency.doSomething()
    }

    ...
}

class App {
    // Register a dependency
    @PKSRegisterDependency var myDependency: MyDependencyProtocol = MyDependency()

    ...
}
```

To register a dependency, use the `@PKSRegisterDependency` property wrapper. To read a dependency, use the `@PKSDependency` property wrapper. Dependencies are resolved lazily, meaning they are only created when they are accessed for the first time.

### Thread Safety

PKSDependencyEngine is thread-safe, meaning you can safely access dependencies from multiple threads without worrying about

## Testing

PKSDependencyEngine makes it easy to mock dependencies for testing. You can register mock dependencies in your test setup and use them to replace the real dependencies during testing. For example:

```swift
import PKSDependencyEngine

class MyDependencyMock: MyDependencyProtocol {
    func doSomething() {
        print("Mocking something...")
    }
}

class MyServiceTests: XCTestCase {
    var myService: MyService!

    override func setUp() {
        super.setUp()
        PKSDependencyEngine.shared.clearDependencies()
        // Register the mock dependency
        PKSDependencyEngine.shared.register(MyDependencyProtocol.self, MyDependencyMock())

        myService = MyService()
    }

    func testDoSomething() {
        myService.doSomething()
    }

    ...
}
```