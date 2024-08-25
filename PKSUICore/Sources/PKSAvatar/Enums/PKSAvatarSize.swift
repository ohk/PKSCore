//
//  PKSAvatarSize.swift
//  
//
//  Created by Ömer Hamid Kamışlı on 8/19/24.
//

import Foundation

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public enum PKSAvatarSize: CaseIterable, Identifiable, Equatable {
    
    /// A small avatar size.
    case small
    
    /// A medium avatar size.
    case medium
    
    /// A large avatar size.
    case large
    
    /// An extra-large avatar size.
    case xLarge
    
    /// A double extra-large avatar size.
    case xxLarge
    
    /// A fill size, typically used when the avatar should fill its container.
    case fill
    
    /// A custom avatar size with specified width and height.
    ///
    /// Use this case to define a custom size for the avatar by providing
    /// specific values for the width and height.
    case custom(width: Int, height: Int)

    /// An array of all cases of the `PKSAvatarSize` enumeration, except for the `custom` case.
    ///
    /// This array is used to iterate over all predefined avatar sizes.
    public static var allCases: [PKSAvatarSize] = [.small, .medium, .large, .xLarge, .xxLarge, .fill]
    
    /// A unique identifier for each case of the `PKSAvatarSize` enumeration.
    ///
    /// The `id` property provides a string that uniquely identifies each case
    /// of `PKSAvatarSize`, which is useful when the enumeration needs to conform
    /// to the `Identifiable` protocol.
    ///
    /// The identifier is constructed by appending a case-specific suffix to a
    /// base string, "PKSAvatarSize". For example, the `small` case results in the ID
    /// "PKSAvatarSizeSM", and the `custom(width:height:)` case results in an ID like
    /// "PKSAvatarSizeCUSTOM100x200" where `100` and `200` are the custom width and height values.
    public var id: String {
        var baseID: String = "PKSAvatarSize"
        switch self {
        case .small:
            baseID += "SM"
        case .medium:
            baseID += "MD"
        case .large:
            baseID += "LG"
        case .xLarge:
            baseID += "XL"
        case .xxLarge:
            baseID += "XXL"
        case .fill:
            baseID += "FILL"
        case .custom(let width, let height):
            baseID += "CUSTOM\(width)x\(height)"
        }
        return baseID
    }
}
