//
//  PKSAvatar.swift
//
//
//  Created by Ömer Hamid Kamışlı on 8/17/24.
//

import SwiftUI
import Nuke
import NukeUI
import PKSFoundation

@available(iOS 14.0, *)
@MainActor
public struct PKSAvatar<Content: View>: View {
    
    // MARK: - State Variables
    /// The shared configuration object that controls various aspects of the avatar's appearance.
    @StateObject private var configuration: PKSUICoreConfiguration = .shared
    
    /// The size of the avatar as read from the view's geometry.
    @State private var readedSize: CGSize = .zero
    
    /// A Boolean value indicating whether the fallback view is visible.
    @State private var fallbackVisible: Bool = false
    
    // MARK: - Properties
    /// The model representing the avatar's data, such as an image or initials.
    private let avatar: PKSAvatarUIModel
    
    /// The size of the avatar. Defaults to `nil`, in which case the global configuration's size is used.
    private var size: PKSAvatarSize? = nil
    
    /// The corner radius of the avatar. Defaults to `nil`, in which case the global configuration's radius is used.
    private var radius: PKSRadius? = nil
    
    /// The color of the avatar's border. Defaults to `nil`, in which case the global configuration's border color is used.
    private var borderColor: Color? = nil
    
    /// The width of the avatar's border. Defaults to `nil`, in which case the global configuration's border width is used.
    private var borderWidth: CGFloat? = nil
    
    /// A closure that returns a fallback view to be shown when the avatar image is not available. Defaults to `nil`.
    private var fallbackView: (() -> Content)? = nil
    
    /// A Boolean value indicating whether to show the initials when the avatar image is not available. Defaults to `false`.
    private var showInitials: Bool = false
    
    /// The priority of the image request. Defaults to `nil`, in which case the global configuration's priority is used.
    private var priority: ImageRequest.Priority? = nil
    
    /// The color of the initials' foreground. Defaults to `nil`, in which case the global configuration's color is used.
    private var nameInitialsForegroundColor: Color? = nil
    
    /// The color of the initials' background. Defaults to `nil`, in which case the global configuration's color is used.
    private var nameInitialsBackgroundColor: Color? = nil
    
    // MARK: - Initializers
    
    /// Initializes a new avatar view with the specified model and configuration.
    ///
    /// Use this initializer to create an avatar view with a specified model and an optional configuration. This version does not use a fallback view.
    ///
    /// - Parameters:
    ///   - avatar: The model representing the avatar's data.
    ///   - configuration: The configuration object that controls various aspects of the avatar's appearance. Defaults to `PKSUICoreConfiguration.shared`.
    public init(
        avatar: PKSAvatarUIModel,
        configuration: PKSUICoreConfiguration = PKSUICoreConfiguration.shared
    ) where Content == EmptyView {
        self.avatar = avatar
        self._configuration = StateObject(wrappedValue: configuration)
    }
    
    /// Initializes a new avatar view with the specified model, configuration, and fallback view.
    ///
    /// Use this initializer to create an avatar view with a specified model, an optional configuration, and a fallback view.
    ///
    /// - Parameters:
    ///   - avatar: The model representing the avatar's data.
    ///   - configuration: The configuration object that controls various aspects of the avatar's appearance. Defaults to `PKSUICoreConfiguration.shared`.
    ///   - fallbackView: A closure that returns a fallback view to be shown when the avatar image is not available.
    public init(
        avatar: PKSAvatarUIModel,
        configuration: PKSUICoreConfiguration = PKSUICoreConfiguration.shared,
        @ViewBuilder fallbackView: @escaping () -> Content
    ) {
        self.avatar = avatar
        self._configuration = StateObject(wrappedValue: configuration)
        self.fallbackView = fallbackView
    }
    
    // MARK: - Body
    
    /// The content and behavior of the avatar view.
    ///
    /// The body of the avatar view, which conditionally displays the avatar image, initials, or fallback view based on the availability of the image and other properties.
    public var body: some View {
        if readedSize.equalTo(.zero) {
            sizeReader
        } else {
            root
        }
    }
}

// MARK: - View Builders

@available(iOS 14.0, *)
@MainActor
private extension PKSAvatar {
    
    /// A view that reads the size of the avatar and updates the state.
    @ViewBuilder
    var sizeReader: some View {
        Rectangle()
            .fill(Color.blue)
            .getSize($readedSize)
    }
    
