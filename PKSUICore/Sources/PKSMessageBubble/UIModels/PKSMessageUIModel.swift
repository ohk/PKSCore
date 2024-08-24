//
//  PKSMessageUIModel.swift
//  
//
//  Created by Ömer Hamid Kamışlı on 8/17/24.
//

import Foundation

public struct PKSMessageUIModel {
    var text: String?
    var image: URL?
    var date: Date
    var isOwner: Bool
    var user: PKSAvatarUIModel?
    var status: PKSMessageStatus
}

public extension PKSMessageUIModel {
    static var mockOnlyText: Self {
        .init(text: "Hello World", image: nil, date: Date(timeIntervalSince1970: 10000000), isOwner: true, user: .mockWithOutImage, status: .none)
    }

    static var mockTomorrowOnlyText: Self {
        .init(text: "Hello World", image: nil, date: Date(), isOwner: true, user: .mockWithOutImage, status: .none)
    }
}
