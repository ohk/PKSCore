//
//  PKSImageView.swift
//
//
//  Created by Ömer Hamid Kamışlı on 8/28/24.
//

import SwiftUI
import Nuke
import NukeUI


@available(iOS 14.0, *)
@MainActor
public struct PKSImageView<LoadingView: View, ErrorView: View>: View {
    
    // MARK: - State Variables
    
    /// The shared configuration object that controls various aspects of the image view's appearance.
    @StateObject private var configuration = PKSUICoreConfiguration.shared
    
    /// The URL of the image to be displayed.
    @State private var url: URL? = nil

    /// The size of the image view as read from the view's geometry.
    @State private var readedSize: CGSize = .zero
    
    // MARK: - Custom Views
    
    /// A closure that returns a custom loading view to be displayed while the image is loading.
    var loadingView: (() -> LoadingView)? = nil
    
    /// A closure that returns a custom error view to be displayed if the image fails to load.
    var errorView: (() -> ErrorView)? = nil
    
    // MARK: - Image Properties
    
    /// The priority of the image request.
    var priority: ImageRequest.Priority? = nil
    
    /// The aspect ratio of the image.
    var aspectRatio: CGFloat? = nil
    
    /// The content mode of the image.
    var contentMode: ContentMode? = nil
    
    /// The corner radius of the image view.
    var cornerRadius: CGFloat? = nil
    
    /// The width of the image view's border.
    var borderWidth: CGFloat? = nil
    
    /// The color of the image view's border.
    var borderColor: Color? = nil
    
    /// The fixed size of the image view.
    var fixedSize: CGSize? = nil
    
    /// The alignment of the image within its frame.
    var alignment: Alignment = .center
    
    // MARK: - Initializers
    
    /// Initializes a new `PKSImageView` with the specified URL and configuration.
    ///
    /// Use this initializer to create an image view with a specified URL and an optional configuration. This version does not use custom loading or error views.
    ///
    /// - Parameters:
    ///   - url: The URL of the image to be displayed.
    ///   - configuration: The configuration object that controls various aspects of the image view's appearance. Defaults to `PKSUICoreConfiguration.shared`.
    public init(url: URL, configuration: PKSUICoreConfiguration = .shared) where LoadingView == EmptyView, ErrorView == EmptyView {
        self.url = url
        self._configuration = StateObject(wrappedValue: configuration)
    }
    
    /// Initializes a new `PKSImageView` with the specified URL, configuration, and custom loading view.
    ///
    /// Use this initializer to create an image view with a specified URL, an optional configuration, and a custom loading view.
    ///
    /// - Parameters:
    ///   - url: The URL of the image to be displayed.
    ///   - configuration: The configuration object that controls various aspects of the image view's appearance. Defaults to `PKSUICoreConfiguration.shared`.
    ///   - loadingView: A closure that returns the custom loading view to be displayed while the image is loading.
    public init(url: URL, configuration: PKSUICoreConfiguration = .shared, @ViewBuilder loadingView: @escaping () -> LoadingView) where ErrorView == EmptyView {
        self.url = url
        self._configuration = StateObject(wrappedValue: configuration)
        self.loadingView = loadingView
    }
    
    /// Initializes a new `PKSImageView` with the specified URL, configuration, and custom error view.
    ///
    /// Use this initializer to create an image view with a specified URL, an optional configuration, and a custom error view.
    ///
    /// - Parameters:
    ///   - url: The URL of the image to be displayed.
    ///   - configuration: The configuration object that controls various aspects of the image view's appearance. Defaults to `PKSUICoreConfiguration.shared`.
    ///   - errorView: A closure that returns the custom error view to be displayed if the image fails to load.
    public init(url: URL, configuration: PKSUICoreConfiguration = .shared, @ViewBuilder errorView: @escaping () -> ErrorView) where LoadingView == EmptyView {
        self.url = url
        self._configuration = StateObject(wrappedValue: configuration)
        self.errorView = errorView
    }
    
