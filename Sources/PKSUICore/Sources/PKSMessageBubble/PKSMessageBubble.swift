//
//  PKSMessageBubble.swift
//
//
//  Created by Ömer Hamid Kamışlı on 8/17/24.
//

import SwiftUI
import PKSFoundation

public struct PKSMessageBubble: View {
    @StateObject private var configuration: PKSUICoreConfiguration
    
    private let message: PKSMessageUIModel
    
    init(message: PKSMessageUIModel, configuration: PKSUICoreConfiguration = .shared) {
        self.message = message
        self._configuration = StateObject(wrappedValue: configuration)
    }
    
    public var body: some View {
        HStack(alignment: .bottom) {
            VStack {
                if let image = message.image {
                    // TODO: Image
                }
                
                if let text = message.text {
                    Text(text)
                }
                
                Text(message.date, PKSDateStyle: PKSBaseDateStyle.chatRelative)
                
            }
            if let user = message.user {
//                PKSAvatar(avatar: user, size: .small, configuration: configuration)
            }
        }
    }
}

#Preview {
    PKSMessageBubble(message: .mockOnlyText)
}


public extension Text {
    init?(_ date: Date?, PKSDateStyle: PKSDateStyle) {
        guard let date = date else { return nil }
        self.init(PKSDateStyle.formatted(date: date))
    }
}

