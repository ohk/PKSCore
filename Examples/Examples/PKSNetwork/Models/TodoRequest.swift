//
//  TodoRequest.swift
//  Examples
//
//  Created by Ömer Hamid Kamışlı on 9/14/24.
//

import Foundation

/// Represents a Todo item to be sent to the API when creating or updating.
/// Conforms to `Codable` for JSON encoding when sending data.
struct TodoRequest: Codable {
    let title: String
    let completed: Bool
    let userId: Int
}
