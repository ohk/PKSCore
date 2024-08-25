//
//  RadiusConfiguration.swift
//
//
//  Created by Ömer Hamid Kamışlı on 8/24/24.
//

import Foundation

public struct RadiusConfiguration {
    public var sm: CGFloat = 4
    public var md: CGFloat = 8
    public var lg: CGFloat = 12
    public var xl: CGFloat = 16
    public var xxl: CGFloat = 20
    public var full: CGFloat = 100

    public init(
        sm: CGFloat = 4,
        md: CGFloat = 8,
        lg: CGFloat = 12,
        xl: CGFloat = 16,
        xxl: CGFloat = 20,
        full: CGFloat = 100
    ) {
        self.sm = sm
        self.md = md
        self.lg = lg
        self.xl = xl
        self.xxl = xxl
        self.full = full
    }


}
