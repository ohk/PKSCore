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
                string: ""
            )
        )
    }
}
