//
//  PKSMessageContent.swift
//  
//
//  Created by Ömer Hamid Kamışlı on 8/20/24.
//

import Foundation

/// A structure representing the content of a message in a chat or messaging interface.
///
/// This struct can hold text, image URL, and video URL, allowing for versatile message content.
/// It conforms to `Identifiable` for unique identification and `Equatable` for comparison.
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public struct PKSMessageContent: Identifiable, Equatable {
    
    /// The text content of the message. Can be nil if the message doesn't contain text.
    public let text: String?
    
    /// The URL of an image associated with the message. Can be nil if there's no image.
    public let imageURL: URL?
    
    /// The URL of a video associated with the message. Can be nil if there's no video.
    public let videoURL: URL?
    
    /// A unique identifier for the message content.
    public let id: String
    
    /// Initializes a new message content instance.
    /// - Parameters:
    ///   - text: The text content of the message. Defaults to nil.
    ///   - imageURL: The URL of an associated image. Defaults to nil.
    ///   - videoURL: The URL of an associated video. Defaults to nil.
    ///   - id: A unique identifier for the content. Defaults to a new UUID string.
    public init(text: String? = nil, imageURL: URL? = nil, videoURL: URL? = nil, id: String = UUID().uuidString) {
        self.text = text
        self.imageURL = imageURL
        self.videoURL = videoURL
        self.id = id
    }
    
    /// Indicates whether the message has non-empty text content.
    public var hasText: Bool {
        return text != nil && !text!.isEmpty
    }
    
    /// Indicates whether the message has an associated image.
    public var hasImage: Bool {
        return imageURL != nil
    }
    
    /// Indicates whether the message has an associated video.
    public var hasVideo: Bool {
        return videoURL != nil
    }
    
    /// Indicates whether the message has any media content (image or video).
    public var hasMedia: Bool {
        return hasImage || hasVideo
    }
    
    /// Creates a message content instance with only text.
    /// - Parameter text: The text content of the message.
    /// - Returns: A new `PKSMessageContent` instance with the given text.
    public static func textOnly(_ text: String) -> PKSMessageContent {
        return PKSMessageContent(text: text)
    }
    
    /// Creates a message content instance with only an image.
    /// - Parameter url: The URL of the image.
    /// - Returns: A new `PKSMessageContent` instance with the given image URL.
    public static func imageOnly(_ url: URL) -> PKSMessageContent {
        return PKSMessageContent(imageURL: url)
    }
    
    /// Creates a message content instance with only a video.
    /// - Parameter url: The URL of the video.
    /// - Returns: A new `PKSMessageContent` instance with the given video URL.
    public static func videoOnly(_ url: URL) -> PKSMessageContent {
        return PKSMessageContent(videoURL: url)
    }
    
    /// Creates a message content instance with both text and an image.
    /// - Parameters:
    ///   - text: The text content of the message.
    ///   - imageURL: The URL of the associated image.
    /// - Returns: A new `PKSMessageContent` instance with the given text and image URL.
    public static func textAndImage(text: String, imageURL: URL) -> PKSMessageContent {
        return PKSMessageContent(text: text, imageURL: imageURL)
    }
    
    /// Creates a message content instance with both text and a video.
    /// - Parameters:
    ///   - text: The text content of the message.
    ///   - videoURL: The URL of the associated video.
    /// - Returns: A new `PKSMessageContent` instance with the given text and video URL.
    public static func textAndVideo(text: String, videoURL: URL) -> PKSMessageContent {
        return PKSMessageContent(text: text, videoURL: videoURL)
    }
}

// MARK: - Mock Data
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public extension PKSMessageContent {
    /// A mock message content with only text.
    static var mockTextOnly: Self {
        .textOnly("Hello! This is a text-only message.")
    }
    
    /// A mock message content with only an image.
    static var mockImageOnly: Self {
        .imageOnly(URL(string: "https://example.com/image.jpg")!)
    }
    
    /// A mock message content with only a video.
    static var mockVideoOnly: Self {
        .videoOnly(URL(string: "https://example.com/video.mp4")!)
    }
    
    /// A mock message content with both text and an image.
    static var mockTextAndImage: Self {
        .textAndImage(text: "Check out this image!", imageURL: URL(string: "https://example.com/image.jpg")!)
    }
    
    /// A mock message content with both text and a video.
    static var mockTextAndVideo: Self {
        .textAndVideo(text: "Here's the video I mentioned.", videoURL: URL(string: "https://example.com/video.mp4")!)
    }
    
    /// An array of all available mock message contents.
    static var allMocks: [Self] {
        [
            .mockTextOnly,
            .mockImageOnly,
            .mockVideoOnly,
            .mockTextAndImage,
            .mockTextAndVideo
        ]
    }
}
