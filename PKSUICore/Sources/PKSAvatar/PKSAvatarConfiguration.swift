//
//  PKSAvatarConfiguration.swift
//
//
//  Created by Ömer Hamid Kamışlı on 8/17/24.
//

import SwiftUI
import Nuke

@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
public struct PKSAvatarConfiguration {
    
    // MARK: - Sizes
    
    /// The size for a small avatar.
    ///
    /// The default value is `CGSize(width: 48, height: 48)`.
    public var smallSize: CGSize
    
    /// The size for a medium avatar.
    ///
    /// The default value is `CGSize(width: 60, height: 60)`.
    public var mediumSize: CGSize
    
    /// The size for a large avatar.
    ///
    /// The default value is `CGSize(width: 72, height: 72)`.
    public var largeSize: CGSize
    
    /// The size for an extra-large avatar.
    ///
    /// The default value is `CGSize(width: 84, height: 84)`.
    public var xLargeSize: CGSize
    
    /// The size for a double extra-large avatar.
    ///
    /// The default value is `CGSize(width: 96, height: 96)`.
    public var xxLargeSize: CGSize
    
    // MARK: - Color
    
    /// The color mode for the initials' background.
    ///
    /// This determines the background color of the initials when they are displayed.
    /// The default value is `.random`.
    public var nameInitialsBackgroundColorMode: AvatarColorMode
    
    /// The color mode for the initials' foreground.
    ///
    /// This determines the text color of the initials when they are displayed.
    /// The default value is `.visible`.
    public var nameInitialsForegroundColorMode: AvatarColorMode
    
    // MARK: - Border
    
    /// The color of the avatar's border.
    ///
    /// The default value is `.clear`.
    public var borderColor: Color
    
    /// The width of the avatar's border.
    ///
    /// The default value is `0`.
    public var borderWidth: CGFloat

    // MARK: - Other Properties
    
    /// The priority of the image request.
    ///
    /// This determines the priority used when fetching the avatar image.
    /// The default value is `.veryHigh`.
    public var priority: ImageRequest.Priority
    
    /// The size configuration for the avatar.
    ///
    /// This specifies the general size category of the avatar. The default value is `.medium`.
    public var size: PKSAvatarSize
    
    /// The radius configuration for the avatar.
    ///
    /// This specifies the corner radius category for the avatar. The default value is `.full`.
    public var radius: PKSRadius
    
    // MARK: - Initializer
    
    /// Initializes a new `PKSAvatarConfiguration` with specified or default values.
    ///
    /// Use this initializer to customize the avatar's sizes, colors, border, and other configurations.
    /// If no parameters are provided, the default values are used.
    ///
    /// - Parameters:
    ///   - smallSize: The size for a small avatar. Defaults to `CGSize(width: 48, height: 48)`.
    ///   - mediumSize: The size for a medium avatar. Defaults to `CGSize(width: 60, height: 60)`.
    ///   - largeSize: The size for a large avatar. Defaults to `CGSize(width: 72, height: 72)`.
    ///   - xLargeSize: The size for an extra-large avatar. Defaults to `CGSize(width: 84, height: 84)`.
    ///   - xxLargeSize: The size for a double extra-large avatar. Defaults to `CGSize(width: 96, height: 96)`.
    ///   - nameInitialsBackgroundColorMode: The color mode for the initials' background. Defaults to `.random`.
    ///   - nameInitialsForegroundColorMode: The color mode for the initials' foreground. Defaults to `.visible`.
    ///   - borderColor: The color of the avatar's border. Defaults to `.clear`.
    ///   - borderWidth: The width of the avatar's border. Defaults to `0`.
    ///   - priority: The priority of the image request. Defaults to `.veryHigh`.
    ///   - size: The size configuration for the avatar. Defaults to `.medium`.
    ///   - radius: The radius configuration for the avatar. Defaults to `.full`.
    public init(
        smallSize: CGSize = CGSize(width: 48, height: 48),
        mediumSize: CGSize = CGSize(width: 60, height: 60),
        largeSize: CGSize = CGSize(width: 72, height: 72),
        xLargeSize: CGSize = CGSize(width: 84, height: 84),
        xxLargeSize: CGSize = CGSize(width: 96, height: 96),
        nameInitialsBackgroundColorMode: AvatarColorMode = .random,
        nameInitialsForegroundColorMode: AvatarColorMode = .visible,
        borderColor: Color = .clear,
        borderWidth: CGFloat = 0,
        priority: ImageRequest.Priority = .veryHigh,
        size: PKSAvatarSize = .medium,
        radius: PKSRadius = .full
    ) {
        self.smallSize = smallSize
        self.mediumSize = mediumSize
        self.largeSize = largeSize
        self.xLargeSize = xLargeSize
        self.xxLargeSize = xxLargeSize
        self.nameInitialsBackgroundColorMode = nameInitialsBackgroundColorMode
        self.nameInitialsForegroundColorMode = nameInitialsForegroundColorMode
        self.borderColor = borderColor
        self.borderWidth = borderWidth
        self.priority = priority
        self.size = size
        self.radius = radius
    }
}
