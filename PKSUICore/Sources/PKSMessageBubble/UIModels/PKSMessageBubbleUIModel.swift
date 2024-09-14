//
//  PKSMessageBubbleUIModel.swift
//  
//
//  Created by Ömer Hamid Kamışlı on 8/17/24.
//

import Foundation
import SwiftUI

/// A model representing a message bubble in a chat interface.
///
/// This struct encapsulates all the necessary information to display a message bubble,
/// including the message content, sender information, timestamp, and status.
public struct PKSMessageBubbleUIModel: Identifiable {
    /// A unique identifier for the message bubble.
    public var id: String
    
    /// The avatar and information of the message sender.
    var owner: PKSAvatarUIModel
    
    /// The content of the message.
    var message: PKSMessageContent
    
    /// The timestamp when the message was sent or received.
    var date: Date
    
    /// The current status of the message (e.g., sent, delivered, read).
    var status: PKSMessageStatus
    
    /// A boolean indicating whether this message was sent by the current user.
    var isOutgoing: Bool
    
    /// Creates a new message bubble UI model.
    ///
    /// - Parameters:
    ///   - id: A unique identifier for the message. Defaults to a new UUID string.
    ///   - owner: The avatar and information of the message sender.
    ///   - message: The content of the message.
    ///   - date: The timestamp of the message.
    ///   - status: The current status of the message.
    ///   - isOutgoing: Whether this message was sent by the current user.
    public init(
        id: String = UUID().uuidString,
        owner: PKSAvatarUIModel,
        message: PKSMessageContent,
        date: Date,
        status: PKSMessageStatus,
        isOutgoing: Bool
    ) {
        self.id = id
        self.owner = owner
        self.message = message
        self.date = date
        self.status = status
        self.isOutgoing = isOutgoing
    }
}


// MARK: - Mock Data

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public extension PKSMessageBubbleUIModel {
    /// A mock message bubble with text content for an incoming message.
    static var mockIncomingText: Self {
        PKSMessageBubbleUIModel(
            owner: .mockWithImage,
            message: .textOnly("Hello! How are you doing today?"),
            date: Date(),
            status: .delivered,
            isOutgoing: false
        )
    }
    
    /// A mock message bubble with text content for an outgoing message.
    static var mockOutgoingText: Self {
        PKSMessageBubbleUIModel(
            owner: .mockWithOutImage,
            message: .textOnly("I'm doing great, thanks for asking!"),
            date: Date().addingTimeInterval(-300), // 5 minutes ago
            status: .read,
            isOutgoing: true
        )
    }
    
    /// A mock message bubble with an image for an incoming message.
    static var mockIncomingImage: Self {
        PKSMessageBubbleUIModel(
            owner: .mockWithImage,
            message: .imageOnly(URL(string: "https://example.com/image.jpg")!),
            date: Date().addingTimeInterval(-3600), // 1 hour ago
            status: .delivered,
            isOutgoing: false
        )
    }
    
    /// A mock message bubble with an image and text for an outgoing message.
    static var mockOutgoingImageAndText: Self {
        PKSMessageBubbleUIModel(
            owner: .mockWithOutImage,
            message: .textAndImage(
                text: "Check out this amazing view!",
                imageURL: URL(string: "https://example.com/view.jpg")!
            ),
            date: Date().addingTimeInterval(-7200), // 2 hours ago
            status: .sent,
            isOutgoing: true
        )
    }
    
    /// A mock message bubble with a video for an incoming message.
    static var mockIncomingVideo: Self {
        PKSMessageBubbleUIModel(
            owner: .mockWithImage,
            message: .videoOnly(URL(string: "https://example.com/video.mp4")!),
            date: Date().addingTimeInterval(-86400), // 1 day ago
            status: .delivered,
            isOutgoing: false
        )
    }
    
    /// A mock message bubble with a video and text for an outgoing message.
    static var mockOutgoingVideoAndText: Self {
        PKSMessageBubbleUIModel(
            owner: .mockWithOutImage,
            message: .textAndVideo(
                text: "Here's the video I promised!",
                videoURL: URL(string: "https://example.com/promised-video.mp4")!
            ),
            date: Date().addingTimeInterval(-172800), // 2 days ago
            status: .read,
            isOutgoing: true
        )
    }
    
    /// A mock message bubble for a failed outgoing message.
    static var mockFailedOutgoing: Self {
        PKSMessageBubbleUIModel(
            owner: .mockWithOutImage,
            message: .textOnly("This message failed to send."),
            date: Date().addingTimeInterval(-60), // 1 minute ago
            status: .failed,
            isOutgoing: true
        )
    }
    
    /// An array of all available mock message bubbles.
    static var allMocks: [Self] {
        [
            .mockIncomingText,
            .mockOutgoingText,
            .mockIncomingImage,
            .mockOutgoingImageAndText,
            .mockIncomingVideo,
            .mockOutgoingVideoAndText,
            .mockFailedOutgoing
        ]
    }
}

