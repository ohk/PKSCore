//
//  PKSAvatar.swift
//  
//
//  Created by Ömer Hamid Kamışlı on 8/17/24.
//

import SwiftUI

public struct PKSAvatar: View {
    @StateObject private var configuration: PKSUICoreConfiguration = .shared
    
    private let avatar: PKSAvatarUIModel
    private let size: PKSAvatarSize
    
    public init(
        avatar: PKSAvatarUIModel,
        size: PKSAvatarSize = .medium,
        configuration: PKSUICoreConfiguration = PKSUICoreConfiguration.shared
    ) {
        self.avatar = avatar
        self.size = size
        self._configuration = StateObject(wrappedValue: configuration)
    }
    
    public var body: some View {
        Group {
            if let image = avatar.image {
                // TODO: ADD IMAGE SUPPORT
                Circle()
                    .fill(Color.blue)
                    .aspectRatio(1, contentMode: .fit)
            } else if let initials = avatar.initials {
                ZStack {
                    Circle()
                        .fill(initialsBackgroundColor)
                    Text(initials)
                }
            }
        }
        .frame(width: _size?.width, height: _size?.height, alignment: .center)
    }
    
    private var initialsBackgroundColor: Color {
        switch configuration.avatarGlobalConfiguration.nameInitialsBackgroundColorMode {
        case .custom(let color):
            return color
        case .random:
            return .blue
        }
    }
    
    private var _size: CGSize? {
        switch size {
        case .small:
            return configuration.avatarGlobalConfiguration.smallSize
        case .medium:
            return configuration.avatarGlobalConfiguration.mediumSize
        case .large:
            return configuration.avatarGlobalConfiguration.largeSize
        case .xLarge:
            return configuration.avatarGlobalConfiguration
                .xLargeSize
        case .xxLarge:
            return configuration.avatarGlobalConfiguration.xxLargeSize
        case .fill:
            return nil
        case .custom(let width, let height):
            return CGSize(width: width, height: height)
        }
    }
    
}

#Preview {
    
    ScrollView {
        HStack {
            Spacer()
            VStack(alignment: .leading) {
                Text(verbatim: "With Out Images")
                PKSAvatar(avatar: .mockWithOutImage, size: .small)
                PKSAvatar(avatar: .mockWithOutImage, size: .medium)
                PKSAvatar(avatar: .mockWithOutImage, size: .large)
                PKSAvatar(avatar: .mockWithOutImage, size: .xLarge)
                PKSAvatar(avatar: .mockWithOutImage, size: .xxLarge)
                PKSAvatar(avatar: .mockWithOutImage, size: .custom(width: 100, height: 100))
                PKSAvatar(avatar: .mockWithOutImage, size: .fill)
            }
            Spacer()
            Divider()
            Spacer()
            VStack(alignment: .leading) {
                Text(verbatim: "With Images")
                PKSAvatar(avatar: .mockWithImage, size: .small)
                PKSAvatar(avatar: .mockWithImage, size: .medium)
                PKSAvatar(avatar: .mockWithImage, size: .large)
                PKSAvatar(avatar: .mockWithImage, size: .xLarge)
                PKSAvatar(avatar: .mockWithImage, size: .xxLarge)
                PKSAvatar(avatar: .mockWithImage, size: .custom(width: 100, height: 100))
                PKSAvatar(avatar: .mockWithOutImage, size: .fill)
            }
            Spacer()
        }
    }
}