    /// The root view that composes the avatar's image, initials, or fallback view.
    @ViewBuilder
    var root: some View {
        if fallbackVisible {
            _fallbackView
        } else {
            Group {
                if let image = avatar.image {
                    avatarImage(image)
                } else if showInitials {
                    nameInitialsView
                } else {
                    _fallbackView
                }
            }
            .frame(width: resolvedSize.width, height: resolvedSize.height, alignment: .center)
            .clipShape(RoundedRectangle(cornerRadius: resolvedRadius))
            .overlay {
                RoundedRectangle(cornerRadius: resolvedRadius)
                    .stroke(resolvedBorderColor, lineWidth: resolvedBorderWidth)
            }
        }
    }
    
    /// A view that displays the avatar's image.
    ///
    /// - Parameter url: The URL of the avatar's image.
    @ViewBuilder
    func avatarImage(_ url: URL) -> some View {
        LazyImage(url: url) { state in
            if let image = state.image {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .clipped()
                    .frame(width: resolvedSize.width, height: resolvedSize.height, alignment: .center)
            } else if (state.error != nil) {
                if showInitials {
                    nameInitialsView
                } else {
                    _fallbackView
                }
            }
        }
        .pipeline(configuration.imagePipeline)
        .priority(priority ?? configuration.avatarGlobalConfiguration.priority)
    }
    
    /// The fallback view to be displayed when the avatar image is not available.
    @ViewBuilder
    var _fallbackView: some View {
        Group {
            if fallbackView != nil {
                fallbackView?()
            } else {
                nameInitialsView
            }
        }
        .onAppear {
            fallbackVisible = true
        }
    }
    
    /// A view that displays the initials of the avatar's name.
    @ViewBuilder
    var nameInitialsView: some View {
        ZStack {
            let _ = print("bg",resolvedInitialsBackgroundColor)
            Rectangle()
                .fill(resolvedInitialsBackgroundColor)
                .clipShape(RoundedRectangle(cornerRadius: resolvedRadius))
                .overlay {
                    RoundedRectangle(cornerRadius: resolvedRadius)
                        .stroke(resolvedBorderColor, lineWidth: resolvedBorderWidth)
                }
                .frame(width: resolvedSize.width, height: resolvedSize.height, alignment: .center)
            if let initials = avatar.initials {
                let _ = print(resolvedInitialsForegroundColor)
                Text(initials)
                    .foregroundStyle(resolvedInitialsForegroundColor)
            }
        }
    }
}

// MARK: - Computed Properties

@available(iOS 14.0, *)
@MainActor
private extension PKSAvatar {
    
    /// Resolves the size of the avatar based on the provided size or the global configuration.
    var resolvedSize: CGSize {
        switch size ?? configuration.avatarGlobalConfiguration.size {
        case .small:
            return configuration.avatarGlobalConfiguration.smallSize
        case .medium:
            return configuration.avatarGlobalConfiguration.mediumSize
        case .large:
            return configuration.avatarGlobalConfiguration.largeSize
        case .xLarge:
            return configuration.avatarGlobalConfiguration.xLargeSize
        case .xxLarge:
            return configuration.avatarGlobalConfiguration.xxLargeSize
        case .fill:
            return readedSize
        case .custom(let width, let height):
            return CGSize(width: width, height: height)
        }
    }
    
    /// Resolves the corner radius of the avatar based on the provided radius or the global configuration.
    var resolvedRadius: CGFloat {
        switch radius ?? configuration.avatarGlobalConfiguration.radius {
        case .sm:
            return configuration.radiusConfiguration.sm
        case .md:
            return configuration.radiusConfiguration.md
        case .lg:
            return configuration.radiusConfiguration.lg
        case .xl:
            return configuration.radiusConfiguration.xl
        case .xxl:
            return configuration.radiusConfiguration.xxl
        case .full:
            return configuration.radiusConfiguration.full
        case .custom(let radius):
            return radius
        case .none:
            return 0
        }
    }
    
    /// Resolves the border color of the avatar based on the provided color or the global configuration.
    var resolvedBorderColor: Color {
        borderColor ?? configuration.avatarGlobalConfiguration.borderColor
    }
    
