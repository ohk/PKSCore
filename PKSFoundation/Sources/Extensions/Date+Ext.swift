//
//  Date+Ext.swift
//
//
//  Created by Ömer Hamid Kamışlı on 8/24/24.
//

import Foundation

public extension Date {
    /**
     Returns the date representing tomorrow.
     
     - Returns: The date representing tomorrow.
     */
    var tomorrow: Date {
        Calendar.current.date(byAdding: .day, value: 1, to: self) ?? self
    }

    /**
     Returns the date representing yesterday.
     
     - Returns: The date representing yesterday.
     */
    var yesterday: Date {
        Calendar.current.date(byAdding: .day, value: -1, to: self) ?? self
    }
}