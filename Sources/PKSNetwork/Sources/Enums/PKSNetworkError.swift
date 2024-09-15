//  PKSNetworkError.swift
//  PKSNetwork
//
//  Created by Omer Hamid Kamisli on 2024-09-14 for POIKUS LLC.
//  Copyright © 2024 POIKUS LLC. All rights reserved.
//

import Foundation

/// Represents possible errors that can occur during network operations.
public enum PKSNetworkError: Error {
    /// The URL is invalid.
    case invalidURL
    
    /// The network request failed.
    case requestFailed
    
    /// No data was received from the server.
    case noData
    
    /// The server response was invalid.
    case invalidResponse
    
    /// The data decoding process failed.
    case decodingFailed
    
    /// The data encoding process failed.
    case encodingFailed
    
    /// The network is not reachable.
    case noNetwork
    
    /// The request timed out.
    case timeout
    
    /// The authentication failed.
    case authenticationFailed
    
    /// An unknown error occurred.
    case unknown
}