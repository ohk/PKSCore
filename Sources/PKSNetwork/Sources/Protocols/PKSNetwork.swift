//  PKSNetwork.swift
//  PKSNetwork
//
//  Created by Omer Hamid Kamisli on 2024-09-14 for POIKUS LLC.
//  Copyright © 2024 POIKUS LLC. All rights reserved.
//

import Foundation
import Combine

/// Protocol defining the network layer operations.
public protocol PKSNetwork {
    /// Sends a network request and returns a publisher with the decoded response.
    ///
    /// Use this method when you expect a decodable response from the server.
    ///
    /// - Parameter request: The request to be sent.
    /// - Returns: A publisher that emits the decoded response data or an error.
    func send<T: Decodable, P: Encodable>(_ request: PKSRequest<P>) -> AnyPublisher<T, PKSNetworkError>
    
    /// Sends a network request and returns the decoded response asynchronously.
    ///
    /// Use this method when you expect a decodable response from the server and prefer using async/await.
    ///
    /// - Parameter request: The request to be sent.
    /// - Returns: The decoded response data.
    /// - Throws: A PKSNetworkError if the request fails or decoding fails.
    func send<T: Decodable, P: Encodable>(_ request: PKSRequest<P>) async throws -> T
    
    /// Sends a network request without expecting a decodable response and returns a publisher.
    ///
    /// Use this method for operations like DELETE where you don't expect a response body.
    ///
    /// - Parameter request: The request to be sent.
    /// - Returns: A publisher that completes successfully if the request succeeds, or emits an error.
    func send<P: Encodable>(_ request: PKSRequest<P>) -> AnyPublisher<Void, PKSNetworkError>
    
    /// Sends a network request without expecting a decodable response asynchronously.
    ///
    /// Use this method for operations like DELETE where you don't expect a response body and prefer using async/await.
    ///
    /// - Parameter request: The request to be sent.
    /// - Throws: A PKSNetworkError if the request fails.
    func send<P: Encodable>(_ request: PKSRequest<P>) async throws
}
