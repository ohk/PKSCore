//
//  PKSDateStyle.swift
//
//
//  Created by Ömer Hamid Kamışlı on 8/24/24.
//

import Foundation

public enum PKSBaseDateStyle: PKSDateStyle {
    case date // 12/31/21
    case time // 12:00 PM
    case relative // Today, Yesterday, Tomorrow, etc.
    case full // 12/31/21 12:00 PM
    case custom(String) // Custom format
    case chatRelative // Custom Format for Chat Messages

    public func formatted(date: Date) -> String {
        let formatter = DateFormatter()
       
        switch self {
        case .date:
            formatter.dateStyle = .short
            formatter.timeStyle = .none
        case .time:
            formatter.dateStyle = .none
            formatter.timeStyle = .short
        case .relative:
            formatter.dateStyle = .medium
            formatter.timeStyle = .none
            formatter.doesRelativeDateFormatting = true
        case .full:
            formatter.dateStyle = .short
            formatter.timeStyle = .short
        case .custom(let format):
            formatter.dateFormat = format
        case .chatRelative:
            let calendar = Calendar.current
            
            if calendar.isDateInToday(date) {
                let timeFormat = DateFormatter.dateFormat(fromTemplate: "j", options: 0, locale: Locale.current)!
                formatter.dateFormat = timeFormat.contains("a") ? "h:mm a" : "HH:mm"
            } else if calendar.isDateInYesterday(date) {
                return "Yesterday"
            } else if calendar.isDateInTomorrow(date) {
                return "Tomorrow"
            } else {
                formatter.dateFormat = "MMM d"
            }
        }

        return formatter.string(from: date)
    }
}
