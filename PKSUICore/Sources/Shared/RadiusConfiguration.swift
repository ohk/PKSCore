//
//  RadiusConfiguration.swift
//
//
//  Created by Ömer Hamid Kamışlı on 8/24/24.
//

import Foundation

public struct RadiusConfiguration {
    public var sm = 4
    public var md = 8
    public var lg = 12
    public var xl = 16
    public var xxl = 20
    public var full = 100

    public init(
        sm: Int = 4,
        md: Int = 8,
        lg: Int = 12,
        xl: Int = 16,
        xxl: Int = 20,
        full: Int = 100
    ) {
        self.sm = sm
        self.md = md
        self.lg = lg
        self.xl = xl
        self.xxl = xxl
        self.full = full
    }


}
