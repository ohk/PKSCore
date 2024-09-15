//
//  Date+Ext.swift
//
//
//  Created by Ömer Hamid Kamışlı on 8/24/24.
//

import Foundation

@available(iOS 12.0, macOS 10.12, tvOS 12.0, watchOS 4.0, visionOS 1.0, *)
public extension Date {
    
    /// The date representing the next day.
    ///
    /// This property calculates the date that is exactly one day after the current date.
    /// If the calculation fails, it returns the current date.
    ///
    /// Example usage:
    ///
    /// ```swift
    /// let today = Date()
    /// let nextDay = today.nextDay
    /// ```
    ///
    /// - Returns: A `Date` instance representing the next day.
    var nextDay: Date {
        Calendar.current.date(byAdding: .day, value: 1, to: self) ?? self
    }

    /// The date representing the previous day.
    ///
    /// This property calculates the date that is exactly one day before the current date.
    /// If the calculation fails, it returns the current date.
    ///
    /// Example usage:
    ///
    /// ```swift
    /// let today = Date()
    /// let previousDay = today.previousDay
    /// ```
    ///
    /// - Returns: A `Date` instance representing the previous day.
    var previousDay: Date {
        Calendar.current.date(byAdding: .day, value: -1, to: self) ?? self
    }

    /// The date representing tomorrow.
    ///
    /// This property calculates the date that is exactly one day after the current date.
    /// It is a convenience property that uses the `nextDay` property.
    ///
    /// Example usage:
    ///
    /// ```swift
    /// let tomorrow = Date().tomorrow
    /// ```
    ///
    /// - Returns: A `Date` instance representing tomorrow.
    var tomorrow: Date {
        Date().nextDay
    }

    /// The date representing yesterday.
    ///
    /// This property calculates the date that is exactly one day before the current date.
    /// It is a convenience property that uses the `previousDay` property.
    ///
    /// Example usage:
    ///
    /// ```swift
    /// let yesterday = Date().yesterday
    /// ```
    ///
    /// - Returns: A `Date` instance representing yesterday.
    var yesterday: Date {
        Date().previousDay
    }
}
