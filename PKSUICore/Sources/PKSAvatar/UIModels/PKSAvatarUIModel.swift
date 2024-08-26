//
//  PKSMessageUserUIModel.swift
//
//
//  Created by Ömer Hamid Kamışlı on 8/17/24.
//

import Foundation

public struct PKSAvatarUIModel: Identifiable {
    public var id: String
    var name: String?
    var initials: String?
    var image: URL?
    
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

public extension PKSAvatarUIModel {
    static var mockWithOutImage: Self {
        .init(
            name: "Omer Hamid Kamisli",
            initials: "OHK",
            image: URL(
                string: ""
            )
        )
    }
    
    static var mockWithImage: Self {
        .init(
            name: "Omer Hamid Kamisli",
            initials: "OHK",
            image: URL(
                string: "https://plus.unsplash.com/premium_photo-1688740375397-34605b6abe48?q=80&w=3035&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
            )
        )
    }
    
    static var allOptions: [(String, Self)] {
        return [
            ("With Image", .mockWithImage),
            ("Without Image", .mockWithOutImage)
        ]
    }
}
