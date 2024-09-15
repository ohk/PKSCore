//
//  RadiusConfiguration.swift
//
//
//  Created by Ömer Hamid Kamışlı on 8/24/24.
//

import Foundation

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public struct RadiusConfiguration {
    
    /// The corner radius for the small size.
    ///
    /// The default value is `4.0`.
    public var sm: CGFloat
    
    /// The corner radius for the medium size.
    ///
    /// The default value is `8.0`.
    public var md: CGFloat
    
    /// The corner radius for the large size.
    ///
    /// The default value is `12.0`.
    public var lg: CGFloat
    
    /// The corner radius for the extra-large size.
    ///
    /// The default value is `16.0`.
    public var xl: CGFloat
    
    /// The corner radius for the double extra-large size.
    ///
    /// The default value is `20.0`.
    public var xxl: CGFloat
    
    /// The corner radius for a full size, typically used to create a fully rounded shape.
    ///
    /// The default value is `100.0`.
    public var full: CGFloat

    /// Initializes a new `RadiusConfiguration` with the specified corner radius values.
    ///
    /// Use this initializer to customize the corner radius values for different sizes.
    /// If no values are provided, the default values are used.
    ///
    /// - Parameters:
    ///   - sm: The corner radius for the small size. Defaults to `4.0`.
    ///   - md: The corner radius for the medium size. Defaults to `8.0`.
    ///   - lg: The corner radius for the large size. Defaults to `12.0`.
    ///   - xl: The corner radius for the extra-large size. Defaults to `16.0`.
    ///   - xxl: The corner radius for the double extra-large size. Defaults to `20.0`.
    ///   - full: The corner radius for a full size. Defaults to `100.0`.
    public init(
        sm: CGFloat = 4,
        md: CGFloat = 8,
        lg: CGFloat = 12,
        xl: CGFloat = 16,
        xxl: CGFloat = 20,
        full: CGFloat = 100
    ) {
        self.sm = sm
        self.md = md
        self.lg = lg
        self.xl = xl
        self.xxl = xxl
        self.full = full
    }
}

