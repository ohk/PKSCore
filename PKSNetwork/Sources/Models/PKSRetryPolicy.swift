//
//  PKSRetryPolicy.swift
//  PKSNetwork
//
//  Created by Omer Hamid Kamisli on 2024-09-14 for POIKUS LLC.
//  Copyright © 2024 POIKUS LLC. All rights reserved.
//

import Foundation

/// Defines the retry policy for network requests.
public struct PKSRetryPolicy {
    /// The maximum number of retry attempts.
    public let maxRetryCount: Int
    
    /// The base delay between retry attempts, in seconds.
    public let baseDelay: TimeInterval
    
    /// The maximum delay between retry attempts, in seconds.
    public let maxDelay: TimeInterval
    
    /// The scale factor for exponential backoff.
    public let scaleFactor: Double
    
    /// Initializes a new instance of `PKSRetryPolicy`.
    ///
    /// - Parameters:
    ///   - maxRetryCount: The maximum number of retry attempts.
    ///   - baseDelay: The base delay between retry attempts, in seconds.
    ///   - maxDelay: The maximum delay between retry attempts, in seconds.
    ///   - scaleFactor: The scale factor for exponential backoff.
    public init(
        maxRetryCount: Int,
        baseDelay: TimeInterval,
        maxDelay: TimeInterval,
        scaleFactor: Double
    ) {
        self.maxRetryCount = maxRetryCount
        self.baseDelay = baseDelay
        self.maxDelay = maxDelay
        self.scaleFactor = scaleFactor
    }
    
    /// Calculates the delay for a given retry attempt.
    ///
    /// - Parameter attempt: The current retry attempt number.
    /// - Returns: The delay in seconds for the given retry attempt.
    public func delay(forAttempt attempt: Int) -> TimeInterval {
        let exponentialDelay = baseDelay * pow(scaleFactor, Double(attempt - 1))
        return min(exponentialDelay, maxDelay)
    }
}
