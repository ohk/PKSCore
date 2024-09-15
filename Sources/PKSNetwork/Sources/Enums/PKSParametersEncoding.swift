//
//  ParametersEncoding.swift
//  
//
//  Created by Ömer Hamid Kamışlı on 9/14/24.
//

import Foundation

/// Defines the encoding types for request parameters.
public enum PKSParametersEncoding {
    /// URL encoding for parameters (typically used for GET requests).
    case urlEncoded
    
    /// JSON encoding for parameters (typically used for POST, PUT, PATCH requests).
    case jsonEncoded
}
