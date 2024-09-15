//
//  TokenProvider.swift
//  Examples
//
//  Created by Ömer Hamid Kamışlı on 9/14/24.
//

import PKSNetwork

/// Provides an authentication token for network requests.
/// In this demo, it returns an empty string.
/// In a real app, implement logic to fetch or generate an auth token.
class TokenProvider: PKSTokenProvider {
    func getToken() async throws -> String {
        return ""
    }
}
