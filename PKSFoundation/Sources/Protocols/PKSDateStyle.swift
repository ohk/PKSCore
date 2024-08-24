//
//  PKSDateStyle.swift
//
//
//  Created by Ömer Hamid Kamışlı on 8/24/24.
//

import Foundation

public protocol PKSDateStyle {
    func formatted(date: Date) -> String
}
