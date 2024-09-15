//
//  PKSTokenProvider.swift
//  PKSNetwork
//
//  Created by Omer Hamid Kamisli on 2024-09-14 for POIKUS LLC.
//  Copyright © 2024 POIKUS LLC. All rights reserved.
//

import Foundation

/// Protocol for providing tokens to the network layer.
public protocol PKSTokenProvider {
    /// Fetches the token asynchronously.
    func getToken() async throws -> String
}