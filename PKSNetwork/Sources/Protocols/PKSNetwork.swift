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
    /// Sends a network request and returns a publisher with the response.
    /// - Parameter request: The request to be sent.
    /// - Returns: A publisher that emits the response data or an error.
    func send<T: Decodable, P: Encodable>(_ request: PKSRequest<P>) -> AnyPublisher<T, PKSNetworkError>
    
    /// Sends a network request and returns the response asynchronously.
    /// - Parameter request: The request to be sent.
    /// - Returns: The decoded response data.
    /// - Throws: A PKSNetworkError if the request fails.
    func send<T: Decodable, P: Encodable>(_ request: PKSRequest<P>) async throws -> T
}
