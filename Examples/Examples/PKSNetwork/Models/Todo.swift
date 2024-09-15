//
//  Todo.swift
//  Examples
//
//  Created by Ömer Hamid Kamışlı on 9/14/24.
//

import Foundation

/// Represents a Todo item retrieved from the API.
/// Conforms to `Codable` for easy JSON encoding/decoding
/// and `Identifiable` for use in SwiftUI lists.
struct Todo: Codable, Identifiable {
    let userId: Int?
    let id: Int?
    let title: String?
    let completed: Bool?
}
