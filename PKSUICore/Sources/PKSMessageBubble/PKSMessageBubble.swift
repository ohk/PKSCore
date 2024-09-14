//
//  PKSMessageBubble.swift
//
//
//  Created by Ömer Hamid Kamışlı on 8/17/24.
//

import SwiftUI
import PKSFoundation

@available(iOS 14.0, *)
@MainActor
public struct PKSMessageBubble<Content: View>: View {
    
    // MARK: - State Variables
    @StateObject private var configuration: PKSUICoreConfiguration = .shared
    
    // MARK: - Properties
    private let message: PKSMessageBubbleUIModel
    private var showAvatar: Bool = true
    private var showDate: Bool = true
    private var showStatus: Bool = true
    private var dateStyle: PKSBaseDateStyle = .chatRelative
    private var avatarSize: PKSAvatarSize = .small
    private var avatarRadius: PKSRadius = .full
    private var bubbleColor: Color? = nil
    private var textColor: Color? = nil
    private var assetErrorView: (() -> Content)? = nil
    
    // MARK: - Initializers
    public init(
        message: PKSMessageBubbleUIModel,
        configuration: PKSUICoreConfiguration = PKSUICoreConfiguration.shared
    ) where Content == EmptyView {
        self.message = message
        self._configuration = StateObject(wrappedValue: configuration)
    }
    
    public init(
        message: PKSMessageBubbleUIModel,
        configuration: PKSUICoreConfiguration = PKSUICoreConfiguration.shared,
        @ViewBuilder assetErrorView: @escaping () -> Content
    ) {
        self.message = message
        self._configuration = StateObject(wrappedValue: configuration)
        self.assetErrorView = assetErrorView
    }
    
    // MARK: - Body
    public var body: some View {
        HStack(spacing: 8) {
            if !message.isOutgoing && showAvatar {
                avatarView
            }
            
            VStack(alignment: message.isOutgoing ? .trailing : .leading, spacing: 4) {
                messageBubble
                
                if showDate {
                    dateView
                }
            }
            
            if message.isOutgoing && showAvatar {
                avatarView
            }
        }
    }
}

// MARK: - View Builders
@available(iOS 14.0, *)
@MainActor
private extension PKSMessageBubble {
    
    @ViewBuilder
    var avatarView: some View {
        PKSAvatar(avatar: message.owner)
            .avatarSize(avatarSize)
            .avatarRadius(avatarRadius)
    }
    
    @ViewBuilder
    var messageBubble: some View {
        if let image = message.message.imageURL {
            // Nuke Image
            
        }
        
        if let video = message.message.videoURL {
            
        }
        Text(message.message.text ?? "TEST")
    }
    
    @ViewBuilder
    var dateView: some View {
        Text(message.date, style: dateStyle)
            .font(.caption2)
            .foregroundColor(.secondary)
    }
    
    @ViewBuilder
    var statusView: some View {
        if showStatus && message.isOutgoing {
            switch message.status {
            case .sent:
                Image(systemName: "checkmark")
            case .delivered:
                Image(systemName: "checkmark.circle")
            case .read:
                Image(systemName: "checkmark.circle.fill")
            case .failed:
                Image(systemName: "xmark")
            }
        }
    }
}

// MARK: - Computed Properties
@available(iOS 14.0, *)
@MainActor
private extension PKSMessageBubble {
    var resolvedBubbleColor: Color {
        bubbleColor ?? (message.isOutgoing ? configuration.messageBubbleConfiguration.outgoingBubbleColor : configuration.messageBubbleConfiguration.incomingBubbleColor)
    }
    
    var resolvedTextColor: Color {
        textColor ?? (message.isOutgoing ? configuration.messageBubbleConfiguration.outgoingTextColor : configuration.messageBubbleConfiguration.incomingTextColor)
    }
}

// MARK: - Modifier Functions
@available(iOS 14.0, *)
@MainActor
extension PKSMessageBubble {
    private func mapMessageBubble(_ closure: (inout PKSMessageBubble) -> Void) -> PKSMessageBubble {
        var copy = self
        closure(&copy)
        return copy
    }
    
    public func showAvatar(_ show: Bool) -> PKSMessageBubble {
        mapMessageBubble { $0.showAvatar = show }
    }
    
    public func showDate(_ show: Bool) -> PKSMessageBubble {
        mapMessageBubble { $0.showDate = show }
    }
    
    public func showStatus(_ show: Bool) -> PKSMessageBubble {
        mapMessageBubble { $0.showStatus = show }
    }
    
    public func dateStyle(_ style: PKSBaseDateStyle) -> PKSMessageBubble {
        mapMessageBubble { $0.dateStyle = style }
    }
    
    public func avatarSize(_ size: PKSAvatarSize) -> PKSMessageBubble {
        mapMessageBubble { $0.avatarSize = size }
    }
    
    public func avatarRadius(_ radius: PKSRadius) -> PKSMessageBubble {
        mapMessageBubble { $0.avatarRadius = radius }
    }
    
    public func bubbleColor(_ color: Color) -> PKSMessageBubble {
        mapMessageBubble { $0.bubbleColor = color }
    }
    
    public func textColor(_ color: Color) -> PKSMessageBubble {
        mapMessageBubble { $0.textColor = color }
    }
    
    public func messageAssetErrorView<NewContent: View>(
        @ViewBuilder assetErrorView: @escaping () -> NewContent
    ) -> PKSMessageBubble<NewContent> {
        PKSMessageBubble<NewContent>(
            message: message,
            configuration: configuration,
            assetErrorView: assetErrorView
        )
    }
}

// MARK: - Previews
@available(iOS 14.0, *)
#Preview {
    VStack(spacing: 20) {
        ForEach(PKSMessageBubbleUIModel.allMocks) { data in
            PKSMessageBubble(message: data)
        }
    }
    .padding()
}
