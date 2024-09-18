# PKSNetwork

PKSNetwork is a Swift-based networking library designed to simplify and streamline network operations in your iOS and macOS applications. It provides a robust and extensible architecture for making HTTP requests, handling responses, and managing network errors, caching, and retries.

## Table of Contents

- [Features](#features)
- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)
  - [Making a Request](#making-a-request)
  - [Handling Responses](#handling-responses)
  - [Error Handling](#error-handling)
  - [Authentication](#authentication)
  - [Retry Policy](#retry-policy)
- [Components](#components)
- [License](#license)

## Features

- **Protocol-Oriented Design**: Easily mock and test network layers.
- **Customizable Requests**: Define HTTP methods, headers, parameters, and caching policies.
- **Error Handling**: Comprehensive error enumeration for handling various network issues.
- **Parameter Encoding**: Support for URL and JSON parameter encoding.
- **Retry Mechanism**: Configurable retry policies with exponential backoff.
- **Async/Await Support**: Modern asynchronous programming with Combine and async/await.

## Requirements

- iOS 14.0+ / macOS 11.0+
- Swift 5.5+

## Installation

### Swift Package Manager

Add the following to your `Package.swift` file:

```swift
dependencies: [
    .package(url: "https://github.com/yourusername/PKSNetwork.git", from: "1.0.0")
]
```

## Usage

### Making a Request

First, import the PKSNetwork module:

```swift
import PKSNetwork
```

Create a request by defining the path, HTTP method, parameters, and other configurations:

```swift
let request = PKSRequest<YourParametersType>(
    path: "/api/v1/resource",
    method: .get,
    parameters: yourParameters,
    parametersEncoding: .urlEncoded,
    requiresAuthentication: true
)
```

### Handling Responses

#### Using Combine

```swift
network.send(request)
    .sink(receiveCompletion: { completion in
        // Handle completion
    }, receiveValue: { (response: YourResponseType) in
        // Handle response
    })
    .store(in: &cancellables)
```

#### Using Async/Await

```swift
do {
    let response: YourResponseType = try await network.send(request)
    // Handle response
} catch {
    // Handle error
}
```

### Error Handling

PKSNetwork provides a comprehensive `PKSNetworkError` enum to handle various network errors:

```swift
do {
    let response: YourResponseType = try await network.send(request)
} catch let error as PKSNetworkError {
    switch error {
    case .invalidURL:
        // Handle invalid URL
    case .requestFailed:
        // Handle request failure
    // Handle other cases
    default:
        // Handle unknown error
    }
}
```

### Authentication

Implement the `PKSTokenProvider` protocol to supply authentication tokens:

```swift
class MyTokenProvider: PKSTokenProvider {
    func getToken() async throws -> String {
        // Fetch or return the token
    }
}
```

Initialize the network layer with your token provider:

```swift
let tokenProvider = MyTokenProvider()
let network = PKSNetworkURLSession(baseURL: yourBaseURL, tokenProvider: tokenProvider)
```

### Retry Policy

Configure a retry policy for your requests:

```swift
let retryPolicy = PKSRetryPolicy(
    maxRetryCount: 3,
    baseDelay: 1.0,
    maxDelay: 5.0,
    scaleFactor: 2.0
)

let request = PKSRequest<YourParametersType>(
    path: "/api/v1/resource",
    method: .get,
    parameters: yourParameters,
    parametersEncoding: .urlEncoded,
    retryPolicy: retryPolicy
)
```

## Components

### PKSRequest

A generic struct representing a network request.

- **Properties**:
  - `path`: Endpoint path.
  - `method`: HTTP method (`PKSHTTPMethod`).
  - `parameters`: Encodable parameters.
  - `parametersEncoding`: Parameter encoding type (`PKSParametersEncoding`).
  - `requiresAuthentication`: Bool indicating if authentication is needed.
  - `timeoutInterval`: Request timeout interval.
  - `cachePolicy`: Cache policy (`PKSCachePolicy`).
  - `retryPolicy`: Optional retry policy (`PKSRetryPolicy`).

### PKSHTTPMethod

An enum representing HTTP methods:

- `.get`, `.post`, `.put`, `.delete`, `.patch`, `.head`, `.options`, `.trace`, `.connect`

### PKSParametersEncoding

An enum defining parameter encoding types:

- `.urlEncoded`: For URL encoding (typically used with GET requests).
- `.jsonEncoded`: For JSON encoding (used with POST, PUT, PATCH requests).

### PKSCachePolicy

An enum defining caching policies:

- `.useProtocolCachePolicy`
- `.reloadIgnoringLocalCacheData`
- `.reloadIgnoringLocalAndRemoteCacheData`
- `.returnCacheDataElseLoad`
- `.returnCacheDataDontLoad`
- `.reloadRevalidatingCacheData`

### PKSRetryPolicy

A struct defining the retry mechanism:

- **Properties**:
  - `maxRetryCount`: Maximum number of retries.
  - `baseDelay`: Base delay between retries.
  - `maxDelay`: Maximum delay between retries.
  - `scaleFactor`: Scale factor for exponential backoff.

### PKSNetworkError

An enum representing possible network errors:

- `.invalidURL`
- `.requestFailed`
- `.noData`
- `.invalidResponse`
- `.decodingFailed`
- `.encodingFailed`
- `.noNetwork`
- `.timeout`
- `.authenticationFailed`
- `.unknown`

### PKSNetwork

A protocol defining the network layer operations:

- `send(_:) -> AnyPublisher<T, PKSNetworkError>`
- `send(_:) async throws -> T`
- Overloaded for requests expecting responses and those that do not.

### PKSTokenProvider

A protocol for providing authentication tokens:

- `func getToken() async throws -> String`

### PKSNetworkURLSession

A concrete implementation of `PKSNetwork` using `URLSession`.

- **Initialization**:
  - `init(baseURL: URL, tokenProvider: PKSTokenProvider, configuration: URLSessionConfiguration = .default)`

## License

This project is licensed under the MIT License. See the `LICENSE` file for more details.
