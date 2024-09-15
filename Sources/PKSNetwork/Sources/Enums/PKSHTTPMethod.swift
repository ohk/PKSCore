//
//  PKSHTTPMethod.swift
//  PKSNetwork
//
//  Created by Omer Hamid Kamisli on 2024-09-14 for POIKUS LLC.
//  Copyright © 2024 POIKUS LLC. All rights reserved.
//

import Foundation

/// Represents HTTP methods for network requests.
public enum PKSHTTPMethod: String {
    /// HTTP GET method for retrieving resources.
    case get = "GET"
    
    /// HTTP POST method for submitting data to be processed.
    case post = "POST"
    
    /// HTTP PUT method for updating existing resources.
    case put = "PUT"
    
    /// HTTP DELETE method for deleting resources.
    case delete = "DELETE"
    
    /// HTTP PATCH method for partially modifying resources.
    case patch = "PATCH"
    
    /// HTTP HEAD method for retrieving headers only.
    case head = "HEAD"
    
    /// HTTP OPTIONS method for describing communication options.
    case options = "OPTIONS"
    
    /// HTTP TRACE method for diagnostic purposes.
    case trace = "TRACE"
    
    /// HTTP CONNECT method for establishing network connections.
    case connect = "CONNECT"
}
