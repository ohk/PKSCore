//
//  PKSRadius.swift
//
//
//  Created by Ömer Hamid Kamışlı on 8/24/24.
//

import Foundation

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public enum PKSRadius: CaseIterable, Identifiable, Equatable {

    /// A small corner radius.
    case sm
    
    /// A medium corner radius.
    case md
    
    /// A large corner radius.
    case lg
    
    /// An extra-large corner radius.
    case xl
    
    /// A double extra-large corner radius.
    case xxl
    
    /// A full corner radius, typically used to create a circle or rounded rectangle.
    case full
    
    /// A custom corner radius with a specified value.
    case custom(radius: CGFloat)
    
    /// An array of all cases of the `PKSRadius` enumeration, except for the `custom` case.
    ///
    /// This array is used to iterate over all predefined corner radius values.
    public static var allCases: [PKSRadius] = [.sm, .md, .lg, .xl, .xxl, .full]
    
    /// A unique identifier for each case of the `PKSRadius` enumeration.
    ///
    /// The `id` property provides a string that uniquely identifies each case
    /// of `PKSRadius`, which is useful when the enumeration needs to conform
    /// to the `Identifiable` protocol.
    ///
    /// The identifier is constructed by appending a case-specific suffix to a
    /// base string, "PKSRadius". For example, the `sm` case results in the ID
    /// "PKSRadiusSM", and the `custom(radius:)` case results in an ID like
    /// "PKSRadiusCUSTOM10.0" where `10.0` is the custom radius value.
    public var id: String {
        var baseID: String = "PKSRadius"
        switch self {
        case .sm:
            baseID += "SM"
        case .md:
            baseID += "MD"
        case .lg:
            baseID += "LG"
        case .xl:
            baseID += "XL"
        case .xxl:
            baseID += "XXL"
        case .full:
            baseID += "FULL"
        case .custom(let radius):
            baseID += "CUSTOM\(radius)"
        }
        return baseID
    }
}
