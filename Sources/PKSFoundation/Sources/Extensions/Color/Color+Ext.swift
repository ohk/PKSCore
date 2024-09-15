//
//  Color+Ext.swift
//
//
//  Created by Ömer Hamid Kamışlı on 8/25/24.
//

import SwiftUI

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public extension Color {
    
    /// Creates a `Color` from a hexadecimal string.
    ///
    /// Use this method to create a `Color` instance from a hexadecimal color code.
    /// The hexadecimal string can optionally start with a `#`, and it should
    /// represent a color in the format `RRGGBB`.
    ///
    /// Example usage:
    ///
    /// ```swift
    /// let color = Color.hex("#FF5733")
    /// ```
    ///
    /// - Parameter hex: The hexadecimal string representing the color.
    /// - Returns: A `Color` instance corresponding to the provided hexadecimal string.
    static func hex(_ hex: String) -> Color {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0

        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        let red = Double((rgb & 0xFF0000) >> 16) / 255.0
        let green = Double((rgb & 0x00FF00) >> 8) / 255.0
        let blue = Double(rgb & 0x0000FF) / 255.0

        return Color(red: red, green: green, blue: blue)
    }

    /// Creates a `Color` from a hexadecimal string with a specified opacity.
    ///
    /// Use this method to create a `Color` instance from a hexadecimal color code
    /// and a custom opacity value. The hexadecimal string can optionally start with a `#`,
    /// and it should represent a color in the format `RRGGBB`.
    ///
    /// Example usage:
    ///
    /// ```swift
    /// let colorWithAlpha = Color.hex("#FF5733", alpha: 0.5)
    /// ```
    ///
    /// - Parameters:
    ///   - hex: The hexadecimal string representing the color.
    ///   - alpha: The opacity value of the color, specified as a `Double` between `0.0` and `1.0`.
    /// - Returns: A `Color` instance corresponding to the provided hexadecimal string and opacity.
    static func hex(_ hex: String, alpha: Double) -> Color {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0

        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        let red = Double((rgb & 0xFF0000) >> 16) / 255.0
        let green = Double((rgb & 0x00FF00) >> 8) / 255.0
        let blue = Double(rgb & 0x0000FF) / 255.0

        return Color(red: red, green: green, blue: blue, opacity: alpha)
    }

    /// A random color.
    ///
    /// Use this property to generate a random `Color`. The color is generated with
    /// random values for red, green, and blue, each between `0.0` and `1.0`.
    ///
    /// Example usage:
    ///
    /// ```swift
    /// let randomColor = Color.random
    /// ```
    ///
    /// - Returns: A `Color` instance with random red, green, and blue values.
    static var random: Color {
        return Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1)
        )
    }

    /// A color that provides the best contrast against the current color.
    ///
    /// The `visibleTextColor` property calculates the luminance of the current color
    /// and returns either white or black to ensure optimal contrast for text visibility.
    ///
    /// This property is useful when dynamically adjusting text color based on the
    /// background color to maintain readability.
    ///
    /// Example usage:
    ///
    /// ```swift
    /// let backgroundColor = Color.red
    /// let textColor = backgroundColor.visibleTextColor
    /// ```
    ///
    /// - Returns: A `Color` instance that is either `.white` or `.black`, depending on the luminance of the current color.
    var visibleTextColor: Color {
        // Extract RGB components
        let components = self.cgColor?.components ?? [0, 0, 0, 1]
        
        let red = components[0]
        let green = components[1]
        let blue = components[2]
        
        // Calculate luminance
        let luminance = 0.299 * red + 0.587 * green + 0.114 * blue
        
        // Return white for dark colors and black for light colors
        return luminance > 0.5 ? .black : .white
    }

}
