//
//  View+MapExtension.swift
//
//
//  Created by Ömer Hamid Kamışlı on 8/25/24.
//

import SwiftUI

public extension View {
    /// Transforms the view into another view using a closure.
    ///
    /// Use the `map(_:)` function to apply a transformation to a view,
    /// returning a new view type based on the original view.
    ///
    /// Example usage:
    ///
    /// ```swift
    /// let transformedView = Text("Hello, World!").map { $0.foregroundColor(.red) }
    /// ```
    ///
    /// - Parameter transform: A closure that takes the original view as input
    ///   and returns a new view.
    /// - Returns: A new view type resulting from the transformation.
    func map<T: View>(_ transform: @escaping (Self) -> T) -> T {
        return transform(self)
    }
}