    /// Resolves the border width of the avatar based on the provided width or the global configuration.
    var resolvedBorderWidth: CGFloat {
        borderWidth ?? configuration.avatarGlobalConfiguration.borderWidth
    }
    
    /// Resolves the background color of the initials based on the provided color or the global configuration.
    var resolvedInitialsBackgroundColor: Color {
        nameInitialsBackgroundColor ?? {
            switch configuration.avatarGlobalConfiguration.nameInitialsBackgroundColorMode {
            case .custom(let color):
                return color
            case .random, .visible:
                return Color.random
            }
        }()
    }
    
    /// Resolves the foreground color of the initials based on the provided color or the global configuration.
    var resolvedInitialsForegroundColor: Color {
        nameInitialsForegroundColor ?? {
            switch configuration.avatarGlobalConfiguration.nameInitialsForegroundColorMode {
            case .custom(let color):
                return color
            case .random:
                return Color.random
            case .visible:
                return resolvedInitialsBackgroundColor.visibleTextColor
            }
        }()
    }
}

// MARK: - Modifier Functions

@available(iOS 14.0, *)
@MainActor
extension PKSAvatar {
    
    /// Applies a transformation to the avatar and returns a new instance.
    ///
    /// - Parameter closure: A closure that takes an inout copy of the avatar and modifies it.
    /// - Returns: A new instance of `PKSAvatar` with the modifications applied.
    private func mapAvatar(_ closure: (inout PKSAvatar) -> Void) -> PKSAvatar {
        var copy = self
        closure(&copy)
        return copy
    }
    
    /// Sets the radius of the avatar.
    ///
    /// Use this function to change the corner radius of the avatar.
    ///
    /// - Parameter radius: The new radius for the avatar.
    /// - Returns: A `PKSAvatar` instance with the updated radius.
    public func avatarRadius(_ radius: PKSRadius) -> PKSAvatar {
        mapAvatar { $0.radius = radius }
    }
    
    /// Sets the size of the avatar.
    ///
    /// Use this function to change the size of the avatar, selecting from predefined sizes or providing custom dimensions.
    ///
    /// - Parameter size: The new size for the avatar.
    /// - Returns: A `PKSAvatar` instance with the updated size.
    public func avatarSize(_ size: PKSAvatarSize) -> PKSAvatar {
        mapAvatar { $0.size = size }
    }
    
    /// Sets the border color of the avatar.
    ///
    /// Use this function to change the border color of the avatar.
    ///
    /// - Parameter color: The new border color for the avatar.
    /// - Returns: A `PKSAvatar` instance with the updated border color.
    public func avatarBorderColor(_ color: Color) -> PKSAvatar {
        mapAvatar { $0.borderColor = color }
    }
    
    /// Sets the border width of the avatar.
    ///
    /// Use this function to change the border width of the avatar.
    ///
    /// - Parameter width: The new border width for the avatar.
    /// - Returns: A `PKSAvatar` instance with the updated border width.
    public func avatarBorderWidth(_ width: CGFloat) -> PKSAvatar {
        mapAvatar { $0.borderWidth = width }
    }
    
    /// Sets the fallback view to be displayed when the avatar image is not available.
    ///
    /// Use this function to provide a custom fallback view that will be displayed when the avatar image cannot be loaded.
    ///
    /// - Parameter fallbackView: A closure that returns the fallback view.
    /// - Returns: A new `PKSAvatar` instance with the updated fallback view.
    public func avatarFallbackView<NewContent: View>(
        @ViewBuilder fallbackView: @escaping () -> NewContent
    ) -> PKSAvatar<NewContent> {
        PKSAvatar<NewContent>(
            avatar: avatar,
            configuration: configuration,
            fallbackView: fallbackView
        )
    }
    
    /// Sets whether to show initials when the avatar image is not available.
    ///
    /// Use this function to control whether the initials should be displayed when the avatar image is not available.
    ///
    /// - Parameter show: A Boolean value that determines whether the initials are shown.
    /// - Returns: A `PKSAvatar` instance with the updated initials visibility setting.
    public func showInitials(_ show: Bool) -> PKSAvatar {
        mapAvatar { $0.showInitials = show }
    }
    
