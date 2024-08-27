//
//  PKSMessageUserUIModel.swift
//
//
//  Created by Ömer Hamid Kamışlı on 8/17/24.
//

import Foundation

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public struct PKSAvatarUIModel: Identifiable {
    
    /// The unique identifier for the avatar model.
    ///
    /// This identifier is used to distinguish between different avatar models.
    public var id: String
    
    /// The name associated with the avatar.
    ///
    /// This is an optional property that can be used to store the name of the person or entity represented by the avatar.
    public var name: String?
    
    /// The initials associated with the avatar.
    ///
    /// This is an optional property that can be used to store the initials of the name for display purposes.
    public var initials: String?
    
    /// The URL of the avatar's image.
    ///
    /// This is an optional property that stores the URL of the image to be used for the avatar.
    public var image: URL?
    
    // MARK: - Initializer
    
    /// Initializes a new `PKSAvatarUIModel` with the specified properties.
    ///
    /// Use this initializer to create a new avatar model with optional name, initials, and image URL.
    ///
    /// - Parameters:
    ///   - id: The unique identifier for the avatar model. Defaults to a new UUID string.
    ///   - name: The name associated with the avatar. Defaults to `nil`.
    ///   - initials: The initials associated with the avatar. Defaults to `nil`.
    ///   - image: The URL of the avatar's image. Defaults to `nil`.
    public init(
        id: String = UUID().uuidString,
        name: String? = nil,
        initials: String? = nil,
        image: URL? = nil
    ) {
        self.id = id
        self.name = name
        self.initials = initials
        self.image = image
    }
}


@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public extension PKSAvatarUIModel {
    
    /// A mock `PKSAvatarUIModel` instance without an image.
    ///
    /// This mock instance is useful for testing or preview purposes when you want to represent an avatar without an image.
    static var mockWithOutImage: Self {
        .init(
            name: "Omer Hamid Kamisli",
            initials: "OHK",
            image: URL(string: "")
        )
    }
    
    /// A mock `PKSAvatarUIModel` instance with an image.
    ///
    /// This mock instance is useful for testing or preview purposes when you want to represent an avatar with an image.
    static var mockWithImage: Self {
        .init(
            name: "Omer Hamid Kamisli",
            initials: "OHK",
            image: URL(string: "https://plus.unsplash.com/premium_photo-1688740375397-34605b6abe48?q=80&w=3035&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D")
        )
    }
    
    /// An array containing different avatar model options.
    ///
    /// This array provides a collection of different avatar configurations, labeled with a string identifier.
    /// It is useful for testing or for displaying different avatar options in a UI.
    ///
    /// - Returns: An array of tuples containing a string label and a `PKSAvatarUIModel` instance.
    static var allOptions: [(String, Self)] {
        return [
            ("With Image", .mockWithImage),
            ("Without Image", .mockWithOutImage)
        ]
    }
}

