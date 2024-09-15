//
//  Encodable.swift
//  PKSNetwork
//
//  Created by Ömer Hamid Kamışlı on 9/14/24.
//  Copyright © 2024 POIKUS LLC. All rights reserved.
//

import Foundation

/// Extension on Encodable to provide additional functionality.
extension Encodable {
    /// Converts the Encodable object to a dictionary.
    ///
    /// This method encodes the object to JSON data and then converts it to a dictionary.
    /// It's useful for scenarios where you need to work with the object's properties as key-value pairs.
    ///
    /// - Returns: A dictionary representation of the Encodable object.
    /// - Throws: PKSNetworkError.encodingFailed if the conversion process fails.
    func toDictionary() throws -> [String: Any] {
        let data = try JSONEncoder().encode(self)
        guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            throw PKSNetworkError.encodingFailed
        }
        return dictionary
    }
}