    /// Initializes a new `PKSImageView` with the specified URL, configuration, custom loading view, and custom error view.
    ///
    /// Use this initializer to create an image view with a specified URL, an optional configuration, a custom loading view, and a custom error view.
    ///
    /// - Parameters:
    ///   - url: The URL of the image to be displayed.
    ///   - configuration: The configuration object that controls various aspects of the image view's appearance. Defaults to `PKSUICoreConfiguration.shared`.
    ///   - loadingView: A closure that returns the custom loading view to be displayed while the image is loading.
    ///   - errorView: A closure that returns the custom error view to be displayed if the image fails to load.
    public init(url: URL, configuration: PKSUICoreConfiguration = .shared, @ViewBuilder loadingView: @escaping () -> LoadingView, @ViewBuilder errorView: @escaping () -> ErrorView) {
        self.url = url
        self._configuration = StateObject(wrappedValue: configuration)
        self.loadingView = loadingView
        self.errorView = errorView
    }

    // MARK: - Body
    
    /// The content and behavior of the image view.
    ///
    /// The body of the image view, which conditionally displays the image, loading view, or error view based on the state of the image loading process.
    public var body: some View {
        if readedSize.equalTo(.zero) {
            sizeReader
        } else {
            imageView
        }
    }
}

// MARK: - Private Views

private extension PKSImageView {
    
    /// A view that reads the size of the image view and updates the state.
    @ViewBuilder
    var sizeReader: some View {
        Rectangle()
            .fill(Color.blue)
            .getSize($readedSize)
    }
    
    /// The main image view that displays the image, loading view, or error view based on the state of the image loading process.
    @ViewBuilder
    var imageView: some View {
        if let url {
            LazyImage(url: url) { state in
                if let image = state.image {
                    image
                        .resizable()
                        .aspectRatio(resolvedAspectRatio, contentMode: resolvedContentMode)
                        .clipped()
                        .frame(width: resolvedSize.width, height: resolvedSize.height, alignment: .center)
                        .clipShape(
                            RoundedRectangle(cornerRadius: resolvedCornerRadius)
                        )
                        .overlay {
                            RoundedRectangle(cornerRadius: resolvedCornerRadius)
                                .stroke(resolvedBorderColor, lineWidth: resolvedBorderWidth)
                        }
                    
                } else if (state.error != nil) {
                    _errorView
                } else {
                    _loadingView
                }
            }
            .pipeline(configuration.imageConfiguration.imagePipeline)
            .priority(priority ?? configuration.imageConfiguration.defaultPriority)
            .aspectRatio(resolvedAspectRatio, contentMode: resolvedContentMode)
            .frame(width: resolvedSize.width, height: resolvedSize.height, alignment: .center)
        }
    }
    
    /// The loading view to be displayed while the image is loading.
    @ViewBuilder
    var _loadingView: some View {
        if let loadingView = loadingView {
            loadingView()
        } else {
            defaultLoadingView
        }
    }
    
    /// The default loading view, which displays a progress indicator.
    @ViewBuilder
    var defaultLoadingView: some View {
        ProgressView()
            .progressViewStyle(.circular)
    }
    
    /// The error view to be displayed if the image fails to load.
    @ViewBuilder
    var _errorView: some View {
        if let errorView = errorView {
            errorView()
        } else {
            defaultErrorView
        }
    }

    /// The default error view, which displays an error message.
    @ViewBuilder
    var defaultErrorView: some View {
        Text("Error")
    }
}

// MARK: - Resolved Properties

private extension PKSImageView {
    
    /// The resolved size of the image view.
    var resolvedSize: CGSize {
        readedSize
    }

    /// The resolved aspect ratio of the image.
    var resolvedAspectRatio: CGFloat {
        aspectRatio ?? configuration.imageConfiguration.defaultAspectRatio
    }

    /// The resolved border color of the image view.
    var resolvedBorderColor: Color {
        borderColor ?? configuration.imageConfiguration.defaultBorderColor
    }

    /// The resolved border width of the image view.
    var resolvedBorderWidth: CGFloat {
        borderWidth ?? configuration.imageConfiguration.defaultBorderWidth
    }

    /// The resolved corner radius of the image view.
    var resolvedCornerRadius: CGFloat {
        cornerRadius ?? configuration.imageConfiguration.defaultCornerRadius
    }

    /// The resolved content mode of the image.
    var resolvedContentMode: ContentMode {
        contentMode ?? configuration.imageConfiguration.defaultContentMode
    }
}

// MARK: - Modifier Functions

extension PKSImageView {
    
    /// Applies a transformation to the image view and returns a new instance.
    ///
    /// - Parameter closure: A closure that takes an inout copy of the image view and modifies it.
    /// - Returns: A new instance of `PKSImageView` with the modifications applied.
    private func mapImage(_ closure: (inout PKSImageView) -> Void) -> PKSImageView {
        var copy = self
        closure(&copy)
        return copy
    }