    /// Sets the priority of the image request for the avatar.
    ///
    /// Use this function to specify the priority of the image request used to load the avatar image.
    ///
    /// - Parameter priority: The new image request priority.
    /// - Returns: A `PKSAvatar` instance with the updated image request priority.
    public func avatarPriority(_ priority: ImageRequest.Priority) -> PKSAvatar {
        mapAvatar { $0.priority = priority }
    }
    
    /// Sets the foreground color of the initials.
    ///
    /// Use this function to specify the color of the initials' text when they are displayed.
    ///
    /// - Parameter color: The new foreground color for the initials.
    /// - Returns: A `PKSAvatar` instance with the updated initials foreground color.
    public func nameInitialsForegroundColor(_ color: Color) -> PKSAvatar {
        mapAvatar { $0.nameInitialsForegroundColor = color }
    }
    
    /// Sets the background color of the initials.
    ///
    /// Use this function to specify the color of the initials' background when they are displayed.
    ///
    /// - Parameter color: The new background color for the initials.
    /// - Returns: A `PKSAvatar` instance with the updated initials background color.
    public func nameInitialsBackgroundColor(_ color: Color) -> PKSAvatar {
        mapAvatar { $0.nameInitialsBackgroundColor = color }
    }
}


// MARK: - Previews
@available(iOS 14.0, *)
#Preview {
    VStack {
        ScrollView(showsIndicators: false) {
            ForEach(PKSAvatarUIModel.allOptions, id: \.0) { (title, avatar) in
                Section {
                    ForEach(PKSAvatarSize.allCases) { size in
                        VStack(alignment: .leading) {
                            Text(size.id.replacingOccurrences(of: "PKSAvatarSize", with: "Avatar Size "))
                                .font(.title2)
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack {
                                    ForEach(PKSRadius.allCases) { radius in
                                        VStack {
                                            Text(radius.id.replacingOccurrences(of: "PKSRadius", with: "Radius: "))
                                            PKSAvatar(avatar: avatar)
                                                .avatarSize(size)
                                                .avatarRadius(radius)
                                        }
                                        .padding()
                                        .border(Color.blue)
                                    }
                                }
                                
                            }
                        }
                    }
                } header: {
                    Text(title)
                        .font(.title)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        }
    }
    .padding(.horizontal)
}

@available(iOS 14.0, *)
#Preview("Every available functionality") {
    
    ScrollView {
        // Default Avatar
        VStack {
            Text("Default Avatar")
                .font(.title3)
            PKSAvatar(avatar: .mockWithImage)
        }
        
        // Avatar with Custom Size
        VStack {
            Text("Avatar with Custom Size")
                .font(.title3)
            PKSAvatar(avatar: .mockWithImage)
                .avatarSize(.custom(width: 100, height: 100))
        }
        
        VStack {
            Text("Large Radius Avatar")
                .font(.title3)
            PKSAvatar(avatar: .mockWithImage)
                .avatarRadius(.xl)
        }
        
        VStack {
            Text("Avatar with Border")
                .font(.title3)
            PKSAvatar(avatar: .mockWithImage)
                .avatarBorderColor(.blue)
                .avatarBorderWidth(3)
        }
        
        // Avatar with Initials
        VStack {
            Text("Avatar with Initials")
                .font(.title3)
            PKSAvatar(avatar: PKSAvatarUIModel(initials: "AI"))
                .showInitials(true)
        }
        
        VStack {
            Text("Avatar with Custom Initials Colors")
                .font(.title3)
            PKSAvatar(avatar: PKSAvatarUIModel(initials: "AI"))
                .showInitials(true)
                .nameInitialsForegroundColor(.white)
                .nameInitialsBackgroundColor(.red)
        }
        
        
        VStack {
            Text("Avatar with Fallback View")
                .font(.title3)
            PKSAvatar(avatar: PKSAvatarUIModel())
                .avatarFallbackView {
                    VStack {
                        Image(systemName: "person.fill")
                        Text("Fallback")
                    }
                    .background(Color.gray)
                }
        }
        
        VStack {
            Text("Avatar with High Priority Image Loading")
                .font(.title3)
            PKSAvatar(avatar: .mockWithImage)
                .avatarPriority(.veryHigh)
        }

        VStack {
            Text("Avatar without Radius")
                .font(.title3)
            PKSAvatar(avatar: .mockWithImage)
                .avatarRadius(.none)
        }
    }
    .padding()
    .previewLayout(.sizeThatFits)
    
}
