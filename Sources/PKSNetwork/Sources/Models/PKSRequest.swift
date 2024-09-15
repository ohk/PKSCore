//  PKSRequest.swift
//  PKSNetwork
//
//  Created by Omer Hamid Kamisli on 2024-09-14 for POIKUS LLC.
//  Copyright © 2024 POIKUS LLC. All rights reserved.
//

import Foundation

/// Represents a network request.
public struct PKSRequest<Parameters: Encodable> {
    /// The path of the request.
    public let path: String
    
    /// The HTTP method of the request.
    public let method: PKSHTTPMethod
    
    /// The parameters of the request, which can be nil.
    public let parameters: Parameters?
    
    /// The encoding type for the parameters.
    public let parametersEncoding: PKSParametersEncoding
    
    /// A flag indicating whether the request requires authentication.
    public let requiresAuthentication: Bool
    
    /// The timeout interval for the request.
    public let timeoutInterval: TimeInterval
    
    /// The cache policy for the request.
    public let cachePolicy: PKSCachePolicy
    
    /// The retry policy for the request, which can be nil.
    public let retryPolicy: PKSRetryPolicy?

    /// Initializes a new instance of `PKSRequest`.
    ///
    /// - Parameters:
    ///   - path: The path of the request.
    ///   - method: The HTTP method of the request.
    ///   - parameters: The parameters of the request.
    ///   - parametersEncoding: The encoding type for the parameters.
    ///   - requiresAuthentication: A flag indicating whether the request requires authentication.
    ///   - timeoutInterval: The timeout interval for the request.
    ///   - cachePolicy: The cache policy for the request.
    ///   - retryPolicy: The retry policy for the request, which can be nil.
    public init(
        path: String,
        method: PKSHTTPMethod,
        parameters: Parameters,
        parametersEncoding: PKSParametersEncoding,
        requiresAuthentication: Bool = false,
        timeoutInterval: TimeInterval = 30,
        cachePolicy: PKSCachePolicy = .reloadIgnoringLocalAndRemoteCacheData,
        retryPolicy: PKSRetryPolicy? = nil
    ) {
        self.path = path
        self.method = method
        self.parameters = parameters
        self.parametersEncoding = parametersEncoding
        self.requiresAuthentication = requiresAuthentication
        self.timeoutInterval = timeoutInterval
        self.cachePolicy = cachePolicy
        self.retryPolicy = retryPolicy
    }

    /// Initializes a new instance of `PKSRequest` without parameters.
    ///
    /// - Parameters:
    ///   - path: The path of the request.
    ///   - method: The HTTP method of the request.
    ///   - requiresAuthentication: A flag indicating whether the request requires authentication.
    ///   - timeoutInterval: The timeout interval for the request.
    ///   - cachePolicy: The cache policy for the request.
    ///   - retryPolicy: The retry policy for the request, which can be nil.
    public init(
        path: String,
        method: PKSHTTPMethod,
        requiresAuthentication: Bool = false,
        timeoutInterval: TimeInterval = 30,
        cachePolicy: PKSCachePolicy = .reloadIgnoringLocalAndRemoteCacheData,
        retryPolicy: PKSRetryPolicy? = nil
    ) where Parameters == EmptyEncodable {
        self.path = path
        self.method = method
        self.parameters = EmptyEncodable()
        self.parametersEncoding = .urlEncoded
        self.requiresAuthentication = requiresAuthentication
        self.timeoutInterval = timeoutInterval
        self.cachePolicy = cachePolicy
        self.retryPolicy = retryPolicy
    }
}

/// An empty struct conforming to Encodable, used for requests without parameters.
public struct EmptyEncodable: Encodable {}







