//
//  PKSParameterEncoder.swift
//  PKSNetwork
//
//  Created by Ömer Hamid Kamışlı on 9/14/24.
//  Copyright © 2024 POIKUS LLC. All rights reserved.
//

import Foundation

/// Encodes parameters for network requests based on the specified encoding type.
public struct PKSParameterEncoder {
    /// Encodes the parameters and updates the URLRequest accordingly.
    ///
    /// This method takes a URLRequest, parameters, and an encoding type, and modifies the URLRequest
    /// based on the specified encoding. It supports URL encoding and JSON encoding out of the box.
    ///
    /// - Parameters:
    ///   - urlRequest: The URLRequest to be updated with encoded parameters.
    ///   - parameters: The parameters to be encoded.
    ///   - encoding: The encoding type to be used.
    /// - Throws: PKSNetworkError if encoding fails.
    public static func encode<T: Encodable>(urlRequest: inout URLRequest, with parameters: T, using encoding: PKSParametersEncoding) throws {
        switch encoding {
        case .urlEncoded:
            try encodeURLParameters(urlRequest: &urlRequest, with: parameters)
        case .jsonEncoded:
            try encodeJSONParameters(urlRequest: &urlRequest, with: parameters)
        }
    }
    
    /// Encodes parameters using URL encoding.
    ///
    /// - Parameters:
    ///   - urlRequest: The URLRequest to be updated.
    ///   - parameters: The parameters to be encoded.
    /// - Throws: PKSNetworkError if encoding fails.
    private static func encodeURLParameters<T: Encodable>(urlRequest: inout URLRequest, with parameters: T) throws {
        guard let url = urlRequest.url else { throw PKSNetworkError.invalidURL }
        
        if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) {
            let parametersDictionary = try parameters.toDictionary()
            let queryItems = parametersDictionary.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
            urlComponents.queryItems = (urlComponents.queryItems ?? []) + queryItems
            urlRequest.url = urlComponents.url
        }
        
        if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
            urlRequest.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
        }
    }
    
    /// Encodes parameters using JSON encoding.
    ///
    /// - Parameters:
    ///   - urlRequest: The URLRequest to be updated.
    ///   - parameters: The parameters to be encoded.
    /// - Throws: PKSNetworkError if encoding fails.
    private static func encodeJSONParameters<T: Encodable>(urlRequest: inout URLRequest, with parameters: T) throws {
        let jsonData = try JSONEncoder().encode(parameters)
        urlRequest.httpBody = jsonData
        
        if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
    }
}
