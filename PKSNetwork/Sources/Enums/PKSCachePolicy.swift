//
//  PKSCachePolicy.swift
//  PKSNetwork
//
//  Created by Omer Hamid Kamisli on 2024-09-14 for POIKUS LLC.
//  Copyright © 2024 POIKUS LLC. All rights reserved.
//

import Foundation

/// Defines the caching policies for network requests, based on URLRequest.CachePolicy.
public enum PKSCachePolicy {
    /// Use protocol-defined caching semantics.
    case useProtocolCachePolicy
    
    /// Ignore local cache data and load from originating source.
    case reloadIgnoringLocalCacheData
    
    /// Ignore local cache data and load from originating source, but allow storing of the result.
    case reloadIgnoringLocalAndRemoteCacheData
    
    /// Use existing cache data, regardless of age or expiration date; fail if no cache data is available.
    case returnCacheDataElseLoad
    
    /// Use existing cache data, regardless of age or expiration date; don't load if no cache data is available.
    case returnCacheDataDontLoad
    
    /// Use cache data if request fails.
    case reloadRevalidatingCacheData
    
    /// Convert PKSCachePolicy to URLRequest.CachePolicy
    ///
    /// - Returns: The corresponding URLRequest.CachePolicy
    public func toURLRequestCachePolicy() -> URLRequest.CachePolicy {
        switch self {
        case .useProtocolCachePolicy:
            return .useProtocolCachePolicy
        case .reloadIgnoringLocalCacheData:
            return .reloadIgnoringLocalCacheData
        case .reloadIgnoringLocalAndRemoteCacheData:
            return .reloadIgnoringLocalAndRemoteCacheData
        case .returnCacheDataElseLoad:
            return .returnCacheDataElseLoad
        case .returnCacheDataDontLoad:
            return .returnCacheDataDontLoad
        case .reloadRevalidatingCacheData:
            return .reloadRevalidatingCacheData
        }
    }
}
