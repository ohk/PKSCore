//
//  PKSAvatarSize.swift
//  
//
//  Created by Ömer Hamid Kamışlı on 8/19/24.
//

import Foundation

public enum PKSAvatarSize: CaseIterable, Identifiable, Equatable {
    public static var allCases: [PKSAvatarSize] = [.small, .medium, .large, .xLarge, .xxLarge, .fill]
    
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
    
    case small
    case medium
    case large
    case xLarge
    case xxLarge
    case fill
    case custom(width: Int, height: Int)
}
