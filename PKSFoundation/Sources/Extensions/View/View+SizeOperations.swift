//
//  View+SizeOperations.swift
//
//
//  Created by Ömer Hamid Kamışlı on 8/25/24.
//

import SwiftUI

public struct SizePreferenceKey: PreferenceKey {
    
    /// The default value for the size preference key.
    ///
    /// The default value is `CGSize.zero`.
    public static var defaultValue: CGSize = .zero

    /// Combines the provided size values to produce a new value.
    ///
    /// This method is used to reduce multiple size values into a single size value.
    ///
    /// - Parameters:
    ///   - value: The current value to be updated.
    ///   - nextValue: A closure that returns the next size value to combine.
    public static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}

public extension View {
    
    /// Reads the size of a view and triggers a callback when the size changes.
    ///
    /// Use `readSize(onChange:)` to monitor the size of a view. The size is measured
    /// using a `GeometryReader`, and the provided callback is executed whenever the
    /// size changes.
    ///
    /// Example usage:
    ///
    /// ```swift
    /// SomeView()
    ///     .readSize { newSize in
    ///         print("New size: \(newSize)")
    ///     }
    /// ```
    ///
    /// - Parameter onChange: A closure that is called with the new size of the view.
    /// - Returns: A modified view that monitors its size.
    func readSize(onChange: @escaping (CGSize) -> Void) -> some View {
        background(
            GeometryReader { geometry in
                Color.clear
                    .preference(key: SizePreferenceKey.self, value: geometry.size)
            }
        )
        .onPreferenceChange(SizePreferenceKey.self, perform: onChange)
    }

    /// Binds the size of a view to a `Binding<CGSize>` instance.
    ///
    /// Use `getSize(_:)` to bind the size of a view to a `Binding` so that the size
    /// is updated automatically whenever the view's size changes.
    ///
    /// Example usage:
    ///
    /// ```swift
    /// @State private var viewSize: CGSize = .zero
    ///
    /// SomeView()
    ///     .getSize($viewSize)
    /// ```
    ///
    /// - Parameter size: A `Binding` to a `CGSize` instance that will be updated with the view's size.
    /// - Returns: A modified view that monitors its size and updates the binding.
    func getSize(_ size: Binding<CGSize>) -> some View {
        readSize { readedSize in
            size.wrappedValue = readedSize
        }
    }
}
