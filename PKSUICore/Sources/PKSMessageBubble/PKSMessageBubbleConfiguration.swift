import SwiftUI

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public struct PKSMessageBubbleConfiguration {
    public var incomingBubbleColor: Color
    public var outgoingBubbleColor: Color
    public var incomingTextColor: Color
    public var outgoingTextColor: Color
    
    public init(
        incomingBubbleColor: Color = Color(.systemGray5),
        outgoingBubbleColor: Color = Color(.systemBlue),
        incomingTextColor: Color = .primary,
        outgoingTextColor: Color = .white
    ) {
        self.incomingBubbleColor = incomingBubbleColor
        self.outgoingBubbleColor = outgoingBubbleColor
        self.incomingTextColor = incomingTextColor
        self.outgoingTextColor = outgoingTextColor
    }
}