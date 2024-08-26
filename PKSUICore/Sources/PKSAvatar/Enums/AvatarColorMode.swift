//
//  AvatarColorMode.swift
//
//
//  Created by Ömer Hamid Kamışlı on 8/19/24.
//

import SwiftUI

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public enum AvatarColorMode: Equatable {
    
    /// A mode that selects a random color.
    ///
    /// Use this mode when you want the color to be chosen randomly.
    case random
    
    /// A mode that uses a custom color.
    ///
    /// Use this mode to specify a custom color that should be used.
    ///
    /// - Parameter color: The custom `Color` to be used.
    case custom(color: Color)
    
    /// A mode that selects a color that provides the best visibility.
    ///
    /// Use this mode when you want the color to be automatically chosen to ensure the best contrast with the background.
    case visible
}

