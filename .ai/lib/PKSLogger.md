# PKSLogger

## Overview

`PKSLogger` is a Swift-based logging utility designed to provide structured logging functionalities for your iOS applications. This project includes various components such as models, views, helpers, and extensions to facilitate efficient and organized logging.

<img src="./assets/settings-view.png" width="300" alt="PKSLogger Settings View">
<img src="./assets/logs-view.png" width="300" alt="PKSLogger Logs View">

## Directory Structure

- `PKSLogger.swift`: The main file for the logging utility.
- `PKSLoggerManager.swift`: Manages the logging operations.
- `Enums/`: Contains enumerations used in logging.
- `Models/`: Contains data models related to logging.
- `Extensions/`: Contains extensions for various Swift classes to support logging.
- `Views/`: Contains views for displaying logs.
- `Helpers/`: Contains helper functions and utilities for the logging process.

## Installation

To install `PKSLogger` in your project, you can manually add the files or use a dependency manager such as Swift Package Manager.

### Manual Installation

1. Download or clone the repository.
2. Copy the `PKSLogger` directory into your project.
3. Ensure the files are added to your project target.

### Swift Package Manager

1. Add the repository URL to your `Package.swift` file:
   ```swift
   .package(url: "https://github.com/your-repo/PKSLogger.git", from: "1.0.0")
   ```
2. Import `PKSLogger` in your Swift files.

## Usage

To use `PKSLogger`, import it in your Swift files:

```swift
import PKSLogger
```

### Suggested Usage

Start by creating a `PKSLoggerManager` instance and use it to create loggers for different subsystems and categories. You can then use these loggers to log messages at different levels. In this way, you can see settings and logs for each subsystem and category separately from the `PKSLoggerSettingsView`. It is help to manage logs and settings for each subsystem and category.

```swift
import SwiftUI
import PKSLogger

@main
struct DEMOApp: App {
    @State var manager = PKSLoggerManager()

    init() {
        let aLogger = manager.getLogger(subsystem: "a", category: "b")
        _ = manager.getLogger(subsystem: "ab", category: "b")
        _ = manager.getLogger(subsystem: "abc", category: "b")
        for _ in stride(from: 0, to: 100, by: 1) {
            aLogger.info(String.random())
        }
    }

    var body: some Scene {
        WindowGroup {
            PKSLoggerSettingsView(loggerManager: manager)
        }
    }
}


extension String {

    static func random(length: Int = 20) -> String {
        let base = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        var randomString: String = ""

        for _ in 0..<length {
            let randomValue = arc4random_uniform(UInt32(base.count))
            randomString += "\(base[base.index(base.startIndex, offsetBy: Int(randomValue))])"
        }
        return randomString
    }
}
```

### Basic Logging

To log messages, use the `PKSLogger` class:

```swift
let configuration = PKSLoggerConfiguration(
    storeLogs: true,
    logLevel: .debug,
    hideLogs: false
    subsystem: "com.example.app"
    category: "Logging"
)
let logger = PKSLogger(configuration)
logger.info("This is a log message.")
```

### Log Levels

`PKSLogger` supports different log levels such as `info`, `debug`, `notice`, `warning`, `error`, `critical` and `fault` . Use them as follows:

```swift
let configuration = PKSLoggerConfiguration(
    storeLogs: true,
    logLevel: .debug,
    hideLogs: false
    subsystem: "com.example.app"
    category: "Logging"
)
let logger = PKSLogger(configuration)
logger.info("This is an info message.")
logger.debug("This is a debug message.")
logger.notice("This is a notice message.")
logger.warning("This is a warning message.")
logger.error("This is an error message.")
logger.critical("This is a critical message.")
logger.fault("This is a fault message.")
```

### Settings and Logs View

`PKSLogger` provides a `PKSLoggerSettingsView` to display logs or configure the logging settings. You can use it as follows:

```swift
let loggerManager = PKSLoggerManager()
let settingsView = PKSLoggerSettingsView(loggerManager: loggerManager)
```

## Contributing

We welcome your contributions to this project. Please fork this repository and submit a pull request to contribute to this project.

## License

The contents of this repository are licensed under the
[Apache License, version 2.0](http://www.apache.org/licenses/LICENSE-2.0).