    /// Sets the size of the image view.
    ///
    /// Use this function to change the size of the image view.
    ///
    /// - Parameter size: The new size for the image view.
    /// - Returns: A `PKSImageView` instance with the updated size.
    public func imageSize(_ size: CGSize) -> PKSImageView {
        mapImage { $0.readedSize = size }
    }

    /// Sets the aspect ratio of the image.
    ///
    /// Use this function to change the aspect ratio of the image.
    ///
    /// - Parameter aspectRatio: The new aspect ratio for the image.
    /// - Returns: A `PKSImageView` instance with the updated aspect ratio.
    public func imageAspectRatio(_ aspectRatio: CGFloat) -> PKSImageView {
        mapImage { $0.aspectRatio = aspectRatio }
    }
    
    /// Sets the border color of the image view.
    ///
    /// Use this function to change the border color of the image view.
    ///
    /// - Parameter color: The new border color for the image view.
    /// - Returns: A `PKSImageView` instance with the updated border color.
    public func imageBorderColor(_ color: Color) -> PKSImageView {
        mapImage { $0.borderColor = color }
    }

    /// Sets the border width of the image view.
    ///
    /// Use this function to change the border width of the image view.
    ///
    /// - Parameter width: The new border width for the image view.
    /// - Returns: A `PKSImageView` instance with the updated border width.
    public func imageBorderWidth(_ width: CGFloat) -> PKSImageView {
        mapImage { $0.borderWidth = width }
    }

    /// Sets the corner radius of the image view.
    ///
    /// Use this function to change the corner radius of the image view.
    ///
    /// - Parameter radius: The new corner radius for the image view.
    /// - Returns: A `PKSImageView` instance with the updated corner radius.
    public func imageCornerRadius(_ radius: CGFloat) -> PKSImageView {
        mapImage { $0.cornerRadius = radius }
    }

    /// Sets the content mode of the image.
    ///
    /// Use this function to change the content mode of the image.
    ///
    /// - Parameter mode: The new content mode for the image.
    /// - Returns: A `PKSImageView` instance with the updated content mode.
    public func imageContentMode(_ mode: ContentMode) -> PKSImageView {
        mapImage { $0.contentMode = mode }
    }

    /// Sets the priority of the image request.
    ///
    /// Use this function to specify the priority of the image request used to load the image.
    ///
    /// - Parameter priority: The new image request priority.
    /// - Returns: A `PKSImageView` instance with the updated image request priority.
    public func imagePriority(_ priority: ImageRequest.Priority) -> PKSImageView {
        mapImage { $0.priority = priority }
    }

    /// Sets the fixed size of the image view.
    ///
    /// Use this function to change the fixed size of the image view.
    ///
    /// - Parameter size: The new fixed size for the image view.
    /// - Returns: A `PKSImageView` instance with the updated fixed size.
    public func imageFixedSize(_ size: CGSize) -> PKSImageView {
        mapImage { $0.fixedSize = size }
    }

    /// Sets the alignment of the image within its frame.
    ///
    /// Use this function to change the alignment of the image within its frame.
    ///
    /// - Parameter alignment: The new alignment for the image.
    /// - Returns: A `PKSImageView` instance with the updated alignment.
    public func imageAlignment(_ alignment: Alignment) -> PKSImageView {
        mapImage { $0.alignment = alignment }
    }

    /// Sets a custom loading view to be displayed while the image is loading.
    ///
    /// Use this function to provide a custom loading view that will be displayed while the image is being loaded.
    ///
    /// - Parameter loadingView: A closure that returns the custom loading view.
    /// - Returns: A `PKSImageView` instance with the updated loading view.
    public func imageLoadingView(@ViewBuilder loadingView: @escaping () -> LoadingView) -> PKSImageView {
        mapImage { $0.loadingView = loadingView }
    }

    /// Sets a custom error view to be displayed if the image fails to load.
    ///
    /// Use this function to provide a custom error view that will be displayed if the image cannot be loaded.
    ///
    /// - Parameter errorView: A closure that returns the custom error view.
    /// - Returns: A `PKSImageView` instance with the updated error view.
    public func imageErrorView(@ViewBuilder errorView: @escaping () -> ErrorView) -> PKSImageView {
        mapImage { $0.errorView = errorView }
    }
    
}


// MARK: - Previews

#Preview {
    Group {
        PKSImageView(url: URL(string: "https://picsum.photos/200/300")!)

    }
    
}
