//
//  PKSImageView.swift
//
//
//  Created by Ömer Hamid Kamışlı on 8/28/24.
//

import SwiftUI
import Nuke

/// A configuration structure for customizing image loading and caching behavior.
///
/// Use this structure to configure the image pipeline and set default priorities for image requests.
public struct PKSImageConfiguration {
    /// The image pipeline used for loading and caching images.
    public var imagePipeline: ImagePipeline 

    /// The default priority for image requests.
    public var defaultPriority: ImageRequest.Priority

    /// The default aspect ratio for images.
    public var defaultAspectRatio: CGFloat

    /// The default border color for images.
    public var defaultBorderColor: Color

    /// The default border width for images.
    public var defaultBorderWidth: CGFloat

    /// The default corner radius for images.
    public var defaultCornerRadius: CGFloat

    /// The default content mode for images.
    public var defaultContentMode: ContentMode
    
    
    /// Creates a new image configuration.
    ///
    /// - Parameters:
    ///   - pipeline: An optional custom image pipeline. If not provided, a default pipeline will be created.
    ///   - priority: The default priority for image requests. Defaults to `.normal`.
    ///   - aspectRatio: The default aspect ratio for images. Defaults to `1`.
    ///   - borderColor: The default border color for images. Defaults to `.clear`.
    ///   - borderWidth: The default border width for images. Defaults to `0`.
    ///   - cornerRadius: The default corner radius for images. Defaults to `0`.
    ///   - contentMode: The default content mode for images. Defaults to `.fill`.
    public init(
        pipeline: ImagePipeline? = nil,
        priority: ImageRequest.Priority = .normal,
        aspectRatio: CGFloat = 1,
        borderColor: Color = .clear,
        borderWidth: CGFloat = 0,
        cornerRadius: CGFloat = 0,
        contentMode: ContentMode = .fill
    ) {
        self.imagePipeline = pipeline ?? ImagePipeline {
            $0.dataCachePolicy = .automatic
            $0.isResumableDataEnabled = true
            $0.isProgressiveDecodingEnabled = true
            $0.isRateLimiterEnabled = true
            $0.isTaskCoalescingEnabled = true
        }
        self.defaultPriority = priority
        self.defaultAspectRatio = aspectRatio
        self.defaultBorderColor = borderColor
        self.defaultBorderWidth = borderWidth
        self.defaultCornerRadius = cornerRadius
        self.defaultContentMode = contentMode
    }
}