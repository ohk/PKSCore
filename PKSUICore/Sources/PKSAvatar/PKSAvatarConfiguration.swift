//
//  PKSAvatarConfiguration.swift
//
//
//  Created by Ömer Hamid Kamışlı on 8/17/24.
//

import SwiftUI

public struct PKSAvatarConfiguration {
    // MARK: Sizes
    public var smallSize: CGSize
    public var mediumSize: CGSize
    public var largeSize: CGSize
    public var xLargeSize: CGSize
    public var xxLargeSize: CGSize
    
    // MARK: Color
    public var nameInitialsBackgroundColorMode: AvatarColorMode
    
    public init(
        smallSize: CGSize = CGSize(width: 48, height: 48),
        mediumSize: CGSize = CGSize(width: 60, height: 60),
        largeSize: CGSize = CGSize(width: 72, height: 72),
        xLargeSize: CGSize = CGSize(width: 84, height: 84),
        xxLargeSize: CGSize = CGSize(width: 96, height: 96),
        nameInitialsBackgroundColorMode: AvatarColorMode = .random
    ) {
        self.smallSize = smallSize
        self.mediumSize = mediumSize
        self.largeSize = largeSize
        self.xLargeSize = xLargeSize
        self.xxLargeSize = xxLargeSize
        self.nameInitialsBackgroundColorMode = nameInitialsBackgroundColorMode
    }
}
