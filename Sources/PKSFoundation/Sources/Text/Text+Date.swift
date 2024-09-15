//
//  Text+Date.swift
//  PKSFoundation
//
//  Created by Ömer Hamid Kamışlı on 8/24/24.
//

import SwiftUI
import Foundation

public extension Text {
    /// Creates a text view that displays a formatted date using the specified style.
    /// If the date is nil, no text view is created.
    /// - Parameters:
    ///   - date: The optional date to be displayed.
    ///   - style: The style used to format the date.
    init?(_ date: Date?, style: PKSDateStyle) {
        guard let date = date else { return nil }
        let formattedString = style.formatted(date: date)
        self.init(verbatim: formattedString)
    }
}
